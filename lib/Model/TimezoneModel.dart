// To parse this JSON data, do
//
//     final timezoneModel = timezoneModelFromJson(jsonString);

import 'dart:convert';

TimezoneModel timezoneModelFromJson(String str) => TimezoneModel.fromJson(json.decode(str));

String timezoneModelToJson(TimezoneModel data) => json.encode(data.toJson());

class TimezoneModel {
  TimezoneModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int?code;
  String ?message;
  List<Datum>? data;
  int ?totalCount;

  factory TimezoneModel.fromJson(Map<String, dynamic> json) => TimezoneModel(
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
    this.offset,
    this.code,
    this.countryId,
    this.countryName,
    this.isActive,
    this.isDeleted,
  });

  String ? id;
  String ?name;
  String ?offset;
  String ?code;
  String ?countryId;
  String ?countryName;
  bool ?isActive;
  bool ?isDeleted;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    name: json["name"],
    offset: json["offset"],
    code: json["code"],
    countryId: json["countryId"],
    countryName: json["countryName"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "offset": offset,
    "code": code,
    "countryId": countryId,
    "countryName": countryName,
    "isActive": isActive,
    "isDeleted": isDeleted,
  };
}
