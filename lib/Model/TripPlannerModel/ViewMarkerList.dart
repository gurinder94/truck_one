// To parse this JSON data, do
//
//     final viewMarkerModel = viewMarkerModelFromJson(jsonString);

import 'dart:convert';

ViewMarkerModel viewMarkerModelFromJson(String str) => ViewMarkerModel.fromJson(json.decode(str));

String viewMarkerModelToJson(ViewMarkerModel data) => json.encode(data.toJson());

class ViewMarkerModel {
  ViewMarkerModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String? message;
  List<Datum> ?data;
  int ?totalCount;

  factory ViewMarkerModel.fromJson(Map<String, dynamic> json) => ViewMarkerModel(
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
    this.address,
    this.latitude,
    this.longitude,
    this.isActive,
    this.isDeleted,
  });

  String? id;
  String ?address;
  double ?latitude;
  double ?longitude;
  bool ?isActive;
  bool ?isDeleted;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    address: json["address"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "isActive": isActive,
    "isDeleted": isDeleted,
  };
}
