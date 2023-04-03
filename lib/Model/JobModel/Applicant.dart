// To parse this JSON data, do
//
//     final applicant = applicantFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

Applicant applicantFromJson(String str) => Applicant.fromJson(json.decode(str));

String applicantToJson(Applicant data) => json.encode(data.toJson());

class Applicant {
  Applicant({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String ?message;
  List<Datum>? data;
  int? totalCount;

  factory Applicant.fromJson(Map<String, dynamic> json) => Applicant(
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

class Datum extends ChangeNotifier{
  Datum({
    this.id,
    this.userData,
    this.resume,
    this.description,

  });

  String ?id;
  UserData ?userData;
  String ?resume;
  String ?description;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    userData: UserData.fromJson(json["userData"]),
    resume: json["resume"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userData": userData!.toJson(),
    "resume": resume,
    "description": description,
  };
}

class UserData {
  UserData({
    this.id,
    this.personName,
    this.email,
    this.mobileNumber,
  });

  String ?id;
  String? personName;
  String ?email;
  String ?mobileNumber;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["_id"],
    personName: json["personName"],
    email: json["email"],
    mobileNumber: json["mobileNumber"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "personName": personName,
    "email": email,
    "mobileNumber": mobileNumber,
  };
}
