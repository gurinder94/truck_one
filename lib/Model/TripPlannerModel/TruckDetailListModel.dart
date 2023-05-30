// To parse this JSON data, do
//
//     final truckDetailListModel = truckDetailListModelFromJson(jsonString);

import 'dart:convert';

TruckDetailListModel truckDetailListModelFromJson(String str) =>
    TruckDetailListModel.fromJson(json.decode(str));

String truckDetailListModelToJson(TruckDetailListModel data) =>
    json.encode(data.toJson());

class TruckDetailListModel {
  TruckDetailListModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  TruckDetailModel? data;

  factory TruckDetailListModel.fromJson(Map<String, dynamic> json) =>
      TruckDetailListModel(
        code: json["code"],
        message: json["message"],
        data: TruckDetailModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data!.toJson(),
      };
}

class TruckDetailModel {
  var OtherTyre;

  var otherbrand;

  TruckDetailModel({
    this.brand,
    this.OtherTyre,
    this.userData,
    this.otherbrand,
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
    this.trailerType,
  });

  Brand? brand;
  UserData? userData;
  String? id;
  String? name;
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
  int? power;
  bool? isActive;
  bool? isDeleted;
  String? createdById;
  int? loadCapacity;
  String? vechicleType;
  dynamic trailerType;

  factory TruckDetailModel.fromJson(Map<String, dynamic> json) =>
      TruckDetailModel(
        brand: Brand.fromJson(json["brand"]),
        userData: UserData.fromJson(json["userData"]),
        id: json["_id"],
        name: json["name"],
        OtherTyre: json["OtherTyre"],
        otherbrand: json["otherbrand"],
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
        "brand": brand!.toJson(),
        "userData": userData!.toJson(),
        "_id": id,
        "name": name,
        "OtherTyre": OtherTyre,
        "otherbrand": otherbrand,
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

class Brand {
  Brand({
    this.id,
    this.name,
  });

  String? id;
  String? name;

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
