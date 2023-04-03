// To parse this JSON data, do
//
//     final reasonLeaveListModel = reasonLeaveListModelFromJson(jsonString);

import 'dart:convert';

ReasonLeaveListModel reasonLeaveListModelFromJson(String str) => ReasonLeaveListModel.fromJson(json.decode(str));

String reasonLeaveListModelToJson(ReasonLeaveListModel data) => json.encode(data.toJson());

class ReasonLeaveListModel {
  ReasonLeaveListModel({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String? message;
  List<ReasonLeaveModel>? data;

  factory ReasonLeaveListModel.fromJson(Map<String, dynamic> json) => ReasonLeaveListModel(
    code: json["code"],
    message: json["message"],
    data: List<ReasonLeaveModel>.from(json["data"].map((x) => ReasonLeaveModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ReasonLeaveModel {
  ReasonLeaveModel({
    this.id,
    this.reasonTitle,
    this.isActive,
    this.isDeleted,
    this.reasonType,
  });

  String ?id;
  String ?reasonTitle;
  bool ?isActive;
  bool ?isDeleted;
  String ?reasonType;

  factory ReasonLeaveModel.fromJson(Map<String, dynamic> json) => ReasonLeaveModel(
    id: json["_id"],
    reasonTitle: json["reasonTitle"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    reasonType: json["reasonType"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "reasonTitle": reasonTitle,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "reasonType": reasonType,
  };
}
