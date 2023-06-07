// To parse this JSON data, do
//
//     final sellerManageTeamModel = sellerManageTeamModelFromJson(jsonString);

import 'dart:convert';

SellerManageTeamModel sellerManageTeamModelFromJson(String str) => SellerManageTeamModel.fromJson(json.decode(str));

String sellerManageTeamModelToJson(SellerManageTeamModel data) => json.encode(data.toJson());

class SellerManageTeamModel {
  SellerManageTeamModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String ?message;
  List<SellerManageTeam>? data;
  int ?totalCount;

  factory SellerManageTeamModel.fromJson(Map<String, dynamic> json) => SellerManageTeamModel(
    code: json["code"],
    message: json["message"],
    data: List<SellerManageTeam>.from(json["data"].map((x) => SellerManageTeam.fromJson(x))),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}

class SellerManageTeam {
  SellerManageTeam({
    this.id,
    this.driverId,
    this.dateOfJoining,
    this.mobileNumber,
    this.email,
    this.personName,
    this.driverImage,
    this.skills,
    this.experience,
    this.city,
    this.isDeleted,
    this.isActive,
    this.isAccepted,
    this.address,
    this.postalCode,
    this.companyId,
    this.companyName,
    this.licenseImage,
    this.licenseType,
    this.licenseInfo,
    this.accessLevel,
    this.userId,
  });

  String ?id;
  String ?driverId;
  DateTime? dateOfJoining;
  String ?mobileNumber;
  String ?email;
  String ?personName;
  dynamic driverImage;
  List<Skill>? skills;
  var experience;
  dynamic city;
  bool? isDeleted;
  bool ?isActive;
  String? isAccepted;
  dynamic address;
  dynamic postalCode;
  String ?companyId;
  String ?companyName;
  dynamic licenseImage;
  dynamic licenseType;
  dynamic licenseInfo;
  String ?accessLevel;
  String ?userId;

  factory SellerManageTeam.fromJson(Map<String, dynamic> json) => SellerManageTeam(
    id: json["_id"],
    driverId: json["driverId"],
    // dateOfJoining: DateTime.parse(json["dateOfJoining"]),
    mobileNumber: json["mobileNumber"],
    email: json["email"],
    personName: json["personName"],
    driverImage: json["driverImage"],
    skills: List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
    experience: json["experience"],
    city: json["city"],
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    isAccepted: json["isAccepted"],
    address: json["address"],
    postalCode: json["postalCode"],
    companyId: json["companyId"],
    companyName: json["companyName"],
    licenseImage: json["licenseImage"],
    licenseType: json["licenseType"],
    licenseInfo: json["licenseInfo"],
    accessLevel: json["accessLevel"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "driverId": driverId,

    "mobileNumber": mobileNumber,
    "email": email,
    "personName": personName,
    "driverImage": driverImage,
    "skills": List<dynamic>.from(skills!.map((x) => x.toJson())),
    "experience": experience,
    "city": city,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "isAccepted": isAccepted,
    "address": address,
    "postalCode": postalCode,
    "companyId": companyId,
    "companyName": companyName,
    "licenseImage": licenseImage,
    "licenseType": licenseType,
    "licenseInfo": licenseInfo,
    "accessLevel": accessLevel,
    "userId": userId,
  };
}

class Skill {
  Skill({
    this.id,
    this.skillId,
  });

  String ?id;
  String ?skillId;

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
    id: json["_id"],
    skillId: json["skillId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "skillId": skillId,
  };
}
