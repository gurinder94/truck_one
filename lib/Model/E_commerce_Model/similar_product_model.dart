// To parse this JSON data, do
//
//     final similarProduct = similarProductFromJson(jsonString);

import 'dart:convert';

SimilarProduct similarProductFromJson(String str) => SimilarProduct.fromJson(json.decode(str));

String similarProductToJson(SimilarProduct data) => json.encode(data.toJson());

class SimilarProduct {
  SimilarProduct({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String ?message;
  List<Datum>? data;

  factory SimilarProduct.fromJson(Map<String, dynamic> json) => SimilarProduct(
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
    this.images,
    this.productName,
    this.price,
    this.currency,
    this.location,

  });

  String ?id;
  List<Image> ?images;
  String ?productName;
  int ?price;
  String ?currency;
  String ?location;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    images:json["images"]==null?[]: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    productName: json["productName"],
    price: json["price"],
    currency: json["currency"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "images": List<dynamic>.from(images!.map((x) => x.toJson())),
    "productName": productName,
    "price": price,
    "currency": currency,
    "location": location,

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
