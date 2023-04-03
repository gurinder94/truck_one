// To parse this JSON data, do
//
//     final postalCodeModel = postalCodeModelFromJson(jsonString);

import 'dart:convert';

PostalCodeModel postalCodeModelFromJson(String str) => PostalCodeModel.fromJson(json.decode(str));

String postalCodeModelToJson(PostalCodeModel data) => json.encode(data.toJson());

class PostalCodeModel {
  PostalCodeModel({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String? message;
  Data ?data;

  factory PostalCodeModel.fromJson(Map<String, dynamic> json) => PostalCodeModel(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]==null?null:json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data!.toJson()==null?'':data!.toJson,
  };
}

class Data {
  Data({
    this.zip,
    this.latitude,
    this.longitude,
    this.city,
    this.state,
    this.country,
  });

  String ?zip;
  double ?latitude;
  double ?longitude;
  String ?city;
  String ?state;
  String ?country;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    zip: json["zip"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    city: json["city"],
    state: json["state"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "zip": zip,
    "latitude": latitude,
    "longitude": longitude,
    "city": city,
    "state": state,
    "country": country,
  };
}
