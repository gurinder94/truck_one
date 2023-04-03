// To parse this JSON data, do
//
//     final likeListModel = likeListModelFromJson(jsonString);

import 'dart:convert';

LikeListModel likeListModelFromJson(String str) => LikeListModel.fromJson(json.decode(str));

String likeListModelToJson(LikeListModel data) => json.encode(data.toJson());

class LikeListModel {
  LikeListModel({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String ?message;
  List<Datum>? data;

  factory LikeListModel.fromJson(Map<String, dynamic> json) => LikeListModel(
    code: json["code"],
    message: json["message"],
    data:json["data"]==null?[]: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.userId,
    this.image,
    this.personName,
  });

  String ?userId;
  String ? image;
  String ?personName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    userId: json["userId"],
    image: json["image"],
    personName: json["personName"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "image": image,
    "personName": personName,
  };
}
