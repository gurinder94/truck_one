// To parse this JSON data, do
//
//     final wishListModel = wishListModelFromJson(jsonString);

import 'dart:convert';

WishListModel wishListModelFromJson(String str) => WishListModel.fromJson(json.decode(str));

String wishListModelToJson(WishListModel data) => json.encode(data.toJson());

class WishListModel {
  WishListModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String? message;
  List<Datum> ?data;
  int ?totalCount;

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
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
    this.productName,
    this.image,
    this.price,
    this.productId,
    this.currency,
    this.location,
    this.categoryId,
  });

  String ?id;
  String ?productName;
  List<Image>? image;
  int ?price;
  String ?productId;
  String ?currency;
  String ?location;
  String ?categoryId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    productName: json["productName"],
    image: List<Image>.from(json["image"]==null?[]:json["image"].map((x) => Image.fromJson(x))),
    price: json["price"],
    productId: json["productId"],
      currency:json["currency"],
      location:json["location"],
      categoryId:json["categoryId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productName": productName,
    "image": List<dynamic>.from(image!.map((x) => x.toJson())),
    "price": price,
    "productId": productId,
    "currency":currency,
    "location":location,
    "categoryId":categoryId,
  };
}

class Image {
  Image({
    this.name,
    this.id,
  });

  String ?name;
  String ?id;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    name: json["name"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "_id": id,
  };
}
