// To parse this JSON data, do
//
//     final viewServiceList = viewServiceListFromJson(jsonString);

import 'dart:convert';

ViewServiceList viewServiceListFromJson(String str) => ViewServiceList.fromJson(json.decode(str));

String viewServiceListToJson(ViewServiceList data) => json.encode(data.toJson());

class ViewServiceList {
  ViewServiceList({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String ?message;
  Data? data;

  factory ViewServiceList.fromJson(Map<String, dynamic> json) => ViewServiceList(
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
  Location ? location;
  String ?description;
  String ?userData;
  String ?serviceImage;
  String ?address;
  String ?contactNumber;
  String ?currency;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
