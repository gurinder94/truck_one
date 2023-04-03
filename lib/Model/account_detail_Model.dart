// To parse this JSON data, do
//
//     final accountDetailsModel = accountDetailsModelFromJson(jsonString);

import 'dart:convert';

AccountDetailsModel accountDetailsModelFromJson(String str) => AccountDetailsModel.fromJson(json.decode(str));

String accountDetailsModelToJson(AccountDetailsModel data) => json.encode(data.toJson());

class AccountDetailsModel {
  AccountDetailsModel({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String ?message;
  Data ?data;

  factory AccountDetailsModel.fromJson(Map<String, dynamic> json) => AccountDetailsModel(
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
    this.userInfo,
    this.unreadCount,
    this.companyName,
  });

  UserInfo ?userInfo;
  int? unreadCount;
  String ?companyName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userInfo: UserInfo.fromJson(json["userInfo"]),
    unreadCount: json["unreadCount"],
    companyName: json["companyName"],

  );

  Map<String, dynamic> toJson() => {
    "userInfo": userInfo!.toJson(),
    "unreadCount": unreadCount,
    "companyName":companyName,

  };
}

class UserInfo {
  UserInfo({
    this.firstName,
    this.lastName,
    this.image,
    this.planData,
    this.planName,
    this.id,

  });

  String ?firstName;
  String ?lastName;
  String ?image;
  List<PlanData>? planData;
  List<dynamic> ?planName;
  String ?id;


  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    firstName: json["firstName"],
    lastName: json["lastName"],
    image: json["image"],
       planData: List<PlanData>.from(json["planData"].map((x) => PlanData.fromJson(x))),
    planName: List<dynamic>.from(json["planName"].map((x) => x)),
    id: json["_id"],

  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "image": image,
    "planData": List<dynamic>.from(planData!.map((x) => x.toJson())),
    "planName": List<dynamic>.from(planName!.map((x) => x)),
    "_id": id,


  };



}

class PlanData {
  PlanData({
    this.plan,
    this.features,
    this.validity,
  });

  String ?plan;
  List<Feature>? features;
  String ?validity;

  factory PlanData.fromJson(Map<String, dynamic> json) => PlanData(
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

  String? keyName;
  String ?constName;
  int? keyValue;
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
