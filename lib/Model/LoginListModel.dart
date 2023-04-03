// To parse this JSON data, do
//
//     final loginListModel = loginListModelFromJson(jsonString);

import 'dart:convert';

LoginListModel loginListModelFromJson(String str) =>
    LoginListModel.fromJson(json.decode(str));

String loginListModelToJson(LoginListModel data) => json.encode(data.toJson());

class LoginListModel {
  LoginListModel({
    this.code,
    this.message,
    this.data,
    this.roles,
    this.token,
    this.companyName,
  });

  int? code;
  String? message;
  Data? data;
  List<Role>? roles;
  String? token;
  String? companyName;

  factory LoginListModel.fromJson(Map<String, dynamic> json) => LoginListModel(
        code: json["code"],
        message: json["message"],
        data: json["data"]==null?null:Data.fromJson(json["data"]),
        roles: json["roles"] == null
            ? []
            : List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        token:json["token"]==null?null: json["token"],
        companyName:json["companyName"]==null?null: json["companyName"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data!.toJson(),
        "roles": List<dynamic>.from(roles!.map((x) => x.toJson())),
        "token": token,
        "companyName": companyName,
      };
}

class Data {
  Data({
    this.email,
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
    this.progressBar,
    this.profileComplete,
    this.isLeft,
    this.isApproved,
    this.dateOfJoining,
    this.planData,
    this.id,
    this.roleId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.token,
    this.country,
    this.state,
    this.companyId,
    this.defaultLanguage,
    this.policyStatus,
  });

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
  String? resetkey;
  dynamic paymentToken;
  String? accessLevel;
  String? otp;
  int? progressBar;
  bool? profileComplete;
  bool? isLeft;
  bool? isApproved;
  String? dateOfJoining;
  List<PlanData>? planData;
  String? id;
  RoleId? roleId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? token;
  String? country;
  String? state;
  String? companyId;
  String? defaultLanguage;
  bool ?policyStatus;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        progressBar:
            json["progressBar"] == null ? 1 : json["progressBar"].floor(),
        profileComplete: json["profileComplete"],
        isLeft: json["isLeft"],
        isApproved: json["isApproved"],
        dateOfJoining: json["dateOfJoining"],
        planData: List<PlanData>.from(
            json["planData"].map((x) => PlanData.fromJson(x))),
        id: json["_id"],
        roleId: RoleId.fromJson(json["roleId"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        token: json["token"],
        country: json["country"],
        state: json["state"],
        companyId: json["companyId"],
    defaultLanguage: json["defaultLanguage"]??'en',
      policyStatus:json["policyStatus"]
      );

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
        "progressBar": progressBar,
        "profileComplete": profileComplete,
        "isLeft": isLeft,
        "isApproved": isApproved,
        "dateOfJoining": dateOfJoining,
        "planData": List<dynamic>.from(planData!.map((x) => x.toJson())),
        "_id": id,
        "roleId": roleId!.toJson(),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "token": token,
        "country": country,
        "state": state,
        "companyId": companyId,
        "defaultLanguage": defaultLanguage,
    "policyStatus":policyStatus,
      };
}

class PlanData {
  PlanData({
    this.plan,
    this.features,
    this.validity,
  });

  String? plan;
  List<Feature>? features;
  String? validity;

  factory PlanData.fromJson(Map<String, dynamic> json) => PlanData(
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

class RoleId {
  RoleId({
    this.roleTitle,
    this.id,
  });

  String? roleTitle;
  String? id;

  factory RoleId.fromJson(Map<String, dynamic> json) => RoleId(
        roleTitle: json["roleTitle"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "roleTitle": roleTitle,
        "_id": id,
      };
}

class Role {
  Role({
    this.id,
    this.roleTitle,
    this.roleName,
    this.isActive,
    this.isDeleted,
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
  String? createdbyId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? createdById;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["_id"],
        roleTitle: json["roleTitle"],
        roleName: json["roleName"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
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
        "createdby_id": createdbyId == null ? null : createdbyId,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v == null ? null : v,
        "createdById": createdById == null ? null : createdById,
      };
}
