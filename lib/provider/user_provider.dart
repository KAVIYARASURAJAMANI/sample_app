import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:task/global/preferences.dart';
import 'package:task/locator/locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/models/user_model.dart';
import 'package:task/provider/core/default_change_notifier.dart';
import 'package:task/res/res.dart';
import 'package:task/router/route_names.dart';
import 'package:task/shared_widgets/snack_bar.dart';
import 'package:uuid/uuid.dart';
import 'package:task/utils/functions.dart';

final userProvider = ChangeNotifierProvider((ref) => UserProvider(ref.read));

class UserProvider extends DefaultChangeNotifier {
  final pref = locator<Preferences>();
  final Reader ref;
  UserProvider(this.ref);

  TextEditingController phoneNoController = TextEditingController();
  TextEditingController otpNoController = TextEditingController();
  String? phoneNoError, otpError;
  bool isOtpEnable = false;
  bool get osOtpFieldEnable => isOtpEnable;
  String location = "";
  String get currentLocation => location;
  String randomNumber = "";
  String get randomNum => randomNumber;
  DocumentSnapshot? loginSnap;
  DocumentSnapshot? get loginSnapshot => loginSnap;
  List<UserSnapDataModel>? userSnapDataModel;
  List<UserSnapDataModel>? get getUserSnapDataModel => userSnapDataModel;
  String userUniqueId = "";
  String get uniqueKey => userUniqueId;

  randomNumCreate() {
    randomNumber = getRandomNumbericString(length: 5);
  }

  fetchLoginDetails() async {
    userSnapDataModel = [];
    try {
      toggleLoadingOn(true);
      QuerySnapshot reference = await firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("signin")
          .get();
      for (var item in reference.docs) {
        userSnapDataModel!.add(
            UserSnapDataModel.fromJson((item.data()) as Map<String, dynamic>));
      }
      log(userSnapDataModel![0].lastSignInTime);
    } catch (e) {
      log("ERROR ::::  $e");
    } finally {
      toggleLoadingOn(false);
    }

    // userSnapDataModel =
    //     UserSnapDataModel.fromJson((loginSnap!.data()) as Map<String, dynamic>);
    // log("SNAP DATA ::: ${userSnapDataModel!.lastSignInTime}");
    notifyListeners();
  }

  Future fetchUniqueId() async {
    var uid = Uuid();
    userUniqueId = uid.v1();
    log(userUniqueId);
    notifyListeners();
  }

  void changeState() {
    isOtpEnable = true;
    notifyListeners();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future verifyPhoneNumber({
    required BuildContext context,
  }) async {
    try {
      if (phoneNoController.text.isEmpty) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(errorSnackBar("Please enter your phone number"));
      } else if (phoneNoController.text.toString().trim().length != 10) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            errorSnackBar("Please enter your 10 digit mobile number"));
      } else {
        await auth.verifyPhoneNumber(
          phoneNumber: "+91${phoneNoController.text.toString().trim()}",
          verificationCompleted: (PhoneAuthCredential credential) {
            log(credential.smsCode.toString());
          },
          verificationFailed: (FirebaseAuthException e) {
            log("Error :::: $e");
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(errorSnackBar("$e"));
          },
          codeSent: (String verificationId, int? resendToken) {
            log("CODE ID ::: $verificationId");
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context)
                .showSnackBar(successSnackBar("OTP send Successfully"));
            pref.setUserId(verificationId);
            changeState();
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      }
    } catch (e) {
      log("Error VerifyPhone Number $e");
    } finally {}
    notifyListeners();
  }

  Future signinWithAuth({
    required BuildContext context,
  }) async {
    try {
      log("CODE ID ::: ${pref.userId}");
      if (otpNoController.text.isEmpty) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(errorSnackBar("Please enter OTP"));
      } else if (otpNoController.text.toString().trim().length != 6) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(errorSnackBar("Please enter 6 digit OTP"));
      } else {
        toggleLoadingOn(true);
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
            verificationId: pref.userId!, smsCode: otpNoController.text.trim());
        final authCredential =
            await auth.signInWithCredential(phoneAuthCredential);
        if (authCredential.user!.uid != "null" &&
            authCredential.user!.uid != "") {
          String ip = await Ipify.ipv4();
          await fetchUniqueId();
          await firestore
              .collection("users")
              .doc(authCredential.user!.uid)
              .collection("signin")
              .doc(uniqueKey)
              .set({
            'userId': authCredential.user!.uid,
            'ip': ip,
            'location': currentLocation,
            'creationTime': authCredential.user!.metadata.creationTime,
            'lastSignInTime': authCredential.user!.metadata.lastSignInTime,
            'uniqueKey': uniqueKey
          });
          randomNumCreate();
          await fetchLoginDetails();
          Navigator.pushReplacementNamed(context, Routes.home);
        }
      }
    } catch (e) {
      log("Error VerifyPhone Number $e");
    } finally {
      toggleLoadingOn(false);
    }
    notifyListeners();
  }

  Future<Uint8List> toQrImageData(String text) async {
    try {
      final image = await QrPainter(
        data: text,
        version: QrVersions.auto,
        gapless: false,
        color: colors.kColorBlack,
        emptyColor: colors.kColorWhite,
      ).toImage(300);
      final a = await image.toByteData(format: ImageByteFormat.png);
      return a!.buffer.asUint8List();
    } catch (e) {
      log("ERROR IMAGE :::: $e");
      throw e;
    }
  }

  Future<String> uploadQrToStorage(String childName, Uint8List file) async {
    Reference ref = storage.ref().child(childName).child(auth.currentUser!.uid);
    var uid = const Uuid();
    String uniqueId = uid.v1();
    ref = ref.child(uniqueId);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    log("DOWNLOAD URL :::: $downloadUrl");
    return downloadUrl;
  }

  Future uploadQrDetails({required BuildContext context}) async {
    try {
      toggleLoadingOn(true);
      String imageUrl =
          await uploadQrToStorage("qrimage", await toQrImageData(randomNum));
      await firestore
          .collection("signin")
          .doc(auth.currentUser!.uid)
          .collection("savedqr")
          .doc(uniqueKey)
          .set({
        'randomNumber': randomNum,
        'qrImage': imageUrl,
        'uniqueKey': uniqueKey,
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(successSnackBar("QR Images saved Successfully"));
    } catch (e) {
      log("ERROR Upload Qr data $e");
    } finally {
      toggleLoadingOn(false);
    }
  }

  Future logout({required BuildContext context}) async {
    await auth.signOut();
    pref.clearLocalPref();
    await Phoenix.rebirth(context);
  }

  void setLocation({required String locationCity}) {
    location = locationCity;
    notifyListeners();
  }
}
