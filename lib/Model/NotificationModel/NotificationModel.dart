// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';


NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int? code;
  String? message;
  List<Datum>? data;
  int? totalCount;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalCount": totalCount,
      };
}

class Datum extends ChangeNotifier {
  Datum({
    this.id,
    this.title,
    this.type,
    this.module,
    this.message,
    this.sender,
    this.typeId,
    this.createdAt,
    this.isReaded,
    this.receiverImage,
    this.receiverName,
  });

  String? id;
  dynamic title;
  String? type;
  String? module;
  String? message;
  String? sender;
  String? typeId;
  DateTime? createdAt;
  bool? isReaded;
  String? receiverImage;
  String? receiverName;

  factory Datum.fromJson(Map<String, dynamic> json) =>
      Datum(
        id: json["_id"],
        title: json["title"],
        type: json["type"],
        module: json["module"],
        message: json["message"],
        sender: json["sender"],
        typeId: json["type_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        isReaded: json["isReaded"],
        receiverImage: json["receiverImage"],
        receiverName: json["receiverName"],
      );

  Map<String, dynamic> toJson() =>
      {
        "_id": id,
        "title": title,
        "type": type,
        "module": module,
        "message": message,
        "sender": sender,
        "type_id": typeId,
        "createdAt": createdAt!.toIso8601String(),
        "isReaded": isReaded,
        "receiverImage": receiverImage,
        "receiverName": receiverName,
      };

// readNotification(bool value) {
//   isReaded = value;
//   notifyListeners();
// }


// void hitReadNotification() {
//
// }

}