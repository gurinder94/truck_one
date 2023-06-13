// To parse this JSON data, do
//
//     final myPlanModel = myPlanModelFromJson(jsonString);

import 'dart:convert';

MyPlanModel myPlanModelFromJson(String str) =>
    MyPlanModel.fromJson(json.decode(str));

String myPlanModelToJson(MyPlanModel data) => json.encode(data.toJson());

class MyPlanModel {
  int? code;
  String? message;
  List<Datum>? data;
  DateTime? startDate;
  bool? planRefunded;
  List<dynamic>? promocode;

  MyPlanModel({
    this.code,
    this.message,
    this.data,
    this.startDate,
    this.planRefunded,
    this.promocode,
  });

  factory MyPlanModel.fromJson(Map<String, dynamic> json) => MyPlanModel(
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        startDate: DateTime.parse(json["startDate"]),
        planRefunded: json["planRefunded"],
        promocode: List<dynamic>.from(json["promocode"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "startDate": startDate!.toIso8601String(),
        "planRefunded": planRefunded,
        "promocode": List<dynamic>.from(promocode!.map((x) => x)),
      };
}

class Datum {
  List<Group>? group;

  Datum({
    this.group,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        group: List<Group>.from(json["group"].map((x) => Group.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "group": List<dynamic>.from(group!.map((x) => x.toJson())),
      };
}

class Group {
  String? startDate;
  String? endDate;
  Data? data;
  dynamic isInstallments;
  String? paymentMode;

  Group({
    this.startDate,
    this.endDate,
    this.data,
    this.isInstallments,
    this.paymentMode,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        startDate: json["startDate"],
        endDate: json["endDate"],
        data: Data.fromJson(json["data"]),
        isInstallments: json["isInstallments"],
        paymentMode: json["paymentMode"],
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate,
        "endDate": endDate,
        "data": data!.toJson(),
        "isInstallments": isInstallments,
        "paymentMode": paymentMode,
      };
}

class Data {
  String? id;
  String? planName;
  String? description;
  String? heading;
  String? title;
  String? validity;
  double? planPrice;
  double? finalPrice;
  bool? isActive;
  String? discountType;
  var discountValue;
  dynamic maxDiscountValue;
  String? createdBy;
  DateTime? createdDate;
  List<Feature>? features;
  DateTime? createdAt;
  DateTime? updatedAt;
  var v;
  dynamic androidPercent;
  dynamic iphonePercent;
  String? planType;
  var androidPrice;
  String? appKey;
  List<InstallmentPercent>? installmentPercent;
  var iphonePrice;

  Data({
    this.id,
    this.planName,
    this.description,
    this.heading,
    this.title,
    this.validity,
    this.planPrice,
    this.finalPrice,
    this.isActive,
    this.discountType,
    this.discountValue,
    this.maxDiscountValue,
    this.createdBy,
    this.createdDate,
    this.features,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.androidPercent,
    this.iphonePercent,
    this.planType,
    this.androidPrice,
    this.appKey,
    this.installmentPercent,
    this.iphonePrice,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        planName: json["plan_name"],
        description: json["description"],
        heading: json["heading"],
        title: json["title"],
        validity: json["validity"],
        planPrice: json["planPrice"].toDouble(),
        finalPrice: json["finalPrice"].toDouble(),
        isActive: json["isActive"],
        discountType: json["discountType"],
        discountValue: json["discountValue"],
        maxDiscountValue: json["maxDiscountValue"],
        createdBy: json["createdBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        androidPercent: json["android_percent"],
        iphonePercent: json["iphone_percent"],
        planType: json["planType"],
        androidPrice: json["android_price"],
        appKey: json["appKey"],
        installmentPercent: List<InstallmentPercent>.from(
            json["installmentPercent"]
                .map((x) => InstallmentPercent.fromJson(x))),
        iphonePrice: json["iphone_price"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "plan_name": planName,
        "description": description,
        "heading": heading,
        "title": title,
        "validity": validity,
        "planPrice": planPrice,
        "finalPrice": finalPrice,
        "isActive": isActive,
        "discountType": discountType,
        "discountValue": discountValue,
        "maxDiscountValue": maxDiscountValue,
        "createdBy": createdBy,
        "createdDate": createdDate!.toIso8601String(),
        "features": List<dynamic>.from(features!.map((x) => x.toJson())),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "android_percent": androidPercent,
        "iphone_percent": iphonePercent,
        "planType": planType,
        "android_price": androidPrice,
        "appKey": appKey,
        "installmentPercent":
            List<dynamic>.from(installmentPercent!.map((x) => x.toJson())),
        "iphone_price": iphonePrice,
      };
}

class Feature {
  String? keyName;
  String? constName;
  var keyValue;
  String? id;

  Feature({
    this.keyName,
    this.constName,
    this.keyValue,
    this.id,
  });

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

class InstallmentPercent {
  bool? checked;
  var value;
  String? number;

  InstallmentPercent({
    this.checked,
    this.value,
    this.number,
  });

  factory InstallmentPercent.fromJson(Map<String, dynamic> json) =>
      InstallmentPercent(
        checked: json["checked"],
        value: json["value"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "checked": checked,
        "value": value,
        "number": number,
      };
}
