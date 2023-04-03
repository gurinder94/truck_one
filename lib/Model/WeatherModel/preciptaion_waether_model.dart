// To parse this JSON data, do
//
//     final precipitationtWeatherModel = precipitationtWeatherModelFromJson(jsonString);

import 'dart:convert';

PrecipitationtWeatherModel precipitationtWeatherModelFromJson(String str) => PrecipitationtWeatherModel.fromJson(json.decode(str));

String precipitationtWeatherModelToJson(PrecipitationtWeatherModel data) => json.encode(data.toJson());

class PrecipitationtWeatherModel {
  PrecipitationtWeatherModel({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String ?message;
  Data ? data;

  factory PrecipitationtWeatherModel.fromJson(Map<String, dynamic> json) => PrecipitationtWeatherModel(
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
    this.type,
    this.features,
  });

  String ? type;
  List<Feature> ? features;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    type: json["type"],
    features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "features": List<dynamic>.from(features!.map((x) => x.toJson())),
  };
}

class Feature {
  Feature({
    this.type,
    this.geometry,
    this.properties,
    this.id,
  });

  String ? type;
  FeatureGeometry ? geometry;
  Properties ? properties;
  String ? id;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    type: json["type"],
    geometry: FeatureGeometry.fromJson(json["geometry"]),
    properties: Properties.fromJson(json["properties"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "geometry": geometry!.toJson(),
    "properties": properties!.toJson(),
    "id": id,
  };
}

class FeatureGeometry {
  FeatureGeometry({
    this.type,
    this.geometries,
    this.coordinates,
  });

  String ?type;
  List<GeometryElement> ?geometries;
  List<List<List<double>>> ?coordinates;

  factory FeatureGeometry.fromJson(Map<String, dynamic> json) => FeatureGeometry(
    type: json["type"],
    geometries: json["geometries"] == null ? [] : List<GeometryElement>.from(json["geometries"].map((x) => GeometryElement.fromJson(x))),
    coordinates: json["coordinates"] == null ? [] : List<List<List<double>>>.from(json["coordinates"].map((x) => List<List<double>>.from(x.map((x) => List<double>.from(x.map((x) => x.toDouble())))))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "geometries": geometries == null ? [] : List<dynamic>.from(geometries!.map((x) => x.toJson())),
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
  };
}

class GeometryElement {
  GeometryElement({
    this.type,
    this.coordinates,
  });

  String ?type;
  List<List<List<double>>>? coordinates;

  factory GeometryElement.fromJson(Map<String, dynamic> json) => GeometryElement(
    type: json["type"],
    coordinates: List<List<List<double>>>.from(json["coordinates"].map((x) => List<List<double>>.from(x.map((x) => List<double>.from(x.map((x) => x.toDouble())))))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": List<dynamic>.from(coordinates!.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
  };
}

class Properties {
  Properties({
    this.name,
    this.styleUrl,
    this.styleHash,
    this.description,
    this.labelOpacity,
    this.labelColor,
    this.labelScale,
    this.strokeOpacity,
    this.stroke,
    this.strokeWidth,
    this.fillOpacity,
    this.fill,
  });

  String ?name;
  String ?styleUrl;
  String ?styleHash;
  String ?description;
  int ?labelOpacity;
  String ?labelColor;
  int ?labelScale;
  double ?strokeOpacity;
  String ?stroke;
  double ?strokeWidth;
  double ?fillOpacity;
  String ?fill;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    name: json["name"],
    styleUrl: json["styleUrl"],
    styleHash: json["styleHash"],
    description: json["description"],
    labelOpacity: json["label-opacity"],
    labelColor: json["label-color"],
    labelScale: json["label-scale"],
    strokeOpacity: json["stroke-opacity"].toDouble(),
    stroke: json["stroke"],
    strokeWidth: json["stroke-width"].toDouble(),
    fillOpacity: json["fill-opacity"].toDouble(),
    fill: json["fill"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "styleUrl": styleUrl,
    "styleHash": styleHash,
    "description": description,
    "label-opacity": labelOpacity,
    "label-color": labelColor,
    "label-scale": labelScale,
    "stroke-opacity": strokeOpacity,
    "stroke": stroke,
    "stroke-width": strokeWidth,
    "fill-opacity": fillOpacity,
    "fill": fill,
  };
}
