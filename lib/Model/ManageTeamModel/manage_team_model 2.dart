// To parse this JSON data, do
//
//     final manageTeam = manageTeamFromJson(jsonString);

import 'dart:convert';

ManageTeam manageTeamFromJson(String str) => ManageTeam.fromJson(json.decode(str));

String manageTeamToJson(ManageTeam data) => json.encode(data.toJson());

class ManageTeam {
  ManageTeam({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String ?message;
  List<Datum>? data;
  int ?totalCount;

  factory ManageTeam.fromJson(Map<String, dynamic> json) => ManageTeam(
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
  Datum({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.personName,
    this.mobileNumber,
    this.image,
    this.accessLevel,
    this.runningStatus,
  });

  String ?id;
  String ?email;
  String ?firstName;
  String ?lastName;
  String ?personName;
  String ?mobileNumber;
  dynamic ?image;
  String ?accessLevel;
  List<dynamic> ?runningStatus;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    email: json["email"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    personName: json["personName"],
    mobileNumber: json["mobileNumber"],
    image: json["image"],
    accessLevel: json["accessLevel"],
    runningStatus: List<dynamic>.from(json["runningStatus"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
    "personName": personName,
    "mobileNumber": mobileNumber,
    "image": image,
    "accessLevel": accessLevel,
    "runningStatus": List<dynamic>.from(runningStatus!.map((x) => x)),
  };
}
