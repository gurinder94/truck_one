// To parse this JSON data, do
//
//     final driverDetailListModel = driverDetailListModelFromJson(jsonString);

import 'dart:convert';

DriverDetailListModel driverDetailListModelFromJson(String str) => DriverDetailListModel.fromJson(json.decode(str));

String driverDetailListModelToJson(DriverDetailListModel data) => json.encode(data.toJson());

class DriverDetailListModel {
  DriverDetailListModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String ?message;
  DriverDetail ?data;

  factory DriverDetailListModel.fromJson(Map<String, dynamic> json) => DriverDetailListModel(
    code: json["code"],
    message: json["message"],
    data: DriverDetail.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data!.toJson(),
  };
}

class DriverDetail {
  DriverDetail({
    this.id,
    this.email,
    this.personName,
    this.mobileNumber,
    this.isDeleted,
    this.isActive,
    this.image,
    this.gender,
    this.dateOfBirth,
    this.experience,
    this.maritalStatus,
    this.language,
    this.workPlace,
    this.designation,
    this.corrAddress,
    this.permAddress,
    this.skills,
    this.qualification,
    this.proImage,
    this.skillData,
    this.companyName,
    this.licenseImage,
    this.licenseType,
    this.licenseInfo,
    this.profileComplete,
  });

  String ?id;
  String ?email;
  String ?personName ;
  String ?mobileNumber;
  bool ?isDeleted;
  bool ?isActive;
  dynamic image;
  String? gender;
  DateTime? dateOfBirth;
  int ?experience;
  String ?maritalStatus;
  List<String>? language;
  String ?workPlace;
  String ?designation;
  String ?corrAddress;
  String ?permAddress;
  List<Skill>? skills;
  List<Qualification>? qualification;
  dynamic proImage;
  List<Qualification>? skillData;
  String ?companyName;
  dynamic licenseImage;
  dynamic licenseType;
  dynamic licenseInfo;
  bool ?profileComplete;

  factory DriverDetail.fromJson(Map<String, dynamic> json) => DriverDetail(
    id: json["_id"],
    email: json["email"],
    personName: json["personName"]?? '',
    mobileNumber: json["mobileNumber"],
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    image: json["image"],
    gender: json["gender"],
    // dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    experience: json["experience"],
    maritalStatus: json["maritalStatus"],
    language: List<String>.from(json["language"].map((x) => x)),
    workPlace: json["workPlace"],
    designation: json["designation"],
    corrAddress: json["corrAddress"],
    permAddress: json["permAddress"],
    skills: List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
    qualification: List<Qualification>.from(json["qualification"].map((x) => Qualification.fromJson(x))),
    proImage: json["proImage"],
    skillData: List<Qualification>.from(json["skillData"].map((x) => Qualification.fromJson(x))),
    companyName: json["companyName"],
    licenseImage: json["licenseImage"],
    licenseType: json["licenseType"],
    licenseInfo: json["licenseInfo"],
    profileComplete: json["profileComplete"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "personName": personName,
    "mobileNumber": mobileNumber,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "image": image,
    "gender": gender,
    "dateOfBirth": dateOfBirth!.toIso8601String(),
    "experience": experience,
    "maritalStatus": maritalStatus,
    "language": List<dynamic>.from(language!.map((x) => x)),
    "workPlace": workPlace,
    "designation": designation,
    "corrAddress": corrAddress,
    "permAddress": permAddress,
    "skills": List<dynamic>.from(skills!.map((x) => x.toJson())),
    "qualification": List<dynamic>.from(qualification!.map((x) => x.toJson())),
    "proImage": proImage,
    "skillData": List<dynamic>.from(skillData!.map((x) => x.toJson())),
    "companyName": companyName,
    "licenseImage": licenseImage,
    "licenseType": licenseType,
    "licenseInfo": licenseInfo,
    "profileComplete": profileComplete,
  };
}

class Qualification {
  Qualification({
    this.id,
    this.qualification,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isDeleted,
    this.skill,
    this.createdById,
  });

  String ?id;
  String ?qualification;
  bool ?isActive;
  DateTime? createdAt;
  DateTime ?updatedAt;
  int ?v;
  bool? isDeleted;
  String? skill;
  String ?createdById;

  factory Qualification.fromJson(Map<String, dynamic> json) => Qualification(
    id: json["_id"],
    qualification: json["qualification"] == null ? null : json["qualification"],
    isActive: json["isActive"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    isDeleted: json["isDeleted"],
    skill: json["skill"] == null ? null : json["skill"],
    createdById: json["createdById"] == null ? null : json["createdById"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "qualification": qualification == null ? null : qualification,
    "isActive": isActive,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
    "isDeleted": isDeleted,
    "skill": skill == null ? null : skill,
    "createdById": createdById == null ? null : createdById,
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
