// To parse this JSON data, do
//
//     final addSellerRatingModel = addSellerRatingModelFromJson(jsonString);

import 'dart:convert';

AddSellerRatingModel addSellerRatingModelFromJson(String str) => AddSellerRatingModel.fromJson(json.decode(str));

String addSellerRatingModelToJson(AddSellerRatingModel data) => json.encode(data.toJson());

class AddSellerRatingModel {
  AddSellerRatingModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  Data? data;

  factory AddSellerRatingModel.fromJson(Map<String, dynamic> json) => AddSellerRatingModel(
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
    this.tokenData,
    this.urlPath,
  });

  TokenData ?tokenData;
  String ?urlPath;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    tokenData: TokenData.fromJson(json["tokenData"]),
    urlPath: json["urlPath"],
  );

  Map<String, dynamic> toJson() => {
    "tokenData": tokenData!.toJson(),
    "urlPath": urlPath,
  };
}

class TokenData {
  TokenData({
    this.rating,
    this.token,
    this.id,
    this.sellerId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  int ?rating;
  dynamic token;
  String ?id;
  String ?sellerId;
  String ?userId;
  DateTime ?createdAt;
  DateTime ?updatedAt;
  int? v;

  factory TokenData.fromJson(Map<String, dynamic> json) => TokenData(
    rating: json["rating"],
    token: json["token"],
    id: json["_id"],
    sellerId: json["sellerId"],
    userId: json["userId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "token": token,
    "_id": id,
    "sellerId": sellerId,
    "userId": userId,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}
