// To parse this JSON data, do
//
//     final switchUserModel = switchUserModelFromJson(jsonString);

import 'dart:convert';

SwitchUserModel switchUserModelFromJson(String str) =>
    SwitchUserModel.fromJson(json.decode(str));

String switchUserModelToJson(SwitchUserModel data) =>
    json.encode(data.toJson());

class SwitchUserModel {
  SwitchUserModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  Data? data;

  factory SwitchUserModel.fromJson(Map<String, dynamic> json) =>
      SwitchUserModel(
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
  Data(
      {this.token,
      this.userInfo,
      this.multipleRole,
      this.companyName,
      this.sellerName,
      this.companyId});

  String? token;
  UserInfo? userInfo;
  List<MultipleRole>? multipleRole;
  String? companyName;
  String? companyId;
  String? sellerName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      token: json["token"],
      userInfo: UserInfo.fromJson(json["userInfo"]),
      multipleRole: List<MultipleRole>.from(
          json["multipleRole"].map((x) => MultipleRole.fromJson(x))),
      companyName: json["companyName"],
      sellerName: json["sellerName"],
      companyId: json["companyId"]);

  Map<String, dynamic> toJson() => {
        "token": token,
        "userInfo": userInfo!.toJson(),
        "multipleRole":
            List<dynamic>.from(multipleRole!.map((x) => x.toJson())),
        "companyName": companyName,
        "sellerName": sellerName,
        "companyId": companyId
      };
}

class MultipleRole {
  MultipleRole({
    this.id,
    this.roleTitle,
    this.roleName,
    this.isActive,
    this.isDeleted,
    this.isAdmin,
    this.createdbyId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.createdById,
  });

  String? id;
  String? roleTitle;
  String? roleName;
  bool? isActive;
  bool? isDeleted;
  bool? isAdmin;
  String? createdbyId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? createdById;

  factory MultipleRole.fromJson(Map<String, dynamic> json) => MultipleRole(
        id: json["_id"],
        roleTitle: json["roleTitle"],
        roleName: json["roleName"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        isAdmin: json["isAdmin"],
        createdbyId: json["createdby_id"] == null ? null : json["createdby_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
        createdById: json["createdById"] == null ? null : json["createdById"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "roleTitle": roleTitle,
        "roleName": roleName,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "isAdmin": isAdmin,
        "createdby_id": createdbyId == null ? null : createdbyId,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v == null ? null : v,
        "createdById": createdById == null ? null : createdById,
      };
}

class UserInfo {
  UserInfo(
      {this.email,
      this.firstName,
      this.lastName,
      this.personName,
      this.mobileNumber,
      this.isDeleted,
      this.isActive,
      this.isAccepted,
      this.address,
      this.city,
      this.postalCode,
      this.image,
      this.deviceType,
      this.resetkey,
      this.paymentToken,
      this.accessLevel,
      this.otp,
      this.otpGenerationDate,
      this.progressBar,
      this.profileComplete,
      this.isLeft,
      this.isApproved,
      this.dateOfJoining,
      this.planData,
      this.id,
      this.roleId,
      this.multiRole,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.token,
      this.country,
      this.state,
      this.defaultLanguage,
      this.companyName});

  String? email;
  String? firstName;
  String? lastName;
  String? personName;
  String? mobileNumber;
  bool? isDeleted;
  bool? isActive;
  String? isAccepted;
  String? address;
  String? city;
  String? postalCode;
  String? image;
  String? deviceType;
  dynamic resetkey;
  dynamic paymentToken;
  String? accessLevel;
  String? otp;
  dynamic otpGenerationDate;
  var progressBar;
  bool? profileComplete;
  bool? isLeft;
  bool? isApproved;
  dynamic dateOfJoining;
  List<PlanDatum>? planData;
  String? id;
  MultipleRole? roleId;
  List<MultiRole>? multiRole;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? token;
  String? country;
  String? state;
  String? defaultLanguage;
  String? companyName;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
      email: json["email"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      personName: json["personName"],
      mobileNumber: json["mobileNumber"],
      isDeleted: json["isDeleted"],
      isActive: json["isActive"],
      isAccepted: json["isAccepted"],
      address: json["address"],
      city: json["city"],
      postalCode: json["postalCode"],
      image: json["image"],
      deviceType: json["deviceType"],
      resetkey: json["resetkey"],
      paymentToken: json["paymentToken"],
      accessLevel: json["accessLevel"],
      otp: json["otp"],
      otpGenerationDate: json["otpGenerationDate"],
      progressBar: json["progressBar"],
      profileComplete: json["profileComplete"],
      isLeft: json["isLeft"],
      isApproved: json["isApproved"],
      dateOfJoining: json["dateOfJoining"],
      planData: List<PlanDatum>.from(
          json["planData"].map((x) => PlanDatum.fromJson(x))),
      id: json["_id"],
      roleId: MultipleRole.fromJson(json["roleId"]),
      multiRole: List<MultiRole>.from(
          json["multiRole"].map((x) => MultiRole.fromJson(x))),
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      v: json["__v"],
      token: json["token"],
      country: json["country"],
      state: json["state"],
      defaultLanguage: json["defaultLanguage"] ?? 'en',
      companyName: json["companyName"]);

  Map<String, dynamic> toJson() => {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "personName": personName,
        "mobileNumber": mobileNumber,
        "isDeleted": isDeleted,
        "isActive": isActive,
        "isAccepted": isAccepted,
        "address": address,
        "city": city,
        "postalCode": postalCode,
        "image": image,
        "deviceType": deviceType,
        "resetkey": resetkey,
        "paymentToken": paymentToken,
        "accessLevel": accessLevel,
        "otp": otp,
        "otpGenerationDate": otpGenerationDate,
        "progressBar": progressBar,
        "profileComplete": profileComplete,
        "isLeft": isLeft,
        "isApproved": isApproved,
        "dateOfJoining": dateOfJoining,
        "planData": List<dynamic>.from(planData!.map((x) => x.toJson())),
        "_id": id,
        "roleId": roleId!.toJson(),
        "multiRole": List<dynamic>.from(multiRole!.map((x) => x.toJson())),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "token": token,
        "country": country,
        "state": state,
        "defaultLanguage": defaultLanguage,
        "companyName": companyName,
      };
}

class MultiRole {
  MultiRole({
    this.id,
    this.roleId,
  });

  String? id;
  String? roleId;

  factory MultiRole.fromJson(Map<String, dynamic> json) => MultiRole(
        id: json["_id"],
        roleId: json["roleId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "roleId": roleId,
      };
}

class PlanDatum {
  PlanDatum({
    this.plan,
    this.features,
    this.validity,
  });

  String? plan;
  List<Feature>? features;
  String? validity;

  factory PlanDatum.fromJson(Map<String, dynamic> json) => PlanDatum(
        plan: json["plan"],
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
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
  String? constName;
  int? keyValue;
  String? id;

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
