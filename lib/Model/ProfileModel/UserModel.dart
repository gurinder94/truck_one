// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserModel userProfileFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String userProfileToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  Data? data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  var otherSkill;

  var otherQualification;

  var monthsExperience;

  Data({
    this.id,
    this.email,
    this.personName,
    this.otherQualification,
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
    this.monthsExperience,
    this.permAddress,
    this.skills,
    this.qualification,
    this.proImage,
    this.skillData,
    this.licenseImage,
    this.licenseType,
    this.licenseInfo,
    this.firstName,
    this.lastName,
    this.documents,
    this.createdById,
    this.aboutUser,
    this.otherSkill,
    this.bannerImage,
    this.companyName,
  });

  String? id;
  String? email;
  String? personName;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  bool? isDeleted;
  bool? isActive;
  String? image;
  String? gender;
  DateTime? dateOfBirth;
  var experience;
  String? maritalStatus;
  List<String>? language;
  String? workPlace;
  String? designation;
  String? corrAddress;
  String? permAddress;
  List<Skill>? skills;
  List<Qualifications>? qualification;
  String? proImage;
  List<Qualifications>? skillData;
  dynamic licenseImage;
  String? bannerImage;
  dynamic licenseType;
  dynamic licenseInfo;
  List<Document>? documents;
  String? createdById;
  String? aboutUser;
  String? companyName;
  var d;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      id: json["_id"],
      email: json["email"],
      personName: json["personName"],
      monthsExperience: json["monthsExperience"],
      mobileNumber: json["mobileNumber"],
      otherQualification: json["otherQualification"],
      otherSkill: json["otherSkill"],
      isDeleted: json["isDeleted"],
      isActive: json["isActive"],
      image: json["image"] == null ? null : json["image"],
      gender: json["gender"],
      dateOfBirth: json["dateOfBirth"] == null
          ? null
          : DateTime.parse(json["dateOfBirth"]),
      experience: json["experience"],
      maritalStatus: json["maritalStatus"],
      language: List<String>.from(json["language"].map((x) => x)),
      workPlace: json["workPlace"],
      designation: json["designation"],
      corrAddress: json["corrAddress"],
      permAddress: json["permAddress"],
      skills: List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
      qualification: List<Qualifications>.from(
          json["qualification"].map((x) => Qualifications.fromJson(x))),
      proImage: json["image"],
      skillData: List<Qualifications>.from(
          json["skillData"].map((x) => Qualifications.fromJson(x))),
      licenseImage: json["licenseImage"],
      licenseType: json["licenseType"],
      licenseInfo: json["licenseInfo"],
      firstName: json['firstName'],
      lastName: json['lastName'],
      createdById: json["createdById"],
      aboutUser: json["aboutUser"],
      bannerImage: json["bannerImage"],
      documents: List<Document>.from(
          json["documents"].map((x) => Document.fromJson(x))),
      companyName: json["companyName"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "personName": personName,
        "mobileNumber": mobileNumber,
        "isDeleted": isDeleted,
        "isActive": isActive,
        "otherQualification": otherQualification,
        "image": image,
        "gender": gender,
        "dateOfBirth": dateOfBirth!.toIso8601String(),
        "experience": experience,
        "maritalStatus": maritalStatus,
        "language": List<dynamic>.from(language!.map((x) => x)),
        "workPlace": workPlace,
        "monthsExperience": monthsExperience,
        "designation": designation,
        "otherSkill": otherSkill,
        "corrAddress": corrAddress,
        "permAddress": permAddress,
        "skills": List<dynamic>.from(skills!.map((x) => x.toJson())),
        "qualification":
            List<dynamic>.from(qualification!.map((x) => x.toJson())),
        "image": proImage,
        "skillData": List<dynamic>.from(skillData!.map((x) => x.toJson())),
        "licenseImage": licenseImage,
        "licenseType": licenseType,
        "licenseInfo": licenseInfo,
        "firstName": firstName,
        "lastName": lastName,
        "documents": List<dynamic>.from(documents!.map((x) => x.toJson())),
        "createdById": createdById,
        "aboutUser": aboutUser,
        "bannerImage": bannerImage,
        "companyName": companyName
      };
}

class Qualifications {
  Qualifications({
    this.id,
    this.qualification,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.skill,
    this.createdById,
  });

  String? id;
  String? qualification;
  bool? isActive;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? skill;
  String? createdById;

  factory Qualifications.fromJson(Map<String, dynamic> json) => Qualifications(
        id: json["_id"],
        qualification:
            json["qualification"] == null ? null : json["qualification"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        skill: json["skill"] == null ? null : json["skill"],
        createdById: json["createdById"] == null ? null : json["createdById"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "qualification": qualification == null ? null : qualification,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "skill": skill == null ? null : skill,
        "createdById": createdById == null ? null : createdById,
      };
}

class Skill {
  Skill({
    this.id,
    this.skillId,
  });

  String? id;
  String? skillId;

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        id: json["_id"],
        skillId: json["skillId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "skillId": skillId,
      };
}

class Document {
  Document({
    this.name,
    this.fileName,
    this.id,
  });

  String? name;
  String? fileName;
  String? id;
  bool check = false;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        name: json["name"],
        fileName: json["fileName"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "fileName": fileName,
        "_id": id,
      };
}
