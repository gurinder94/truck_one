// To parse this JSON data, do
//
//     final serviceListModel = serviceListModelFromJson(jsonString);

import 'dart:convert';

ServiceListModel serviceListModelFromJson(String str) => ServiceListModel.fromJson(json.decode(str));

String serviceListModelToJson(ServiceListModel data) => json.encode(data.toJson());

class ServiceListModel {
  ServiceListModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String ?message;
  List<Datum>? data;
  int ?totalCount;

  factory ServiceListModel.fromJson(Map<String, dynamic> json) => ServiceListModel(
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
  Datum({
    this.id,
    this.serviceName,
    this.serviceCost,
    this.location,
    this.description,
    this.userData,
    this.serviceImage,
    this.address,
    this.contactNumber,
    this.currency,
  });

  String ?id;
  String ?serviceName;
  String ?serviceCost;
  Location? location;
  String ?description;
  String ?userData;
  String ?serviceImage;
  String ?address;
  String ?contactNumber;
  String ?currency;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    serviceName: json["serviceName"],
    serviceCost: json["serviceCost"],
    location: Location.fromJson(json["location"]),
    description: json["description"],
    userData: json["userData"],
    serviceImage: json["serviceImage"],
    address: json["address"],
    contactNumber: json["contactNumber"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "serviceName": serviceName,
    "serviceCost": serviceCost,
    "location": location!.toJson(),
    "description": description,
    "userData": userData,
    "serviceImage": serviceImage,
    "address": address,
    "contactNumber": contactNumber,
    "currency": currency,
  };
}

class Location {
  Location({
    this.type,
    this.coordinates,
  });

  String ?type;
  List<double>? coordinates;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json["type"],
    coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
  };
}
