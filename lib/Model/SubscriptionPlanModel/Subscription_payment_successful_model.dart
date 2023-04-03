// To parse this JSON data, do
//
//     final subscriptionPaymentSuccessfulModel = subscriptionPaymentSuccessfulModelFromJson(jsonString);

import 'dart:convert';

SubscriptionPaymentSuccessfulModel subscriptionPaymentSuccessfulModelFromJson(String str) => SubscriptionPaymentSuccessfulModel.fromJson(json.decode(str));

String subscriptionPaymentSuccessfulModelToJson(SubscriptionPaymentSuccessfulModel data) => json.encode(data.toJson());

class SubscriptionPaymentSuccessfulModel {
  SubscriptionPaymentSuccessfulModel({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String ?message;
  List<Datum>? data;

  factory SubscriptionPaymentSuccessfulModel.fromJson(Map<String, dynamic> json) => SubscriptionPaymentSuccessfulModel(
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
    this.plan,
    this.features,
    this.validity,
  });

  String? plan;
  List<Feature>? features;
  String ?validity;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    plan: json["plan"],
    features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
    validity: json["validity"],
  );

  Map<String, dynamic> toJson() => {
    "plan": plan,
    "features": List<dynamic>.from(features!.map((x) => x.toJson())),
    "validity": validity,
  };
}

class Feature {
  Feature({
    this.keyName,
    this.constName,
    this.keyValue,
    this.id,
  });

  String ?keyName;
  String ?constName;
  int ?keyValue;
  String ?id;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    keyName: json["keyName"],
    constName: json["constName"],
    keyValue: json["keyValue"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "keyName": keyName,
    "constName": constName,
    "keyValue": keyValue,
    "_id": id,
  };
}
