// To parse this JSON data, do
//
//     final otherDriverListModel = otherDriverListModelFromJson(jsonString);

import 'dart:convert';

OtherDriverListModel otherDriverListModelFromJson(String str) => OtherDriverListModel.fromJson(json.decode(str));

String otherDriverListModelToJson(OtherDriverListModel data) => json.encode(data.toJson());

class OtherDriverListModel {
  OtherDriverListModel({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String ?message;
  List<OtherDriverModel> ?data;

  factory OtherDriverListModel.fromJson(Map<String, dynamic> json) => OtherDriverListModel(
    code: json["code"],
    message: json["message"],
    data: List<OtherDriverModel>.from(json["data"].map((x) => OtherDriverModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class OtherDriverModel {
  OtherDriverModel({
    this.id,
    this.personName,
    this.email,
    this.accesslevel,
  });

  String? id;
  String ?personName;
  String ?email;
  String ?accesslevel;

  factory OtherDriverModel.fromJson(Map<String, dynamic> json) => OtherDriverModel(
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
