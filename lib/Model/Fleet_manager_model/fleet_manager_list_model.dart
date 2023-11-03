// To parse this JSON data, do
//
//     final fleetManagerModel = fleetManagerModelFromJson(jsonString);

import 'dart:convert';

FleetManagerModel fleetManagerModelFromJson(String str) => FleetManagerModel.fromJson(json.decode(str));

String fleetManagerModelToJson(FleetManagerModel data) => json.encode(data.toJson());

class FleetManagerModel {
  FleetManagerModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String ?message;
  List<Datum>? data;
  int ?totalCount;

  factory FleetManagerModel.fromJson(Map<String, dynamic> json) => FleetManagerModel(
    code: json["code"],
    message: json["message"],
    data:json["data"]==null?[] :List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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
    this.userData,
    this.id,
    this.name,
    this.image,
    this.weight,
    this.height,
    this.width,
    this.vehicleType,
    this.isActive,
    this.isDeleted,
    this.createdById,
  });

  UserData ?userData;
  String ?id;
  String ?name;
  dynamic image;
  var weight;
  var height;
  var width;
  String ?vehicleType;
  bool? isActive;
  bool ?isDeleted;
  String ?createdById;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    userData: UserData.fromJson(json["userData"]),
    id: json["_id"],
    name: json["name"],
    image: json["image"],
    weight: json["weight"],
    height: json["height"],
    width: json["width"],
    vehicleType: json["vehicleType"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    createdById: json["createdById"],
  );

  Map<String, dynamic> toJson() => {
    "userData": userData!.toJson(),
    "_id": id,
    "name": name,
    "image": image,
    "weight": weight,
    "height": height,
    "width": width,
    "vehicleType": vehicleType,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "createdById": createdById,
  };
}

class UserData {
  UserData({
    this.id,
    this.personName,
  });

  String ?id;
  String ?personName;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["_id"],
    personName: json["personName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "personName": personName,
  };
}
