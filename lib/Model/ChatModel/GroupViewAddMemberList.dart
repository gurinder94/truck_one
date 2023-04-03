// To parse this JSON data, do
//
//     final groupViewAddMemberList = groupViewAddMemberListFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

GroupViewAddMemberList groupViewAddMemberListFromJson(String str) => GroupViewAddMemberList.fromJson(json.decode(str));

String groupViewAddMemberListToJson(GroupViewAddMemberList data) => json.encode(data.toJson());

class GroupViewAddMemberList {
  GroupViewAddMemberList({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String ?message;
  List<Datum>? data;
  int ?totalCount;

  factory GroupViewAddMemberList.fromJson(Map<String, dynamic> json) => GroupViewAddMemberList(
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

class Datum extends ChangeNotifier  {
  Datum({
    this.id,
    this.friendId,
    this.userId,
    this.image,
    this.lastName,
    this.firstName,
    this.alreadyExist,
  });

  String ?id;
  String ?friendId;
  String ?userId;
  String ?image;
  String ?lastName;
  String ?firstName;
  bool ?alreadyExist;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    friendId: json["friendId"],
    userId: json["user_id"],
    image: json["image"] == null ? null : json["image"],
    lastName: json["lastName"],
    firstName: json["firstName"],
    alreadyExist: json["alreadyExist"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "friendId": friendId,
    "user_id": userId,
    "image": image == null ? null : image,
    "lastName": lastName,
    "firstName": firstName,
    "alreadyExist": alreadyExist,
  };





}
