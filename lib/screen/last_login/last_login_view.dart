import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task/global/preferences.dart';
import 'package:task/locator/locator.dart';
import 'package:task/models/qr_code_model.dart';
import 'package:task/models/user_model.dart';
import 'package:task/provider/core/default_change_notifier.dart';
import 'package:task/provider/user_provider.dart';

final lastloginViewProvider =
    ChangeNotifierProvider.autoDispose((ref) => LastLoginViewModel(ref.read));

class LastLoginViewModel extends DefaultChangeNotifier {
  final pref = locator<Preferences>();
  final Reader ref;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  LastLoginViewModel(this.ref);
  final List<String> tabs = [
    'TODAY',
    'Yesterday',
    'Other',
  ];

  DocumentSnapshot? loginSnap;
  DocumentSnapshot? get loginSnapshot => loginSnap;
  List<QrSnapDataModel>? userSnapDataModel;
  List<QrSnapDataModel>? get getUserSnapDataModel => userSnapDataModel;
  List<UserSnapDataModel>? todayList;
  List<UserSnapDataModel>? yesterdayList;
  List<UserSnapDataModel>? otherList;
  List<UserSnapDataModel>? get todaysList => todayList;
  List<UserSnapDataModel>? get yesterdaysList => yesterdayList;
  List<UserSnapDataModel>? get othersList => otherList;
  List<UserSnapDataModel>? loginUserInfo;
  List<UserSnapDataModel>? get loginUserInfoList => loginUserInfo;
  DateTime now = DateTime.now();
  String formattedDate = "";
  String formattedYesterday = "";

  fetchSigninDetails() async {
    try {
      toggleLoadingOn(true);
      userSnapDataModel = [];
      formattedDate = DateFormat('d-MM-y').format(now);
      formattedYesterday = DateFormat('d-MM-y')
          .format(DateTime.now().subtract(const Duration(days: 1)));
      log(formattedYesterday);
      loginUserInfo = ref(userProvider).getUserSnapDataModel!;
      QuerySnapshot reference = await firestore
          .collection("signin")
          .doc(auth.currentUser!.uid)
          .collection("savedqr")
          .get();
      for (var item in reference.docs) {
        userSnapDataModel!.add(
            QrSnapDataModel.fromJson((item.data()) as Map<String, dynamic>));
      }

      await addQrImageToLogin();
      await splitDaysWise();

      log(userSnapDataModel![0].qrImage);
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

  addQrImageToLogin() async {
    for (var item in loginUserInfoList!) {
      for (var item1 in userSnapDataModel!) {
        if (item.uniqueKey == item1.uniqueKey) {
          item.randomNumber = item1.randomNumber;
          item.qrImage = item1.qrImage;
        }
      }
    }
  }

  splitDaysWise() async {
    todayList = [];
    yesterdayList = [];
    otherList = [];
    for (var item in loginUserInfoList!) {
      if (item.lastSignInTime.split(",")[0] == formattedDate) {
        todayList!.add(item);
      } else if (item.lastSignInTime.split(",")[0] == formattedYesterday) {
        yesterdayList!.add(item);
      } else {
        otherList!.add(item);
      }
    }
  }
}
