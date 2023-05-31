// To parse this JSON data, do
//
//     final userLeftCompanyModel = userLeftCompanyModelFromJson(jsonString);

import 'dart:convert';

UserLeftCompanyModel userLeftCompanyModelFromJson(String str) => UserLeftCompanyModel.fromJson(json.decode(str));

String userLeftCompanyModelToJson(UserLeftCompanyModel data) => json.encode(data.toJson());

class UserLeftCompanyModel {
  UserLeftCompanyModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String ?message;
  List<UserLeftModel>? data;
  int ?totalCount;

  factory UserLeftCompanyModel.fromJson(Map<String, dynamic> json) => UserLeftCompanyModel(
    code: json["code"],
    message: json["message"],
    data: List<UserLeftModel>.from(json["data"].map((x) => UserLeftModel.fromJson(x))),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}

class UserLeftModel {
  UserLeftModel({
    this.id,
    this.reason,
    this.createdAt,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
  });

  String? id;
  String ?reason;
  DateTime? createdAt;
  String ?firstName;
  String ?lastName;
  String ?email;
  dynamic ?image;

  factory UserLeftModel.fromJson(Map<String, dynamic> json) => UserLeftModel(
    id: json["_id"],
    reason: json["reason"],
    createdAt: DateTime.parse(json["createdAt"]),
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "reason": reason,
    "createdAt": createdAt!.toIso8601String(),
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "image": image,
  };
}
