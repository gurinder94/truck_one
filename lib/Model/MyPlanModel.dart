// To parse this JSON data, do
//
//     final myPlanModel = myPlanModelFromJson(jsonString);

import 'dart:convert';

MyPlanModel myPlanModelFromJson(String str) => MyPlanModel.fromJson(json.decode(str));

String myPlanModelToJson(MyPlanModel data) => json.encode(data.toJson());

class MyPlanModel {
  MyPlanModel({
    this.code,
    this.message,
    this.group,
    this.startDate,
    this.promocode,
  });

  int ?code;
  String ?message;
  List<Group>? group;
  DateTime ?startDate;
  List<dynamic> ?promocode;

  factory MyPlanModel.fromJson(Map<String, dynamic> json) => MyPlanModel(
    code: json["code"],
    message: json["message"],
    group: List<Group>.from(json["group"].map((x) => Group.fromJson(x))),
    startDate: DateTime.parse(json["startDate"]),
    // promocode:json["promocode"]==[] List<dynamic>.from(json["promocode"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "group": List<dynamic>.from(group!.map((x) => x.toJson())),
    "startDate": startDate!.toIso8601String(),
    // "promocode": List<dynamic>.from(promocode!.map((x) => x)),
  };
}

class Group {
  Group({
    this.chargeId,
    this.startDate,
    this.endDate,
    this.data,

  });

  String ?chargeId;
  String ?startDate;
  String ?endDate;
  Data ?data;
  bool isActive=false;
  bool isChecked=false;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    chargeId: json["chargeId"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "chargeId": chargeId,
    "startDate": startDate,
    "endDate": endDate,
    "data": data!.toJson(),
  };
}

class Data {
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
    this.iphone_price,
    this.android_price
  });

  String ?id;
  String ?planName;
  String ?description;
  String ?heading;
  String ?title;
  String ?validity;
 var planPrice;
  var  finalPrice;
  bool ?isActive;
  String ?discountType;
  dynamic discountValue;
  dynamic maxDiscountValue;
  String ?createdBy;
  DateTime? createdDate;
  List<Feature> ?features;
  DateTime ?createdAt;
  DateTime ?updatedAt;
  int ?v;
  var iphone_price;
  var android_price;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    planName: json["plan_name"],
    description: json["description"],
    heading: json["heading"],
    title: json["title"],
    validity: json["validity"],
    planPrice: json["planPrice"],
    finalPrice: json["finalPrice"],
    isActive: json["isActive"],
    discountType: json["discountType"],
    discountValue: json["discountValue"],
    maxDiscountValue: json["maxDiscountValue"],
    createdBy: json["createdBy"],
    createdDate: DateTime.parse(json["createdDate"]),
    features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    iphone_price:json["iphone_price"],
      android_price:json["android_price"],
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
    "iphone_price":iphone_price,
    "android_price":android_price,
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
