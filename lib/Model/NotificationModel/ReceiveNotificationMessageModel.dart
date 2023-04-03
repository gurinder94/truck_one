// To parse this JSON data, do
//
//     final receiveMessageModel = receiveMessageModelFromJson(jsonString);

import 'dart:convert';

ReceiveMessageModel receiveMessageModelFromJson(String str) => ReceiveMessageModel.fromJson(json.decode(str));

String receiveMessageModelToJson(ReceiveMessageModel data) => json.encode(data.toJson());

class ReceiveMessageModel {
  ReceiveMessageModel({
    this.module,
    this.typeId,
    this.id,
    this.notificationType,
    this.body,
    this.title,
  });

  String ?module;
  String ?typeId;
  String ?id;
  String ?notificationType;
  String ?body;
  String ?title;

  factory ReceiveMessageModel.fromJson(Map<String, dynamic> json) => ReceiveMessageModel(
    module: json["MODULE"],
    typeId: json["type_id"],
    id: json["_id"],
    notificationType: json["notificationType"],
    body: json["body"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "MODULE": module,
    "type_id": typeId,
    "_id": id,
    "notificationType": notificationType,
    "body": body,
    "title": title,
  };
}
