// To parse this JSON data, do
//
//     final subCategoryList = subCategoryListFromJson(jsonString);

import 'dart:convert';

SubCategoryList subCategoryListFromJson(String str) => SubCategoryList.fromJson(json.decode(str));

String subCategoryListToJson(SubCategoryList data) => json.encode(data.toJson());

class SubCategoryList {
  SubCategoryList({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String ?message;
  List<Datum> ?data;

  factory SubCategoryList.fromJson(Map<String, dynamic> json) => SubCategoryList(
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
    this.categoryName,
    this.constantName,
    this.parentCategoryId,
    this.isActive,
    this.isDeleted,
    this.image,
  });

  String ?id;
  String ?categoryName;
  String ?constantName;
  String ?parentCategoryId;
  bool ?isActive;
  bool ?isDeleted;
  String ?image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    categoryName: json["category_name"],
    constantName: json["constant_name"],
    parentCategoryId: json["parentCategoryId"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "category_name": categoryName,
    "constant_name": constantName,
    "parentCategoryId": parentCategoryId,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "image": image == null ? null : image,
  };
}
