// To parse this JSON data, do
//
//     final jobListDetailModel = jobListDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

JobListDetailModel jobListDetailModelFromJson(String str) =>
    JobListDetailModel.fromJson(json.decode(str));

String jobListDetailModelToJson(JobListDetailModel data) =>
    json.encode(data.toJson());

class JobListDetailModel {
  JobListDetailModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<JobDetailModel>? data;

  factory JobListDetailModel.fromJson(Map<String, dynamic> json) =>
      JobListDetailModel(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<JobDetailModel>.from(
                json["data"].map((x) => JobDetailModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class JobDetailModel extends ChangeNotifier {
  JobDetailModel({
    this.id,
    this.functionalArea,
    this.industryData,
    this.userdata,
    this.skillData,
    this.description,
    this.address,
    this.isSaved,
    this.vacancy,
    this.qualificationData,
    this.qualification,
    this.industry,
    this.functionalAreaId,
    this.walkInDetails,
    this.salaryRang,
    this.title,
    this.employmentType,
    this.showRecruiter,
    this.role,
    this.minimumExperience,
    this.maximumExperience,
    this.companyName,
    this.companyLogo,
    this.bannerImage,
    this.skills,
    this.companyDetails,
    this.createdAt,
    this.applicantCount,
    this.companyWebsite,
    this.iswalkInDetails,
    this.isDeleted,
    this.city,
    this.postedAt,
    this.alreadyApplied,
    this.fullAddress,
    this.salaryType,
    this.companyId,
  });

  String? id;
  FunctionalArea? functionalArea;
  IndustryData? industryData;
  Userdata? userdata;
  List<String>? skillData;
  String? description;
  Address? address;
  bool? isSaved;
  int? vacancy;
  List<QualificationDatum>? qualificationData;

  List<Qualification>? qualification;
  String? industry;
  String? functionalAreaId;
  List<WalkInDetail>? walkInDetails;
  List<SalaryRang>? salaryRang;
  String? title;
  String? employmentType;
  dynamic showRecruiter;
  String? role;
  int? minimumExperience;
  int? maximumExperience;
  String? companyName;
  dynamic companyLogo;
  dynamic bannerImage;
  List<Skill>? skills;
  String? companyDetails;
  DateTime? createdAt;
  int? applicantCount;
  String? companyWebsite;
  bool? iswalkInDetails;
  bool? isDeleted;
  String? city;
  String? postedAt;
  bool? alreadyApplied;
  String? fullAddress;
  String? salaryType;
  String? companyId;

  factory JobDetailModel.fromJson(Map<String, dynamic> json) => JobDetailModel(
        id: json["_id"],
        functionalArea: FunctionalArea.fromJson(json["functionalArea"]),
        industryData: IndustryData.fromJson(json["industryData"]),
        userdata: Userdata.fromJson(json["userdata"]),
        skillData: List<String>.from(json["skillData"].map((x) => x)),
        description: json["description"],
        address: Address.fromJson(json["address"]),
        isSaved: json["isSaved"],
        vacancy: json["vacancy"],
        qualificationData: List<QualificationDatum>.from(
            json["qualificationData"]
                .map((x) => QualificationDatum.fromJson(x))),
        qualification: List<Qualification>.from(
            json["qualification"].map((x) => Qualification.fromJson(x))),
        industry: json["industry"],
        functionalAreaId: json["functionalAreaId"],
        walkInDetails: List<WalkInDetail>.from(
            json["walkInDetails"].map((x) => WalkInDetail.fromJson(x))),
        salaryRang: List<SalaryRang>.from(
            json["salaryRang"].map((x) => SalaryRang.fromJson(x))),
        title: json["title"],
        employmentType: json["employmentType"],
        showRecruiter: json["showRecruiter"],
        role: json["role"],
        minimumExperience: json["minimumExperience"],
        maximumExperience: json["maximumExperience"],
        companyName: json["companyName"],
        companyLogo: json["companyLogo"],
        bannerImage: json["bannerImage"],
        skills: List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
        companyDetails: json["companyDetails"],
        createdAt: DateTime.parse(json["createdAt"]),
        applicantCount: json["applicantCount"],
        companyWebsite:
            json["companyWebsite"] == null ? 'N/A' : json["companyWebsite"],
        iswalkInDetails: json["iswalkInDetails"],
        isDeleted: json["isDeleted"],
        city: json["city"],
        postedAt: json["postedAt"],
        alreadyApplied: json["alreadyApplied"],
        fullAddress: json["fullAddress"],
        salaryType: json["salaryType"],
        companyId: json["companyId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "functionalArea": functionalArea!.toJson(),
        "industryData": industryData!.toJson(),
        "userdata": userdata!.toJson(),
        "skillData": List<dynamic>.from(skillData!.map((x) => x)),
        "description": description,
        "address": address!.toJson(),
        "isSaved": isSaved,
        "vacancy": vacancy,
        "qualificationData":
            List<dynamic>.from(qualificationData!.map((x) => x.toJson())),
        "qualification":
            List<dynamic>.from(qualification!.map((x) => x.toJson())),
        "industry": industry,
        "functionalAreaId": functionalAreaId,
        "walkInDetails":
            List<dynamic>.from(walkInDetails!.map((x) => x.toJson())),
        "salaryRang": List<dynamic>.from(salaryRang!.map((x) => x.toJson())),
        "title": title,
        "employmentType": employmentType,
        "showRecruiter": showRecruiter,
        "role": role,
        "minimumExperience": minimumExperience,
        "maximumExperience": maximumExperience,
        "companyName": companyName,
        "companyLogo": companyLogo,
        "bannerImage": bannerImage,
        "skills": List<dynamic>.from(skills!.map((x) => x.toJson())),
        "companyDetails": companyDetails,
        "createdAt": createdAt!.toIso8601String(),
        "applicantCount": applicantCount,
        "companyWebsite": companyWebsite,
        "iswalkInDetails": iswalkInDetails,
        "isDeleted": isDeleted,
        "city": city,
        "postedAt": postedAt,
        "alreadyApplied": alreadyApplied,
        "fullAddress": fullAddress,
        "salaryType": salaryType,
        "companyId": companyId,
      };
}

class Address {
  Address({
    this.coordinates,
    this.fullAddress,
  });

  List<double>? coordinates;
  String? fullAddress;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        fullAddress: json["fullAddress"] == null ? 'N/A' : json["fullAddress"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
        "fullAddress": fullAddress,
      };
}

class FunctionalArea {
  FunctionalArea({
    this.id,
    this.name,
    this.roles,
  });

  String? id;
  String? name;
  List<String>? roles;

  factory FunctionalArea.fromJson(Map<String, dynamic> json) => FunctionalArea(
        id: json["_id"],
        name: json["name"],
        roles: List<String>.from(json["roles"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "roles": List<dynamic>.from(roles!.map((x) => x)),
      };
}

class IndustryData {
  IndustryData({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory IndustryData.fromJson(Map<String, dynamic> json) => IndustryData(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class Qualification {
  Qualification({
    this.id,
    this.qualificationId,
  });

  String? id;
  String? qualificationId;

  factory Qualification.fromJson(Map<String, dynamic> json) => Qualification(
        id: json["_id"],
        qualificationId: json["qualificationId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "qualificationId": qualificationId,
      };
}

class QualificationDatum {
  var isvalue;
  var skill;
  var isValue;

  QualificationDatum({
    this.id,
    this.qualification,
    this.isActive,
    this.skill,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? qualification;
  bool? isActive;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory QualificationDatum.fromJson(Map<String, dynamic> json) =>
      QualificationDatum(
        id: json["_id"],
        qualification: json["qualification"],
        skill: json["skill"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "qualification": qualification,
        "skill": skill,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}

class SalaryRang {
  SalaryRang({
    this.currency,
    this.min,
    this.max,
    this.visilble,
    this.id,
  });

  String? currency;
  int? min;
  int? max;
  bool? visilble;
  String? id;

  factory SalaryRang.fromJson(Map<String, dynamic> json) => SalaryRang(
        currency: json["currency"],
        min: json["min"],
        max: json["max"],
        visilble: json["visilble"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "min": min,
        "max": max,
        "visilble": visilble,
        "_id": id,
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

class Userdata {
  Userdata({
    this.id,
    this.personName,
    this.email,
    this.mobileNumber,
  });

  String? id;
  String? personName;
  String? email;
  String? mobileNumber;

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
        id: json["_id"],
        personName: json["personName"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "personName": personName,
        "email": email,
        "mobileNumber": mobileNumber,
      };
}

class WalkInDetail {
  WalkInDetail({
    this.startDate,
    this.endDate,
    this.duration,
    this.timing,
    this.contactPerson,
    this.number,
    this.venue,
    this.url,
    this.id,
  });

  DateTime? startDate;
  DateTime? endDate;
  dynamic duration;
  dynamic timing;
  String? contactPerson;
  String? number;
  String? venue;
  dynamic url;
  String? id;

  factory WalkInDetail.fromJson(Map<String, dynamic> json) => WalkInDetail(
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        duration: json["duration"],
        timing: json["timing"],
        contactPerson:
            json["contactPerson"] == null ? 'N/A' : json["contactPerson"],
        number: json["number"] == null ? 'N/A' : json["number"],
        venue: json["venue"] == null ? 'N/A' : json["venue"],
        url: json["url"] == null ? 'N/A' : json["url"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate,
        "endDate": endDate,
        "duration": duration,
        "timing": timing,
        "contactPerson": contactPerson,
        "number": number,
        "venue": venue,
        "url": url,
        "_id": id,
      };
}
