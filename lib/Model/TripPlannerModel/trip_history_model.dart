// To parse this JSON data, do
//
//     final tripHistoryModel = tripHistoryModelFromJson(jsonString);

import 'dart:convert';

TripHistoryModel tripHistoryModelFromJson(String str) =>
    TripHistoryModel.fromJson(json.decode(str));

String tripHistoryModelToJson(TripHistoryModel data) =>
    json.encode(data.toJson());

class TripHistoryModel {
  TripHistoryModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int? code;
  String? message;
  List<Datum>? data;
  int? totalCount;

  factory TripHistoryModel.fromJson(Map<String, dynamic> json) =>
      TripHistoryModel(
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
  Datum(
      {this.id,
      this.source,
      this.destination,
      this.dateTime,
      this.routeFlag,
      this.trailerData,
      this.truckData});

  String? id;

  Destination? source;
  List<Destination>? destination;
  DateTime? dateTime;
  String? routeFlag;
  Data? truckData;
  Data? trailerData;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        source: Destination.fromJson(json["source"]),
        destination: List<Destination>.from(
            json["destination"].map((x) => Destination.fromJson(x))),
        dateTime: json["date_Time"] == null
            ? null
            : DateTime.parse(json["date_Time"]),
        routeFlag: json["routeFlag"] == null ? null : json["routeFlag"],
        truckData: Data.fromJson(json["truckData"]),
        trailerData: Data.fromJson(json["trailerData"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "source": source!.toJson(),
        "destination": List<dynamic>.from(destination!.map((x) => x.toJson())),
        "date_Time": dateTime == null ? null : dateTime!.toIso8601String(),
        "routeFlag": routeFlag == null ? null : routeFlag,
        "truckData": truckData!.toJson(),
        "trailerData": trailerData!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.name,
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
    this.createdById,
    this.vehicleType,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.brand,
  });

  String? id;
  String? name;
  dynamic brandName;
  String? number;
  dynamic image;
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        name: json["name"],
        brandName: json["brandName"],
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
        "name": name,
        "brandName": brandName,
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
