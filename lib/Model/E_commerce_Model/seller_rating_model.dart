// To parse this JSON data, do
//
//     final sellerRatingModel = sellerRatingModelFromJson(jsonString);

import 'dart:convert';

SellerRatingModel sellerRatingModelFromJson(String str) => SellerRatingModel.fromJson(json.decode(str));

String sellerRatingModelToJson(SellerRatingModel data) => json.encode(data.toJson());

class SellerRatingModel {
  SellerRatingModel({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String ?message;
  List<Datum>? data;

  factory SellerRatingModel.fromJson(Map<String, dynamic> json) => SellerRatingModel(
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
    this.avgRating,
    this.count,
  });

  String? id;
  dynamic avgRating;
  int ?count;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    avgRating: json["AvgRating"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "AvgRating": avgRating,
    "count": count,
  };
}
