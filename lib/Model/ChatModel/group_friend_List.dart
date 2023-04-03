// To parse this JSON data, do
//
//     final groupFriendList = groupFriendListFromJson(jsonString);

import 'dart:convert';

GroupFriendList groupFriendListFromJson(String str) => GroupFriendList.fromJson(json.decode(str));

String groupFriendListToJson(GroupFriendList data) => json.encode(data.toJson());

class GroupFriendList {
  GroupFriendList({
this.code,
   this.message,
  this.data,
  });

  int ?code;
  String? message;
  List<Datum>? data;

  factory GroupFriendList.fromJson(Map<String, dynamic> json) => GroupFriendList(
    code: json["code"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
     this.id,
     this.userId,
    this.image,
    this.roleTitle,
   this.personName,
    this.workPlace,
    this.aboutCompany,
  });

  String ?id;
  String ?userId;
  String? image;
  String ?roleTitle;
  String ?personName;
  String? workPlace;
  String? aboutCompany;
  bool isChecked=false;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    userId: json["userId"],
    image: json["image"],
    roleTitle: json["roleTitle"],
    personName: json["personName"],
    workPlace: json["workPlace"],
    aboutCompany: json["aboutCompany"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "image": image,
    "roleTitle": roleTitle,
    "personName": personName,
    "workPlace": workPlace,
    "aboutCompany": aboutCompany,
  };
}
