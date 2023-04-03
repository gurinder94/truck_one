// To parse this JSON data, do
//
//     final cartItemModel = cartItemModelFromJson(jsonString);

import 'dart:convert';

CartItemModel cartItemModelFromJson(String str) => CartItemModel.fromJson(json.decode(str));

String cartItemModelToJson(CartItemModel data) => json.encode(data.toJson());

class CartItemModel {
  CartItemModel({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String ?message;
  int ?data;

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
    code: json["code"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data,
  };
}
