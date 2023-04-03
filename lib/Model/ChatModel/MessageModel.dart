import 'package:flutter/material.dart';

class MessageModel {
  MessageModel({
    this.userData,
    this.messageId,
    this.senderId,
    this.message,
    this.msgTime,
    this.document,
  });
  ChatUserData? userData;
  String? messageId;
  String? senderId;
  String? message;
  DateTime? msgTime;
  List<String>? document;
  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    userData:   ChatUserData.fromJson(json["userData"]),
    messageId: json["message_id"],
    senderId: json["sender_id"],
    message: json["message"],
    msgTime: DateTime.parse(json["msgTime"]),
    document:json["document"]==null?[]: List<String>.from(json["document"].map((x) => x)),
  );
  Map<String, dynamic> toJson() => {
    "userData": userData!.toJson(),
    "message_id": messageId,
    "sender_id": senderId,
    "message": message,
    "msgTime": msgTime!.toIso8601String(),
    "document": List<String>.from(document!.map((x) => x)),
  };
}

class   ChatUserData extends ChangeNotifier {
  ChatUserData({
    this.id,
    this.firstName,
    this.lastName,
    this.image,
  });
  String? id;
  String? firstName;
  String? lastName;
  String? image;
  factory   ChatUserData.fromJson(Map<String, dynamic> json) =>   ChatUserData(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    image: json["image"],
  );
  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "image": image,
  };


}