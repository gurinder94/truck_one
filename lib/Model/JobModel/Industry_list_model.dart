// To parse this JSON data, do
//
//     final industryList = industryListFromJson(jsonString);

import 'dart:convert';

IndustryList industryListFromJson(String str) => IndustryList.fromJson(json.decode(str));

String industryListToJson(IndustryList data) => json.encode(data.toJson());

class IndustryList {
  IndustryList({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String ?message;
  List<Datum> ?data;
  int ?totalCount;

  factory IndustryList.fromJson(Map<String, dynamic> json) => IndustryList(
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
    this.name,
    this.isActive,
    this.isDeleted,
  });

  String ?id;
  String ?name;
  bool ?isActive;
  bool? isDeleted;
  bool? isValue=false;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    name: json["name"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "isActive": isActive,
    "isDeleted": isDeleted,
  };
}
