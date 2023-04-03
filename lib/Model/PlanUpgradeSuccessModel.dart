// To parse this JSON data, do
//
//     final planUpgradeSuccessModel = planUpgradeSuccessModelFromJson(jsonString);

import 'dart:convert';

PlanUpgradeSuccessModel planUpgradeSuccessModelFromJson(String str) => PlanUpgradeSuccessModel.fromJson(json.decode(str));

String planUpgradeSuccessModelToJson(PlanUpgradeSuccessModel data) => json.encode(data.toJson());

class PlanUpgradeSuccessModel {
  PlanUpgradeSuccessModel({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String ?message;
  PlanUpgradeSuccessModelData ?data;

  factory PlanUpgradeSuccessModel.fromJson(Map<String, dynamic> json) => PlanUpgradeSuccessModel(
    code: json["code"],
    message: json["message"],
    data: PlanUpgradeSuccessModelData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data!.toJson(),
  };
}

class PlanUpgradeSuccessModelData {
  PlanUpgradeSuccessModelData({
    this.status,
    this.data,
  });

  bool ?status;
  DataData ?data;

  factory PlanUpgradeSuccessModelData.fromJson(Map<String, dynamic> json) => PlanUpgradeSuccessModelData(
    status: json["status"],
    data: DataData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class DataData {
  DataData({
    this.planName,
    this.description,
    this.heading,
    this.title,
    this.validity,
    this.planPrice,
    this.androidPercent,
    this.iphonePercent,
    this.iphonePrice,
    this.androidPrice,
    this.finalPrice,
    this.isActive,
    this.discountType,
    this.discountValue,
    this.maxDiscountValue,
    this.id,
    this.createdBy,
    this.createdDate,
    this.features,
    this.appliedPromo,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String ?planName;
  String ?description;
  String ?heading;
  String ?title;
  String ?validity;
  double ?planPrice;
  double ?androidPercent;
  int ?iphonePercent;
  double ?iphonePrice;
  double ?androidPrice;
  double ?finalPrice;
  bool ?isActive;
  String ?discountType;
  int ?discountValue;
  dynamic maxDiscountValue;
  String ?id;
  String ?createdBy;
  DateTime ?createdDate;
  List<Feature>? features;
  List<AppliedPromo>? appliedPromo;
  DateTime? createdAt;
  DateTime ?updatedAt;
  int ?v;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
    planName: json["plan_name"],
    description: json["description"],
    heading: json["heading"],
    title: json["title"],
    validity: json["validity"],
    planPrice: json["planPrice"].toDouble(),
    androidPercent: json["android_percent"].toDouble(),
    iphonePercent: json["iphone_percent"],
    iphonePrice: json["iphone_price"].toDouble(),
    androidPrice: json["android_price"].toDouble(),
    finalPrice: json["finalPrice"].toDouble(),
    isActive: json["isActive"],
    discountType: json["discountType"],
    discountValue: json["discountValue"],
    maxDiscountValue: json["maxDiscountValue"],
    id: json["_id"],
    createdBy: json["createdBy"],
    createdDate: DateTime.parse(json["createdDate"]),
    features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
    appliedPromo: List<AppliedPromo>.from(json["appliedPromo"].map((x) => AppliedPromo.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "plan_name": planName,
    "description": description,
    "heading": heading,
    "title": title,
    "validity": validity,
    "planPrice": planPrice,
    "android_percent": androidPercent,
    "iphone_percent": iphonePercent,
    "iphone_price": iphonePrice,
    "android_price": androidPrice,
    "finalPrice": finalPrice,
    "isActive": isActive,
    "discountType": discountType,
    "discountValue": discountValue,
    "maxDiscountValue": maxDiscountValue,
    "_id": id,
    "createdBy": createdBy,
    "createdDate": createdDate!.toIso8601String(),
    "features": List<dynamic>.from(features!.map((x) => x.toJson())),
    "appliedPromo": List<dynamic>.from(appliedPromo!.map((x) => x.toJson())),
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}

class AppliedPromo {
  AppliedPromo({
    this.id,
    this.promocodeId,
  });

  String ?id;
  String ?promocodeId;

  factory AppliedPromo.fromJson(Map<String, dynamic> json) => AppliedPromo(
    id: json["_id"],
    promocodeId: json["promocode_id"] == null ? null : json["promocode_id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "promocode_id": promocodeId == null ? null : promocodeId,
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
