// To parse this JSON data, do
//
//     final fleetManagerDetailModel = fleetManagerDetailModelFromJson(jsonString);

import 'dart:convert';

FleetManagerDetailModel fleetManagerDetailModelFromJson(String str) => FleetManagerDetailModel.fromJson(json.decode(str));

String fleetManagerDetailModelToJson(FleetManagerDetailModel data) => json.encode(data.toJson());

class FleetManagerDetailModel {
  FleetManagerDetailModel({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String ?message;
  Data ?data;

  factory FleetManagerDetailModel.fromJson(Map<String, dynamic> json) => FleetManagerDetailModel(
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
    this.brand,
    this.otherbrand,
    this.brandName,
    this.OtherTyre,
    this.userData,
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
    this.createdById,
    this.loadCapacity,
    this.vechicleType,
    this.length,
    this.trailerVinNumber,
    this.trailerType,
  });

  var otherbrand;
  var OtherTyre;
  var brandName;
  Brand ? brand;
  UserData ?userData;
  String ?id;
  String ?name;
  String ?number;
  dynamic image;
  String ?modelNumber;
  int ?weight;
  int ?height;
  int ?width;
  String? fuelType;
  String ?engine;
  int ?fuelCapacity;
  int ?numOfTyres;
  int ?wheelbase;
  int ?power;
  bool? isActive;
  bool ?isDeleted;
  String ?createdById;
  int? loadCapacity;
  String ?vechicleType;
  var trailerVinNumber;
  var length;
  dynamic trailerType;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    brand: Brand.fromJson(json["brand"]),
    userData: UserData.fromJson(json["userData"]),
    id: json["_id"],
    name: json["name"],
    OtherTyre: json["OtherTyre"],
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
    createdById: json["createdById"],
    loadCapacity: json["loadCapacity"],
    trailerVinNumber: json["trailerVinNumber"],
    length: json["length"],
    vechicleType: json["vechicleType"],
    trailerType: json["trailerType"],
  );

  Map<String, dynamic> toJson() => {
    "brand": brand!.toJson(),
    "userData": userData!.toJson(),
    "_id": id,
    "name": name,
    "number": number,
    "OtherTyre": OtherTyre,
    "image": image,
    "otherbrand": otherbrand,
    "brandName": brandName,
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
    "createdById": createdById,
    "loadCapacity": loadCapacity,
    "length": length,
    "trailerVinNumber": trailerVinNumber,
    "vechicleType": vechicleType,
    "trailerType": trailerType,
  };
}

class Brand {
  Brand({
    this.id,
    this.name,
  });

  String ?id;
  String ?name;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}

class UserData {
  UserData({
    this.id,
    this.personName,
  });

  String? id;
  String ?personName;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["_id"],
    personName: json["personName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "personName": personName,
  };
}
