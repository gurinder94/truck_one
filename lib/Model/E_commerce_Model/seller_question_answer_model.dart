// To parse this JSON data, do
//
//     final sellerQuestionAnswerModel = sellerQuestionAnswerModelFromJson(jsonString);

import 'dart:convert';

SellerQuestionAnswerModel sellerQuestionAnswerModelFromJson(String str) => SellerQuestionAnswerModel.fromJson(json.decode(str));

String sellerQuestionAnswerModelToJson(SellerQuestionAnswerModel data) => json.encode(data.toJson());

class SellerQuestionAnswerModel {
  SellerQuestionAnswerModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String ?message;
  List<Datum> ?data;
  int ?totalCount;

  factory SellerQuestionAnswerModel.fromJson(Map<String, dynamic> json) => SellerQuestionAnswerModel(
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
    this.question,
    this.answer,
    this.customerId,
    this.firstName,
    this.lastName,
    this.personName,
    this.email,
    this.image,
    this.productName,
    this.productImage,
    this.categoryId,
  });

  String ?id;
  String ?question;
  dynamic answer;
  String ?customerId;
  String ?firstName;
  String ?lastName;
  String ?personName;
  String ?email;
  String ?image;
  String ?productName;
  List<ProductImage> ?productImage;
  String ?categoryId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    question: json["question"],
    answer: json["answer"],
    customerId: json["customerId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    personName: json["personName"],
    email: json["email"],
    image: json["image"] == null ? null : json["image"],
    productName: json["productName"],
    productImage:json["productImage"]==null?[]: List<ProductImage>.from(json["productImage"].map((x) => ProductImage.fromJson(x))),
    categoryId: json["categoryId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "question": question,
    "answer": answer,
    "customerId": customerId,
    "firstName": firstName,
    "lastName": lastName,
    "personName": personName,
    "email": email,
    "image": image == null ? null : image,
    "productName": productName,
    "productImage": List<dynamic>.from(productImage!.map((x) => x.toJson())),
    "categoryId": categoryId,
  };
}

class ProductImage {
  ProductImage({
    this.name,
    this.id,
  });

  String ?name;
  String ?id;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
    name: json["name"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "_id": id,
  };
}
