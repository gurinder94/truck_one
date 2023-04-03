// To parse this JSON data, do
//
//     final modelList = modelListFromJson(jsonString);

import 'dart:convert';

ModelList modelListFromJson(String str) => ModelList.fromJson(json.decode(str));

String modelListToJson(ModelList data) => json.encode(data.toJson());

class ModelList {
  ModelList({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String ?message;
  List<Datum> ?data;
  int ?totalCount;

  factory ModelList.fromJson(Map<String, dynamic> json) => ModelList(
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
    this.title,
    this.id,
    this.isActive,
    this.isDeleted,
    this.brand,
    this.createdById,
    this.isAdminApprove,
  });

  String ?title;
  String ?id;
  bool ?isActive;
  bool ?isDeleted;
  String? brand;
  String ?createdById;
  String ?isAdminApprove;
  String check="false";

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"],
    id: json["_id"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    brand: json["brand"],
    createdById: json["createdById"],
    isAdminApprove: json["isAdminApprove"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "_id": id,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "brand": brand,
    "createdById": createdById,
    "isAdminApprove": isAdminApprove,
  };
}
