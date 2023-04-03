// To parse this JSON data, do
//
//     final sellerRatingGivenByCustomerModel = sellerRatingGivenByCustomerModelFromJson(jsonString);

import 'dart:convert';

SellerRatingGivenByCustomerModel sellerRatingGivenByCustomerModelFromJson(String str) => SellerRatingGivenByCustomerModel.fromJson(json.decode(str));

String sellerRatingGivenByCustomerModelToJson(SellerRatingGivenByCustomerModel data) => json.encode(data.toJson());

class SellerRatingGivenByCustomerModel {
  SellerRatingGivenByCustomerModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String? message;
  List<Datum>? data;
  int ?totalCount;

  factory SellerRatingGivenByCustomerModel.fromJson(Map<String, dynamic> json) => SellerRatingGivenByCustomerModel(
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
    this.rating,
    this.token,
    this.personName,
    this.email,
    this.image,
  });

  String ?id;
  int ?rating;
  dynamic token;
  String ?personName;
  String ? image;
  String ?email;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    rating: json["rating"],
    token: json["token"],
    personName: json["personName"] == null ? null : json["personName"],
    image: json["image"],
    email: json["email"] == null ? null : json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "rating": rating,
    "token": token,
    "personName": personName == null ? null : personName,
    "email": email == null ? null : email,
    "image": image,
  };
}
