// To parse this JSON data, do
//
//     final truckListModel = truckListModelFromJson(jsonString);

import 'dart:convert';

TruckListModel truckListModelFromJson(String str) =>
    TruckListModel.fromJson(json.decode(str));

String truckListModelToJson(TruckListModel data) => json.encode(data.toJson());

class TruckListModel {
  TruckListModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int? code;
  String? message;
  List<TruckModel>? data;
  int? totalCount;

  factory TruckListModel.fromJson(Map<String, dynamic> json) => TruckListModel(
        code: json["code"],
        message: json["message"],
        data: List<TruckModel>.from(
            json["data"].map((x) => TruckModel.fromJson(x))),
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalCount": totalCount,
      };
}

class TruckModel {
  TruckModel({
    this.userData,
    this.id,
    this.name,
    this.brand,
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
    this.trailerType,
  });

  UserData? userData;
  String? id;
  var name;
  String? brand;
  String? number;
  String? image;
  String? modelNumber;
  int? weight;
  double? height;
  double? width;
  String? fuelType;
  String? engine;
  int? fuelCapacity;
  int? numOfTyres;
  int? wheelbase;
  int ? power;
  bool? isActive;
  bool? isDeleted;
  String? createdById;
  int? loadCapacity;
  String? vechicleType;
  dynamic trailerType;
  bool truckValue=false;

  factory TruckModel.fromJson(Map<String, dynamic> json) => TruckModel(
        userData: UserData.fromJson(json["userData"]),
        id: json["_id"],
        name: json["name"],
        brand: json["brand"] == null ? null : json["brand"],
        number: json["number"],
        image: json["image"],
        modelNumber: json["modelNumber"],
        weight: json["weight"],
        height: json["height"].toDouble(),
        width: json["width"].toDouble(),
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
        vechicleType: json["vechicleType"],
        trailerType: json["trailerType"],
      );

  Map<String, dynamic> toJson() => {
        "userData": userData!.toJson(),
        "_id": id,
        "name": name,
        "brand": brand == null ? null : brand,
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
        "createdById": createdById,
        "loadCapacity": loadCapacity,
        "vechicleType": vechicleType,
        "trailerType": trailerType,
      };
}

class UserData {
  UserData({
    this.id,
    this.personName,
  });

  String? id;
  String? personName;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["_id"],
        personName: json["personName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "personName": personName,
      };
}
