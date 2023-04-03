
// To parse this JSON data, do
//
//     final addToCartModel = addToCartModelFromJson(jsonString);

import 'dart:convert';

AddToCartModel addToCartModelFromJson(String str) => AddToCartModel.fromJson(json.decode(str));

String addToCartModelToJson(AddToCartModel data) => json.encode(data.toJson());

class AddToCartModel {
  AddToCartModel({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String ?message;
  Data ?data;

  factory AddToCartModel.fromJson(Map<String, dynamic> json) => AddToCartModel(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.qty,
    this.title,
    this.id,
    this.userId,
    this.planId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  int ?qty;
  String? title;
  String ?id;
  String ?userId;
  String ?planId;
  DateTime? createdAt;
  DateTime ?updatedAt;
  int ?v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    qty: json["qty"],
    title: json["title"],
    id: json["_id"],
    userId: json["userId"],
    planId: json["planId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "qty": qty,
    "title": title,
    "_id": id,
    "userId": userId,
    "planId": planId,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}
