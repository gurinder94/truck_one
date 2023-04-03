// To parse this JSON data, do
//
//     final driverListModel = driverListModelFromJson(jsonString);

import 'dart:convert';

DriverListModel driverListModelFromJson(String str) => DriverListModel.fromJson(json.decode(str));

String driverListModelToJson(DriverListModel data) => json.encode(data.toJson());

class DriverListModel {
  DriverListModel({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String? message;
  List<DriverModel>? data;

  factory DriverListModel.fromJson(Map<String, dynamic> json) => DriverListModel(
    code: json["code"],
    message: json["message"],
    data: List<DriverModel>.from(json["data"].map((x) => DriverModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DriverModel {
  DriverModel({
    this.id,
    this.personName,
    this.email,
    this.accesslevel,
  });

  String ?id;
  String ?personName;
  String ?email;
  String ?accesslevel;

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
    id: json["_id"],
    personName: json["personName"],
    email: json["email"],
    accesslevel: json["accesslevel"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "personName": personName,
    "email": email,
    "accesslevel": accesslevel,
  };
}
