// To parse this JSON data, do
//
//     final applyPromoCodeModel = applyPromoCodeModelFromJson(jsonString);

import 'dart:convert';

ApplyPromoCodeModel applyPromoCodeModelFromJson(String str) => ApplyPromoCodeModel.fromJson(json.decode(str));

String applyPromoCodeModelToJson(ApplyPromoCodeModel data) => json.encode(data.toJson());

class ApplyPromoCodeModel {
  ApplyPromoCodeModel({
    this.code,
    this.message,
    this.data,
    this.planDiscount,
    this.discounttype,
    this.discountValue,
    this.discountupto,
    this.planAmount,
    this.grandTotal,
    this.finalAmount,
    this.promoObj,
  });

  int ?code;
  String ?message;
  List<Datum>? data;
  double? planDiscount;
  String ?discounttype;
  int ?discountValue;
  int ?discountupto;
  double? planAmount;
  double ?grandTotal;
  double ?finalAmount;
  PromoObj ?promoObj;

  factory ApplyPromoCodeModel.fromJson(Map<String, dynamic> json) => ApplyPromoCodeModel(
    code: json["code"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    planDiscount: json["planDiscount"].toDouble(),
    discounttype: json["discounttype"],
    discountValue: json["discountValue"],
    discountupto: json["discountupto"],
    planAmount: json["planAmount"].toDouble(),
    grandTotal: json["GrandTotal"].toDouble(),
    finalAmount: json["finalAmount"].toDouble(),
    promoObj: PromoObj.fromJson(json["promoObj"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "planDiscount": planDiscount,
    "discounttype": discounttype,
    "discountValue": discountValue,
    "discountupto": discountupto,
    "planAmount": planAmount,
    "GrandTotal": grandTotal,
    "finalAmount": finalAmount,
    "promoObj": promoObj!.toJson(),
  };
}

class Datum {
  Datum({
    this.id,
    this.planId,
    this.title,
    this.planPrice,
    this.finalPrice,
    this.discountType,
    this.discountValue,
    this.promocode,
    this.promotitle,
    this.toDate,
    this.fromDate,
    this.promoData,
    this.androidPercent,
    this.iphonePercent,
    this.iphonePrice,
    this.androidPrice,
  });

  String ?id;
  String ?planId;
  String ?title;
  double ?planPrice;
  double ?finalPrice;
  String ?discountType;
  int ?discountValue;
  String ?promocode;
  String ?promotitle;
  DateTime? toDate;
  DateTime ?fromDate;
  PromoData ?promoData;
  int ?androidPercent;
  int ?iphonePercent;
  double ?iphonePrice;
  double ?androidPrice;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    planId: json["planId"],
    title: json["title"],
    planPrice: json["planPrice"].toDouble(),
    finalPrice: json["finalPrice"].toDouble(),
    discountType: json["discountType"],
    discountValue: json["discountValue"],
    promocode: json["promocode"],
    promotitle: json["promotitle"],
    toDate: DateTime.parse(json["toDate"]),
    fromDate: DateTime.parse(json["fromDate"]),
    promoData: PromoData.fromJson(json["promoData"]),
    androidPercent: json["android_percent"],
    iphonePercent: json["iphone_percent"],
    iphonePrice: json["iphone_price"].toDouble(),
    androidPrice: json["android_price"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "planId": planId,
    "title": title,
    "planPrice": planPrice,
    "finalPrice": finalPrice,
    "discountType": discountType,
    "discountValue": discountValue,
    "promocode": promocode,
    "promotitle": promotitle,
    "toDate": toDate!.toIso8601String(),
    "fromDate": fromDate!.toIso8601String(),
    "promoData": promoData!.toJson(),
    "android_percent": androidPercent,
    "iphone_percent": iphonePercent,
    "iphone_price": iphonePrice,
    "android_price": androidPrice,
  };
}

class PromoData {
  PromoData({
    this.id,
    this.type,
    this.title,
    this.code,
    this.isActive,
    this.fromDate,
    this.toDate,
    this.discountType,
    this.discountValue,
    this.statusType,
    this.maxDiscountValue,
    this.activeType,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.description,
  });

  String? id;
  String ?type;
  String ?title;
  String ?code;
  bool ? isActive;
  DateTime ?fromDate;
  DateTime ?toDate;
  String ?discountType;
  int ?discountValue;
  dynamic statusType;
  int ?maxDiscountValue;
  String ?activeType;
  DateTime ?createdAt;
  DateTime ?updatedAt;
  int ?v;
  String? description;

  factory PromoData.fromJson(Map<String, dynamic> json) => PromoData(
    id: json["_id"],
    type: json["type"],
    title: json["title"],
    code: json["code"],
    isActive: json["isActive"],
    fromDate: DateTime.parse(json["fromDate"]),
    toDate: DateTime.parse(json["toDate"]),
    discountType: json["discountType"],
    discountValue: json["discountValue"],
    statusType: json["statusType"],
    maxDiscountValue: json["maxDiscountValue"],
    activeType: json["activeType"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "type": type,
    "title": title,
    "code": code,
    "isActive": isActive,
    "fromDate": fromDate!.toIso8601String(),
    "toDate": toDate!.toIso8601String(),
    "discountType": discountType,
    "discountValue": discountValue,
    "statusType": statusType,
    "maxDiscountValue": maxDiscountValue,
    "activeType": activeType,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
    "description": description,
  };
}

class PromoObj {
  PromoObj({
    this.status,
    this.userData,
  });

  bool ?status;
  UserData ?userData;

  factory PromoObj.fromJson(Map<String, dynamic> json) => PromoObj(
    status: json["status"],
    userData: UserData.fromJson(json["userData"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "userData": userData!.toJson(),
  };
}

class UserData {
  UserData({
    this.appliedCode,
    this.isActive,
    this.discounttype,
    this.discountValue,
    this.discountupto,
    this.id,
    this.userId,
    this.planId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  List<PromoData> ?appliedCode;
  bool ?isActive;
  String ?discounttype;
  int ?discountValue;
  int ?discountupto;
  String ?id;
  String ?userId;
  String ?planId;
  DateTime ?createdAt;
  DateTime ?updatedAt;
  int ?v;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    appliedCode: List<PromoData>.from(json["appliedCode"].map((x) => PromoData.fromJson(x))),
    isActive: json["isActive"],
    discounttype: json["discounttype"],
    discountValue: json["discountValue"],
    discountupto: json["discountupto"],
    id: json["_id"],
    userId: json["userId"],
    planId: json["planId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "appliedCode": List<dynamic>.from(appliedCode!.map((x) => x.toJson())),
    "isActive": isActive,
    "discounttype": discounttype,
    "discountValue": discountValue,
    "discountupto": discountupto,
    "_id": id,
    "userId": userId,
    "planId": planId,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}
