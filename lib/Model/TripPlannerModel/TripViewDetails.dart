// To parse this JSON data, do
//
//     final tripViewDetails = tripViewDetailsFromJson(jsonString);

import 'dart:convert';

TripViewDetails tripViewDetailsFromJson(String str) =>
    TripViewDetails.fromJson(json.decode(str));

String tripViewDetailsToJson(TripViewDetails data) =>
    json.encode(data.toJson());

class TripViewDetails {
  TripViewDetails({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  Data? data;

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
  Data({
    this.id,
    this.dateTime,
    this.routeFlag,
    this.truckData,
    this.brandData,
    this.driverData,
    this.source,
    this.destination,
    this.stoppage,
    this.personName,
    this.hoursOfServices,
    this.alternateRoots,
    this.anotherDriverData,
    this.trailerData,
    this.driverId,
    this.loadNumber,
    this.endDate,
    this.startDate,
    this.runningStatus,
  });

  String? id;
  DateTime? dateTime;
  String? routeFlag;
  TrailerDataClass? truckData;
  String? brandData;
  DriverData? driverData;
  Destination? source;
  Destination? destination;
  List<dynamic>? stoppage;
  String? personName;
  bool? hoursOfServices;
  AnotherDriver? anotherDriverData;
  int? alternateRoots;
  TrailerDataClass? trailerData;
  String ?driverId;
  String ?loadNumber;
  DateTime ?endDate;
  DateTime ?startDate;
  String ?runningStatus;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        dateTime: DateTime.parse(json["date_Time"]),
        routeFlag: json["routeFlag"],
        truckData: TrailerDataClass.fromJson(json["truckData"]),
        brandData: json["brandData"],
        driverData: json["driverData"]==null?null:DriverData.fromJson(json["driverData"]),
        source: Destination.fromJson(json["source"]),
        destination: Destination.fromJson(json["destination"]),
        stoppage: List<dynamic>.from(json["stoppage"].map((x) => x)),
        personName: json["personName"],
        hoursOfServices: json["hoursOfServices"],
        alternateRoots: json["alternateRoots"],
        anotherDriverData: json["anotherDriverData"] != null
            ? AnotherDriver.fromJson(json["anotherDriverData"])
            : null,
      trailerData:json["trailerData"]!=null? TrailerDataClass.fromJson(json["trailerData"]):null,
      driverId:json["driverId"],
    loadNumber: json["loadNumber"],
    endDate: json["endDate"]==null?null:DateTime.parse(json["endDate"]),
      startDate:json["startDate"]==null?null:DateTime.parse(json["startDate"]),
      runningStatus:json["runningStatus"],

      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "date_Time": dateTime!.toIso8601String(),
        "routeFlag": routeFlag,
        "truckData": truckData!.toJson(),
        "brandData": brandData,
        "driverData": driverData!.toJson(),
        "source": source!.toJson(),
        "destination": destination!.toJson(),
        "stoppage": List<dynamic>.from(stoppage!.map((x) => x)),
        "personName": personName,
        "hoursOfServices": hoursOfServices,
        "alternateRoots": alternateRoots,
        "anotherDriverData": anotherDriverData!.toJson() == null
            ? null
            : anotherDriverData!.toJson(),
        "trailerData": trailerData!.toJson()==null?null:trailerData!.toJson(),
    "driverId":driverId,
    "loadNumber":loadNumber,
    "endDate": dateTime!.toIso8601String(),
    "startDate":dateTime!.toIso8601String(),
    "runningStatus":runningStatus,
      };
}

class Destination {
  Destination({
    this.location,
    this.address,
  });

  Location? location;
  String? address;

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
  Location({
    this.type,
    this.coordinates,
  });

  String? type;
  List<double>? coordinates;

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
  int? weight;
  int? height;
  int? width;
  String? fuelType;
  String? engine;
  int? fuelCapacity;
  int? numOfTyres;
  int? wheelbase;
  int? power;
  bool? isActive;
  bool? isDeleted;
  String? trailerType;
  int? loadCapacity;
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
