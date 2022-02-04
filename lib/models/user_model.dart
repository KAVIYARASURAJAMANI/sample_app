// To parse this JSON data, do
//
//     final userSnapDataModel = userSnapDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:task/utils/functions.dart';

UserSnapDataModel userSnapDataModelFromJson(String str) =>
    UserSnapDataModel.fromJson(json.decode(str));

String userSnapDataModelToJson(UserSnapDataModel data) =>
    json.encode(data.toJson());

class UserSnapDataModel {
  UserSnapDataModel({
    required this.lastSignInTime,
    required this.creationTime,
    required this.ip,
    required this.location,
    required this.userId,
    required this.uniqueKey,
    this.randomNumber,
    this.qrImage,
  });

  String lastSignInTime;
  String creationTime;
  String ip;
  String location;
  String userId;
  String uniqueKey;
  String? randomNumber;
  String? qrImage;

  factory UserSnapDataModel.fromJson(Map<String, dynamic> json) {
    String lastSignInVal = formatTimestamp(json["lastSignInTime"] ?? '');
    String creationTimeVal = formatTimestamp(json["creationTime"] ?? '');
    const String randomNoVal = "";
    const String qrImageVal = "";
    return UserSnapDataModel(
      lastSignInTime: lastSignInVal,
      creationTime: creationTimeVal,
      ip: json["ip"],
      location: json["location"],
      userId: json["userId"],
      uniqueKey: json["uniqueKey"],
      qrImage: qrImageVal,
      randomNumber: randomNoVal,
    );
  }

  Map<String, dynamic> toJson() => {
        "lastSignInTime": lastSignInTime,
        "creationTime": creationTime,
        "ip": ip,
        "location": location,
        "userId": userId,
      };
}
