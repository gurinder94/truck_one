// To parse this JSON data, do
//
//     final ecommerceCategoryModel = ecommerceCategoryModelFromJson(jsonString);

import 'dart:convert';

EcommerceCategoryModel ecommerceCategoryModelFromJson(String str) => EcommerceCategoryModel.fromJson(json.decode(str));

String ecommerceCategoryModelToJson(EcommerceCategoryModel data) => json.encode(data.toJson());

class EcommerceCategoryModel {
  EcommerceCategoryModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String? message;
  List<Datum>? data;
  int ?totalCount;

  factory EcommerceCategoryModel.fromJson(Map<String, dynamic> json) => EcommerceCategoryModel(
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
    this.categoryName,
    this.constantName,
    this.id,
    this.isActive,
    this.isDeleted,
    this.image,
    this.createdById,
    this.sortOrder,
  });

  String ?categoryName;
  String ?constantName;
  String ?id;
  bool ?isActive;
  bool ?isDeleted;
  String ?image;
  String ?createdById;
  int ?sortOrder;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    categoryName: json["category_name"],
    constantName: json["constant_name"],
    id: json["_id"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    image: json["image"],
    createdById: json["createdById"],
    sortOrder: json["sort_order"],
  );

  Map<String, dynamic> toJson() => {
    "category_name": categoryName,
    "constant_name": constantName,
    "_id": id,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "image": image,
    "createdById": createdById,
    "sort_order": sortOrder,
  };
}
