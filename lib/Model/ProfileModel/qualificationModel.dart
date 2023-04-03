// To parse this JSON data, do
//
//     final qualificationModel = qualificationModelFromJson(jsonString);

import 'dart:convert';

QualificationModel qualificationModelFromJson(String str) => QualificationModel.fromJson(json.decode(str));

String qualificationModelToJson(QualificationModel data) => json.encode(data.toJson());

class QualificationModel {
  QualificationModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String ?message;
  List<Datum>? data;
  int ?totalCount;

  factory QualificationModel.fromJson(Map<String, dynamic> json) => QualificationModel(
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
    this.qualification,
    this.isActive,
    this.isDeleted,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,


  });

  String?qualification;
  bool ?isActive;
  bool ?isDeleted;
  String? id;
  DateTime? createdAt;
  DateTime ?updatedAt;
  int ?v;
  bool isvalue=false;


  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    qualification: json["qualification"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    id: json["_id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "qualification": qualification,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "_id": id,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}
