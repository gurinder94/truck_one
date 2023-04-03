// To parse this JSON data, do
//
//     final sellerProfileModel = sellerProfileModelFromJson(jsonString);

import 'dart:convert';

SellerProfileModel sellerProfileModelFromJson(String str) => SellerProfileModel.fromJson(json.decode(str));

String sellerProfileModelToJson(SellerProfileModel data) => json.encode(data.toJson());

class SellerProfileModel {
  SellerProfileModel({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String ?message;
  Data ?data;

  factory SellerProfileModel.fromJson(Map<String, dynamic> json) => SellerProfileModel(
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
    this.id,
    this.roleData,
    this.personName,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.profileImage,
    this.dateOfBirth,
    this.address,
    this.city,
    this.postalCode,
    this.progressBar,
    this.profileComplete,
    this.sellerData,
    this.isActive,
    this.isDeleted,
    this.state,
    this.country,
    this.countryName,
    this.statesName,
  });

  String ?id;
  String ?roleData;
  String ?personName;
  String ?firstName;
  String ?lastName;
  String ?email;
  String ?mobileNumber;
  dynamic profileImage;
  DateTime? dateOfBirth;
  String? address;
  String ?city;
  String ?postalCode;
  dynamic progressBar;
  bool ?profileComplete;
  SellerData ?sellerData;
  bool ?isActive;
  bool ?isDeleted;
  String ?state;
  String ?country;
  String ?countryName;
  String ?statesName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    roleData: json["roleData"],
    personName: json["personName"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    mobileNumber: json["mobileNumber"],
    profileImage: json["profileImage"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    address: json["address"],
    city: json["city"],
    postalCode: json["postalCode"],
    progressBar: json["progressBar"],
    profileComplete: json["profileComplete"],
    sellerData: SellerData.fromJson(json["sellerData"]),
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    state: json["state"],
    country: json["country"],
    countryName: json["countryName"],
    statesName: json["statesName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "roleData": roleData,
    "personName": personName,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "mobileNumber": mobileNumber,
    "profileImage": profileImage,
    "dateOfBirth": dateOfBirth,
    "address": address,
    "city": city,
    "postalCode": postalCode,
    "progressBar": progressBar,
    "profileComplete": profileComplete,
    "sellerData": sellerData!.toJson(),
    "isActive": isActive,
    "isDeleted": isDeleted,
    "state": state,
    "country": country,
    "countryName": countryName,
    "statesName": statesName,
  };
}

class SellerData {
  SellerData({
    this.id,
    this.legalEntity,
    this.legalEntityOption,
    this.ssnNumber,
    this.yesLegalEntityOption,
    this.dateOfBirth,
    this.companyName,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String ?id;
  String ?legalEntity;
  String ?legalEntityOption;
  String ?ssnNumber;
  dynamic yesLegalEntityOption;
  DateTime? dateOfBirth;
  String ?companyName;
  String ?userId;
  DateTime? createdAt;
  DateTime ?updatedAt;
  int ?v;

  factory SellerData.fromJson(Map<String, dynamic> json) => SellerData(
    id: json["_id"],
    legalEntity: json["legalEntity"],
    legalEntityOption: json["legalEntityOption"],
    ssnNumber: json["ssnNumber"],
    yesLegalEntityOption: json["yesLegalEntityOption"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    companyName: json["companyName"],
    userId: json["userId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "legalEntity": legalEntity,
    "legalEntityOption": legalEntityOption,
    "ssnNumber": ssnNumber,
    "yesLegalEntityOption": yesLegalEntityOption,
    "dateOfBirth": dateOfBirth,
    "companyName": companyName,
    "userId": userId,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}
