// To parse this JSON data, do
//
//     final wazeModel = wazeModelFromJson(jsonString);

import 'dart:convert';

WazeModel wazeModelFromJson(String str) => WazeModel.fromJson(json.decode(str));

String wazeModelToJson(WazeModel data) => json.encode(data.toJson());

class WazeModel {
  WazeModel({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String? message;
  List<Datum>? data;

  factory WazeModel.fromJson(Map<String, dynamic> json) => WazeModel(
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
    this.title,
    this.markerCategory,
    this.constKey,
    this.iconName,
    this.image,
    this.isAskFlag,
    this.temporaryHours,
  });

  String ?id;
  String? title;
  String ?markerCategory;
  String ?constKey;
  String ?iconName;
  String ?image;
  dynamic isAskFlag;
  dynamic temporaryHours;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    title: json["title"],
    markerCategory: json["markerCategory"],
    constKey: json["constKey"],
    iconName: json["iconName"],
    image: json["image"],
    isAskFlag: json["isAskFlag"],
    temporaryHours: json["temporaryHours"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "markerCategory": markerCategory,
    "constKey": constKey,
    "iconName": iconName,
    "image": image,
    "isAskFlag": isAskFlag,
    "temporaryHours": temporaryHours,
  };
}
