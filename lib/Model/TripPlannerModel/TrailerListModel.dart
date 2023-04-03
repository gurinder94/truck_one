// To parse this JSON data, do
//
//     final trailerListModel = trailerListModelFromJson(jsonString);

import 'dart:convert';

TrailerListModel trailerListModelFromJson(String str) => TrailerListModel.fromJson(json.decode(str));

String trailerListModelToJson(TrailerListModel data) => json.encode(data.toJson());

class TrailerListModel {
  TrailerListModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String ?message;
  List<TrailerModel> ?data;
  int ?totalCount;

  factory TrailerListModel.fromJson(Map<String, dynamic> json) => TrailerListModel(
    code: json["code"],
    message: json["message"],
    data: List<TrailerModel>.from(json["data"].map((x) => TrailerModel.fromJson(x))),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}

class TrailerModel {
  TrailerModel({
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
    this.trailerType,
  });

  UserData? userData;
  String ?id;
  String ? name;
  dynamic number;
  String ?image;
  dynamic modelNumber;
  int? weight;
  double? height;
  double ?width;
  dynamic fuelType;
  dynamic engine;
  int ?fuelCapacity;
  int ?numOfTyres;
  int ?wheelbase;
  dynamic power;
  bool? isActive;
  bool ?isDeleted;
  String? createdById;
  int? loadCapacity;
  String ?vechicleType;
  String ?trailerType;

  factory TrailerModel.fromJson(Map<String, dynamic> json) => TrailerModel(
    userData: UserData.fromJson(json["userData"]),
    id: json["_id"],
    name: json["name"],
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

  String ?id;
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
