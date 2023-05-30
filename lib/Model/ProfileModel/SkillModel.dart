// To parse this JSON data, do
//
//     final skillModel = skillModelFromJson(jsonString);

import 'dart:convert';

SkillModel skillModelFromJson(String str) => SkillModel.fromJson(json.decode(str));

String skillModelToJson(SkillModel data) => json.encode(data.toJson());

class SkillModel {
  SkillModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String? message;
  List<SkillDatum>? data;
  int ?totalCount;

  factory SkillModel.fromJson(Map<String, dynamic> json) => SkillModel(
    code: json["code"],
    message: json["message"],
    data: List<SkillDatum>.from(json["data"].map((x) => SkillDatum.fromJson(x))),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}

class SkillDatum {
  SkillDatum({
    this.id,
    this.skill,
    this.isActive,
    this.isDeleted,
    this.createdById,
  });

  String ?id;
  String ?skill;
  bool ?isActive;
  bool ?isDeleted;
  String? createdById;
  bool ? isValue=false;

  factory SkillDatum.fromJson(Map<String, dynamic> json) => SkillDatum(
    id: json["_id"],
    skill: json["skill"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    createdById: json["createdById"] == null ? null : json["createdById"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "skill": skill,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "createdById": createdById == null ? null : createdById,
  };
}
