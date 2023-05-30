import 'package:flutter/cupertino.dart';

class CompanyDetail extends ChangeNotifier {
  var middleName;

  CompanyDetail({
    this.userId,
    this.companyName,
    this.contactPerson,
    this.countryName,
    this.directorName,
    this.city,
    this.stateName,
    this.mobileNumber,
    this.incorporationDate,
    this.companyServices,
    this.postalCode,
    this.address,
    this.companyLogo,
    this.bannerImage,
    this.aboutCompany,
    this.email,
    this.firstName,
    this.lastName,
    this.middleName,
  });

  String ?userId;
  String ? companyName;
  String ?contactPerson;
  String ?countryName;
  String ?directorName;
  String ?city;
  String ?stateName;
  String ?mobileNumber;
  DateTime ?incorporationDate;
  List<Service>? companyServices;
  String ?postalCode;
  String ?address;
  String ?companyLogo;
  String ?bannerImage;
  String ?aboutCompany;
  String ?email;
  String ?firstName;
  String ? lastName;


  factory CompanyDetail.fromJson(Map<String, dynamic> json) =>
      CompanyDetail(
        userId: json["userId"],
        companyName: json["companyName"],

        countryName: json["countryName"],
        directorName: json["directorName"],
        city: json["city"],
        stateName: json["stateName"],
        mobileNumber: json["mobileNumber"],
        incorporationDate:json['incorporationDate']==null?null :DateTime.parse(json['incorporationDate']),
         companyServices: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
        postalCode: json["postalCode"],
        address: json["address"]==null?'':json["address"],
        companyLogo: json["companyLogo"],
        bannerImage: json["bannerImage"],
        aboutCompany: json["aboutCompany"],
        email: json["email"],
        firstName: json['firstName'],
        middleName: json['middleName'],
        lastName: json['lastName'],
      );

  Map<String, dynamic> toJson() =>
      {
        "userId": userId,
        "companyName": companyName,

        "countryName": countryName,
        "directorName": directorName,
        "city": city,
        "stateName": stateName,
        "mobileNumber": mobileNumber,
        "incorporationDate":
        "${incorporationDate!.year.toString().padLeft(
            4, '0')}-${incorporationDate!.month.toString().padLeft(
            2, '0')}-${incorporationDate!.day.toString().padLeft(2, '0')}",
        "companyServices": List<dynamic>.from(companyServices!.map((x) => x.toJson())),
        "postalCode": postalCode,
        "address": address,
        "companyLogo": companyLogo,
        "bannerImage": bannerImage,
        "aboutCompany": aboutCompany,
        "email": email,
        "firstName":firstName,
        "middleName":middleName,
        "lastName":lastName,
      };
}

class Service {
  Service({
    this.id,
    this.serviceName,
    this.description,
    this.serviceCost,
    this.serviceImage,
    this.isActive,
    this.isDeleted,
    this.currency,
    this.createdById,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String ?id;
  String ?serviceName;
  String ?description;
  String ?serviceCost;
  String ?serviceImage;
  bool ?isActive;
  bool ?isDeleted;
  String ?currency;
  String ?createdById;
  DateTime ?createdAt;
  DateTime ?updatedAt;
  int ?v;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["_id"],
    serviceName: json["serviceName"],
    description: json["description"],
    serviceCost: json["serviceCost"],
    serviceImage: json["serviceImage"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    currency: json["currency"],
    createdById: json["createdById"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "serviceName": serviceName,
    "description": description,
    "serviceCost": serviceCost,
    "serviceImage": serviceImage,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "currency": currency,
    "createdById": createdById,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}
