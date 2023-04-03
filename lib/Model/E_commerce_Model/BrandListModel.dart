// To parse this JSON data, do
//
//     final brandListModel = brandListModelFromJson(jsonString);

import 'dart:convert';

BrandListModel brandListModelFromJson(String str) => BrandListModel.fromJson(json.decode(str));

String brandListModelToJson(BrandListModel data) => json.encode(data.toJson());

class BrandListModel {
  BrandListModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String? message;
  List<Datum>? data;
  int ?totalCount;

  factory BrandListModel.fromJson(Map<String, dynamic> json) => BrandListModel(
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
    this.brand,
    this.brandLogo,
    this.id,
    this.isActive,
    this.isDeleted,
    this.createdById,
    this.isAdminApprove,
    this.userName,
  });

  String? brand;
  String ?brandLogo;
  String ?id;
  bool ?isActive;
  bool ?isDeleted;
  String? createdById;
  String ?isAdminApprove;
  String? userName;
  bool  check =false;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    brand: json["brand"],
    brandLogo: json["brandLogo"] == null ? null : json["brandLogo"],
    id: json["_id"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    createdById: json["createdById"],
    isAdminApprove: json["isAdminApprove"],
    userName: json["userName"] == null ? null : json["userName"],
  );

  Map<String, dynamic> toJson() => {
    "brand": brand,
    "brandLogo": brandLogo == null ? null : brandLogo,
    "_id": id,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "createdById": createdById,
    "isAdminApprove": isAdminApprove,
    "userName": userName == null ? null : userName,
  };
}
