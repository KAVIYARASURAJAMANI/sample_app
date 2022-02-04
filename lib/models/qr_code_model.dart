// To parse this JSON data, do
//
//     final qrSnapDataModel = qrSnapDataModelFromJson(jsonString);

import 'dart:convert';

QrSnapDataModel qrSnapDataModelFromJson(String str) =>
    QrSnapDataModel.fromJson(json.decode(str));

String qrSnapDataModelToJson(QrSnapDataModel data) =>
    json.encode(data.toJson());

class QrSnapDataModel {
  QrSnapDataModel({
    required this.randomNumber,
    required this.qrImage,
    required this.uniqueKey,
  });

  String randomNumber;
  String qrImage;
  String uniqueKey;

  factory QrSnapDataModel.fromJson(Map<String, dynamic> json) =>
      QrSnapDataModel(
        randomNumber: json["randomNumber"],
        qrImage: json["qrImage"],
        uniqueKey: json["uniqueKey"],
      );

  Map<String, dynamic> toJson() => {
        "randomNumber": randomNumber,
        "qrImage": qrImage,
      };
}
