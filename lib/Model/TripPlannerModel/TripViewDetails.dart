// To parse this JSON data, do
//
//     final tripViewDetails = tripViewDetailsFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

TripViewDetails tripViewDetailsFromJson(String str) =>
    TripViewDetails.fromJson(json.decode(str));

String tripViewDetailsToJson(TripViewDetails data) =>
    json.encode(data.toJson());

class TripViewDetails {
  int? code;
  String? message;
  Data? data;

  TripViewDetails({
    this.code,
    this.message,
    this.data,
  });

  factory TripViewDetails.fromJson(Map<String, dynamic> json) =>
      TripViewDetails(
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
  String? id;
  DateTime? dateTime;
  String? routeFlag;
  TruckData? truckData;
  DriverData? driverData;
  Destination? source;
  List<Destination>? destination;
  TrailerDataClass? trailerData;
  AnotherDriver? anotherDriverData;
  List<dynamic>? stoppage;
  String? personName;
  bool? hoursOfServices;
  var alternateRoots;
  String? loadType;
  var grossWeight;
  String? runningStatus;
  dynamic cancelReason;
  String? loadNumber;
  DateTime? startDate;
  DateTime? endDate;

  Data({
    this.id,
    this.dateTime,
    this.routeFlag,
    this.truckData,
    this.driverData,
    this.source,
    this.destination,
    this.trailerData,
    this.anotherDriverData,
    this.stoppage,
    this.personName,
    this.hoursOfServices,
    this.alternateRoots,
    this.loadType,
    this.grossWeight,
    this.runningStatus,
    this.cancelReason,
    this.loadNumber,
    this.startDate,
    this.endDate,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        dateTime: DateTime.parse(json["date_Time"]),
        routeFlag: json["routeFlag"],
        truckData: TruckData.fromJson(json["truckData"]),
        driverData: DriverData.fromJson(json["driverData"]),
        source: Destination.fromJson(json["source"]),
        destination: List<Destination>.from(json["destination"].map((x) => Destination.fromJson(x))),
        trailerData: json["trailerData"] == null
            ? null
            : TrailerDataClass.fromJson(json["trailerData"]),
        anotherDriverData: json["anotherDriverData"] == null
            ? null
            : AnotherDriver.fromJson(json["anotherDriverData"]),
        stoppage: List<dynamic>.from(json["stoppage"].map((x) => x)),
        personName: json["personName"],
        hoursOfServices: json["hoursOfServices"],
        alternateRoots: json["alternateRoots"],
        loadType: json["loadType"],
        grossWeight: json["grossWeight"],
        runningStatus: json["runningStatus"],
        cancelReason: json["cancelReason"],
        loadNumber: json["loadNumber"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "date_Time": dateTime!.toIso8601String(),
        "routeFlag": routeFlag,
        "truckData": truckData!.toJson(),
        "driverData": driverData!.toJson(),
        "source": source!.toJson(),
        "destination": List<dynamic>.from(destination!.map((x) => x)),
        "anotherDriverData": anotherDriverData!.toJson(),
        "trailerData": trailerData!.toJson(),
        "stoppage": List<dynamic>.from(stoppage!.map((x) => x)),
        "personName": personName,
        "hoursOfServices": hoursOfServices,
        "alternateRoots": alternateRoots,
        "loadType": loadType,
        "grossWeight": grossWeight,
        "runningStatus": runningStatus,
        "cancelReason": cancelReason,
        "loadNumber": loadNumber,
        "startDate": startDate!.toIso8601String(),
        "endDate": endDate!.toIso8601String(),
      };
}

class Destination {
  Location? location;
  String? address;

  Destination({
    this.location,
    this.address,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        location: Location.fromJson(json["location"]),
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "location": location!.toJson(),
        "address": address,
      };
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
      };
}

class DriverData {
  String? id;
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? personName;
  String? mobileNumber;
  bool? isDeleted;
  bool? isActive;
  bool? policyStatus;
  String? isAccepted;
  dynamic invitedBy;
  dynamic address;
  dynamic city;
  dynamic postalCode;
  dynamic image;
  String? deviceType;
  String? resetkey;
  dynamic paymentToken;
  String? accessLevel;
  String? otp;
  dynamic otpGenerationDate;
  var progressBar;
  bool? profileComplete;
  bool? isLeft;
  bool? isApproved;
  DateTime? dateOfJoining;
  List<dynamic>? planData;
  List<dynamic>? planName;
  dynamic customerId;
  dynamic defaultLanguage;
  String? roleId;
  String? createdById;
  String? companyId;
  List<MultiRole>? multiRole;
  DateTime? createdAt;
  DateTime? updatedAt;
  var v;
  String? token;
  String? gender;
  dynamic deviceToken;

  DriverData({
    this.id,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.personName,
    this.mobileNumber,
    this.isDeleted,
    this.isActive,
    this.policyStatus,
    this.isAccepted,
    this.invitedBy,
    this.address,
    this.city,
    this.postalCode,
    this.image,
    this.deviceType,
    this.resetkey,
    this.paymentToken,
    this.accessLevel,
    this.otp,
    this.otpGenerationDate,
    this.progressBar,
    this.profileComplete,
    this.isLeft,
    this.isApproved,
    this.dateOfJoining,
    this.planData,
    this.planName,
    this.customerId,
    this.defaultLanguage,
    this.roleId,
    this.createdById,
    this.companyId,
    this.multiRole,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.token,
    this.gender,
    this.deviceToken,
  });

  factory DriverData.fromJson(Map<String, dynamic> json) => DriverData(
        id: json["_id"],
        email: json["email"],
        password: json["password"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        personName: json["personName"],
        mobileNumber: json["mobileNumber"],
        isDeleted: json["isDeleted"],
        isActive: json["isActive"],
        policyStatus: json["policyStatus"],
        isAccepted: json["isAccepted"],
        invitedBy: json["invitedBy"],
        address: json["address"],
        city: json["city"],
        postalCode: json["postalCode"],
        image: json["image"],
        deviceType: json["deviceType"],
        resetkey: json["resetkey"],
        paymentToken: json["paymentToken"],
        accessLevel: json["accessLevel"],
        otp: json["otp"],
        otpGenerationDate: json["otpGenerationDate"],
        progressBar: json["progressBar"],
        profileComplete: json["profileComplete"],
        isLeft: json["isLeft"],
        isApproved: json["isApproved"],
        dateOfJoining: DateTime.parse(json["dateOfJoining"]),
        planData: List<dynamic>.from(json["planData"].map((x) => x)),
        planName: List<dynamic>.from(json["planName"].map((x) => x)),
        customerId: json["customerId"],
        defaultLanguage: json["defaultLanguage"],
        roleId: json["roleId"],
        createdById: json["createdById"],
        companyId: json["companyId"],
        multiRole: List<MultiRole>.from(
            json["multiRole"].map((x) => MultiRole.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        token: json["token"],
        gender: json["gender"],
        deviceToken: json["deviceToken"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "personName": personName,
        "mobileNumber": mobileNumber,
        "isDeleted": isDeleted,
        "isActive": isActive,
        "policyStatus": policyStatus,
        "isAccepted": isAccepted,
        "invitedBy": invitedBy,
        "address": address,
        "city": city,
        "postalCode": postalCode,
        "image": image,
        "deviceType": deviceType,
        "resetkey": resetkey,
        "paymentToken": paymentToken,
        "accessLevel": accessLevel,
        "otp": otp,
        "otpGenerationDate": otpGenerationDate,
        "progressBar": progressBar,
        "profileComplete": profileComplete,
        "isLeft": isLeft,
        "isApproved": isApproved,
        "dateOfJoining": dateOfJoining!.toIso8601String(),
        "planData": List<dynamic>.from(planData!.map((x) => x)),
        "planName": List<dynamic>.from(planName!.map((x) => x)),
        "customerId": customerId,
        "defaultLanguage": defaultLanguage,
        "roleId": roleId,
        "createdById": createdById,
        "companyId": companyId,
        "multiRole": List<dynamic>.from(multiRole!.map((x) => x.toJson())),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "token": token,
        "gender": gender,
        "deviceToken": deviceToken,
      };
}

class MultiRole {
  String? id;
  String? roleId;

  MultiRole({
    this.id,
    this.roleId,
  });

  factory MultiRole.fromJson(Map<String, dynamic> json) => MultiRole(
        id: json["_id"],
        roleId: json["roleId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "roleId": roleId,
      };
}

class TruckData {
  String? id;
  String? name;
  String? otherbrand;
  dynamic brandName;
  String? number;
  dynamic image;
  String? modelNumber;
  var weight;
  var height;
  var width;
  String? fuelType;
  String? engine;
  var fuelCapacity;
  var numOfTyres;
  var wheelbase;
  var power;
  bool? isActive;
  bool? isDeleted;
  dynamic trailerType;
  var loadCapacity;
  dynamic brand;
  String? vehicleType;
  String? createdById;
  String? companyId;
  DateTime? createdAt;
  DateTime? updatedAt;
  var v;

  TruckData({
    this.id,
    this.name,
    this.otherbrand,
    this.brandName,
    this.number,
    this.image,
    this.modelNumber,
    this.weight,
    this.height,
    this.width,
    this.fuelType,
    this.engine,
    this.fuelCapacity,
    this.numOfTyres,
    this.wheelbase,
    this.power,
    this.isActive,
    this.isDeleted,
    this.trailerType,
    this.loadCapacity,
    this.brand,
    this.vehicleType,
    this.createdById,
    this.companyId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory TruckData.fromJson(Map<String, dynamic> json) => TruckData(
        id: json["_id"],
        name: json["name"],
        otherbrand: json["otherbrand"],
        brandName: json["brandName"],
        number: json["number"],
        image: json["image"],
        modelNumber: json["modelNumber"],
        weight: json["weight"],
        height: json["height"],
        width: json["width"],
        fuelType: json["fuelType"],
        engine: json["engine"],
        fuelCapacity: json["fuelCapacity"],
        numOfTyres: json["numOfTyres"],
        wheelbase: json["wheelbase"],
        power: json["power"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        trailerType: json["trailerType"],
        loadCapacity: json["loadCapacity"],
        brand: json["brand"],
        vehicleType: json["vehicleType"],
        createdById: json["createdById"],
        companyId: json["companyId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "otherbrand": otherbrand,
        "brandName": brandName,
        "number": number,
        "image": image,
        "modelNumber": modelNumber,
        "weight": weight,
        "height": height,
        "width": width,
        "fuelType": fuelType,
        "engine": engine,
        "fuelCapacity": fuelCapacity,
        "numOfTyres": numOfTyres,
        "wheelbase": wheelbase,
        "power": power,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "trailerType": trailerType,
        "loadCapacity": loadCapacity,
        "brand": brand,
        "vehicleType": vehicleType,
        "createdById": createdById,
        "companyId": companyId,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}

class AnotherDriver {
  AnotherDriver({
    this.id,
    this.email,
    this.password,
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
    this.accessLevel,
    this.roleId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.otp,
    this.resetkey,
    this.token,
  });

  String? id;
  String? email;
  String? password;
  dynamic firstName;
  dynamic lastName;
  String? personName;
  String? mobileNumber;
  bool? isDeleted;
  bool? isActive;
  String? isAccepted;
  dynamic address;
  dynamic city;
  dynamic postalCode;
  dynamic image;
  String? deviceType;
  String? accessLevel;
  String? roleId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? otp;
  dynamic resetkey;
  String? token;

  factory AnotherDriver.fromJson(Map<String, dynamic> json) => AnotherDriver(
        id: json["_id"],
        email: json["email"],
        password: json["password"],
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
        accessLevel: json["accessLevel"],
        roleId: json["roleId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        otp: json["otp"],
        resetkey: json["resetkey"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "password": password,
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
        "accessLevel": accessLevel,
        "roleId": roleId,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "otp": otp,
        "resetkey": resetkey,
        "token": token,
      };
}

class TrailerDataClass {
  var otherbrand;

  TrailerDataClass({
    this.id,
    this.name,
    this.number,
    this.image,
    this.modelNumber,
    this.weight,
    this.height,
    this.width,
    this.fuelType,
    this.engine,
    this.fuelCapacity,
    this.otherbrand,
    this.numOfTyres,
    this.wheelbase,
    this.power,
    this.isActive,
    this.isDeleted,
    this.trailerType,
    this.loadCapacity,
    this.createdById,
    this.vehicleType,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.brand,
  });

  String? id;
  String? name;
  String? number;
  String? image;
  String? modelNumber;
  var weight;
  var height;
  var width;
  String? fuelType;
  String? engine;
  var fuelCapacity;
  var numOfTyres;
  var wheelbase;
  var power;
  bool? isActive;
  bool? isDeleted;
  String? trailerType;
  var loadCapacity;
  String? createdById;
  String? vehicleType;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? brand;

  factory TrailerDataClass.fromJson(Map<String, dynamic> json) =>
      TrailerDataClass(
        id: json["_id"],
        name: json["name"] == null ? null : json["name"],
        number: json["number"] == null ? null : json["number"],
        image: json["image"],
        otherbrand: json["otherbrand"],
        modelNumber: json["modelNumber"] == null ? null : json["modelNumber"],
        weight: json["weight"],
        height: json["height"],
        width: json["width"],
        fuelType: json["fuelType"] == null ? null : json["fuelType"],
        engine: json["engine"] == null ? null : json["engine"],
        fuelCapacity: json["fuelCapacity"],
        numOfTyres: json["numOfTyres"],
        wheelbase: json["wheelbase"],
        power: json["power"] == null ? null : json["power"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        trailerType: json["trailerType"] == null ? null : json["trailerType"],
        loadCapacity: json["loadCapacity"],
        createdById: json["createdById"],
        vehicleType: json["vehicleType"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        brand: json["brand"] == null ? null : json["brand"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name == null ? null : name,
        "number": number == null ? null : number,
        "image": image,
        "modelNumber": modelNumber == null ? null : modelNumber,
        "weight": weight,
        "otherbrand": otherbrand,
        "height": height,
        "width": width,
        "fuelType": fuelType == null ? null : fuelType,
        "engine": engine == null ? null : engine,
        "fuelCapacity": fuelCapacity,
        "numOfTyres": numOfTyres,
        "wheelbase": wheelbase,
        "power": power == null ? null : power,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "trailerType": trailerType == null ? null : trailerType,
        "loadCapacity": loadCapacity,
        "createdById": createdById,
        "vehicleType": vehicleType,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "brand": brand == null ? null : brand,
      };
}
