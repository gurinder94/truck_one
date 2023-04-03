// To parse this JSON data, do
//
//     final groupMemberListModel = groupMemberListModelFromJson(jsonString);

import 'dart:convert';

GroupMemberListModel groupMemberListModelFromJson(String str) =>
    GroupMemberListModel.fromJson(json.decode(str));

String groupMemberListModelToJson(GroupMemberListModel data) =>
    json.encode(data.toJson());

class GroupMemberListModel {
  GroupMemberListModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int? code;
  String? message;
  List<Datum>? data;
  int? totalCount = 0;

  factory GroupMemberListModel.fromJson(Map<String, dynamic> json) =>
      GroupMemberListModel(
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

class Datum {
  Datum({
    this.id,
    this.role,
    this.personName,
    this.image,
    this.email,
    this.isMyself,
    this.invitationId,
  });

  String? id;
  String? role;
  String? personName;
  String? image;
  String? email;
  bool? isMyself;
  String? invitationId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["userId"],
        role: json["role"],
        personName: json["personName"],
        image: json["image"],
        email: json["email"],
        isMyself: json["isMyself"],
        invitationId: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "userId": id,
        "role": role,
        "personName": personName,
        "image": image,
        "email": email,
        "isMyself": isMyself,
        "invitationId": invitationId,
      };
}
