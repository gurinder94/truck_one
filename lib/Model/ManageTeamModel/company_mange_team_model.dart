// To parse this JSON data, do
//
//     final companyManageTeamModel = companyManageTeamModelFromJson(jsonString);

import 'dart:convert';


CompanyManageTeamModel companyManageTeamModelFromJson(String str) => CompanyManageTeamModel.fromJson(json.decode(str));

String companyManageTeamModelToJson(CompanyManageTeamModel data) => json.encode(data.toJson());

class CompanyManageTeamModel {
  CompanyManageTeamModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String ?message;
  List<Datum>? data;
  int ?totalCount;

  factory CompanyManageTeamModel.fromJson(Map<String, dynamic> json) => CompanyManageTeamModel(
    code: json["code"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}

class Datum {
  var lastName;
  var firstName;

  Datum({
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
    this.documents,
    this.lastName,
    this.firstName
  });

  String ?id;
  String ?driverId;
  DateTime ?dateOfJoining;
  String ?mobileNumber;
  String? email;
  String ?personName;
  dynamic driverImage;
  List<Skill>? skills;
  int ? experience;
  dynamic city;
  bool ?isDeleted;
  bool ?isActive;
  String ?isAccepted;
  dynamic address;
  dynamic postalCode;
  String ?companyId;
  String ?companyName;
  dynamic licenseImage;
  dynamic licenseType;
  dynamic licenseInfo;
  String ?accessLevel;
  List<Document>? documents;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    lastName: json["lastName"],
    firstName: json["firstName"],
    driverId: json["driverId"],
    dateOfJoining: json["dateOfJoining"] == null ? null : DateTime.parse(json["dateOfJoining"]),
    mobileNumber: json["mobileNumber"],
    email: json["email"],
    personName: json["personName"],
    driverImage: json["driverImage"],
    skills: List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
    experience: json["experience"] == null ? null : json["experience"],
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
    documents: List<Document>.from(json["documents"].map((x) => Document.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "driverId": driverId,
    "dateOfJoining": dateOfJoining == null ? DateTime.now() : dateOfJoining!.toIso8601String(),
    "mobileNumber": mobileNumber,
    "email": email,
    "lastName": lastName,
    "firstName": firstName,
    "personName": personName,
    "driverImage": driverImage,
    "skills": List<dynamic>.from(skills!.map((x) => x.toJson())),
    "experience": experience == null ? null : experience,
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
    "documents": List<dynamic>.from(documents!.map((x) => x.toJson())),
  };
}

class Skill {
  Skill({
    this.id,
    this.skillId,
  });

  String? id;
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
class Document {
  Document({
    this.name,
    this.fileName,
    this.id,
  });

  String ?name;
  String ?fileName;
  String ?id;

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
