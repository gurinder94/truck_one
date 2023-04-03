import 'package:flutter/cupertino.dart';

class LoginModel extends ChangeNotifier {
  LoginModel({
    this.email,
    this.password,
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
    this.id,
    this.roleId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.country,
    this.state,
    this.accessLevel,
  });

  String ?email;
  String ?password;
  String ?personName;
  String ?mobileNumber;
  bool ?isDeleted;
  bool ?isActive;
  String ?isAccepted;
  String ?address;
  String ?city;
  String ?postalCode;
  String ?image;
  String ?deviceType;
  dynamic resetkey;
  String ?accessLevel;
  String ?id;
  String ?roleId;
  DateTime ?createdAt;
  DateTime ?updatedAt;
  int ?v;
  String ?country;
  String ?state;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json["email"],
        password: json["password"],
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
        id: json["_id"],
        roleId: json["roleId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        country: json["country"],
        state: json["state"],
    accessLevel: json["accessLevel"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
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
        "_id": id,
        "roleId": roleId,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "country": country,
        "state": state,
    "accessLevel":accessLevel,
      };
}
