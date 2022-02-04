import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:task/provider/user_provider.dart';
import 'package:task/res/res.dart';
import 'package:task/router/route_names.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late FirebaseAuth auth;
  late User? user;

  Position? currentPosition;
  String? currentAddress;

  Future<Position> getPosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.deniedForever) {
        return Future.error("Location not available");
      } else {
        log("Location not available");
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future getAddress(longitute, latitute) async {
    try {
      List<Placemark> placemark = await GeocodingPlatform.instance
          .placemarkFromCoordinates(latitute, longitute);
      Placemark place = placemark[0];
      currentAddress = place.street;
      context.read(userProvider).setLocation(locationCity: currentAddress!);
      log("currentAddress! :::: ${currentAddress!}");
    } catch (e) {
      log("Error Address ::: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      initializeResources(context: context);
      getLocation();
    });
  }

  getLocation() async {
    currentPosition = await getPosition();
    await getAddress(currentPosition!.longitude, currentPosition!.latitude);
    initialize();
  }

  Future initialize() async {
    // user = auth.currentUser;
    // if (user != null) {
    //   Navigator.pushReplacementNamed(context, Routes.home);
    // } else {
    Navigator.pushReplacementNamed(context, Routes.login);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Image.asset("assets/images/logo.png",
                    height: 100, width: 100)),
          ],
        ),
      ),
    );
  }
}

enum _PositionItemType {
  log,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}
