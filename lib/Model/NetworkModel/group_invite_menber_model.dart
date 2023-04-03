import 'dart:convert';

import 'package:flutter/cupertino.dart';

GroupInviteMenberModel groupInviteMenberModelFromJson(String str) =>
    GroupInviteMenberModel.fromJson(json.decode(str));

String groupInviteMenberModelToJson(GroupInviteMenberModel data) =>
    json.encode(data.toJson());

class GroupInviteMenberModel {
  GroupInviteMenberModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int? code;
  String? message;
  List<Datum>? data;
  int? totalCount;

  factory GroupInviteMenberModel.fromJson(Map<String, dynamic> json) =>
      GroupInviteMenberModel(
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
    this.email,
    this.lastName,
    this.firstName,
    this.isMember,
    this.isChecked,
    this.status,
  });

  String? id;
  String? email;
  String? lastName;
  String? firstName;
  bool? isMember;
  bool? isChecked;
  String? status;

  var counts = 0;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        email: json["email"],
        lastName: json["lastName"],
        firstName: json["firstName"],
        isMember: json["isMember"],
        isChecked: json['isChecked'],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "lastName": lastName,
        "firstName": firstName,
        "isMember": isMember,
        "isChecked": isChecked,
        "status": status,
      };

  CheckInvitedMenber(bool value) {
    isChecked = value;

    notifyListeners();
  }

}
