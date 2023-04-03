// To parse this JSON data, do
//
//     final getWazeMarker = getWazeMarkerFromJson(jsonString);

import 'dart:convert';

GetWazeMarker getWazeMarkerFromJson(String str) => GetWazeMarker.fromJson(json.decode(str));

String getWazeMarkerToJson(GetWazeMarker data) => json.encode(data.toJson());

class GetWazeMarker {
  GetWazeMarker({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String ?message;
  List<WazeMarker>? data;

  factory GetWazeMarker.fromJson(Map<String, dynamic> json) => GetWazeMarker(
    code: json["code"],
    message: json["message"],
    data: List<WazeMarker>.from(json["data"].map((x) => WazeMarker.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class WazeMarker {
  WazeMarker({
    this.id,
    this.cordinates,
    this.markerCategory,
    this.iconName,
    this.iconImage,
    this.isAskFlag,
    this.temporaryHours,
    this.createdDate,
  this.markerId,

  });

  String? id;
  List<double>? cordinates;
  String? markerCategory;
  String ?iconName;
  String ?iconImage;
  bool ?isAskFlag;
  int ?temporaryHours;
  DateTime? createdDate;
  String? markerId;
  bool enablePop=false;
  bool firstTime=false;

  factory WazeMarker.fromJson(Map<String, dynamic> json) => WazeMarker(
    id: json["_id"],
    cordinates: List<double>.from(json["cordinates"].map((x) => x.toDouble())),
    markerCategory: json["markerCategory"],
    iconName: json["iconName"],
    iconImage: json["iconImage"],
    isAskFlag: json["isAskFlag"],
    markerId:json["marker_id"],
    temporaryHours: json["temporaryHours"],


    createdDate: DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "cordinates": List<dynamic>.from(cordinates!.map((x) => x)),
    "markerCategory": markerCategory,
    "iconName": iconName,
    "iconImage": iconImage,
    "isAskFlag": isAskFlag,
    "marker_id" :markerId,
    "temporaryHours": temporaryHours,
    "createdDate": createdDate!.toIso8601String(),
  };
}
