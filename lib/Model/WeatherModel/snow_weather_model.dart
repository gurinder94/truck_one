// To parse this JSON data, do
//
//     final snowModelList = snowModelListFromJson(jsonString);

import 'dart:convert';

SnowModelList snowModelListFromJson(String str) => SnowModelList.fromJson(json.decode(str));

String snowModelListToJson(SnowModelList data) => json.encode(data.toJson());

class SnowModelList {
  SnowModelList({
    this.code,
    this.message,
    this.data,
  });

  int ? code;
  String? message;
  Data ?data;

  factory SnowModelList.fromJson(Map<String, dynamic> json) => SnowModelList(
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

  String ?type;
  List<Feature> ?features;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    type: json["type"],
    features:json["features"]==null?[ ]: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
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
  });

  String ? type;
  Geometry ?geometry;
  Properties ?properties;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    type: json["type"],
    geometry: Geometry.fromJson(json["geometry"]??''),
    properties: Properties.fromJson(json["properties"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "geometry": geometry!.toJson(),
    "properties": properties!.toJson(),
  };
}

class Geometry {
  Geometry({
    this.type,
    this.coordinates,
  });

  String ? type;
  List<List<List<double>>>? coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    type: json["type"],
    coordinates:List<List<List<double>>>.from(json["coordinates"].map((x) => List<List<double>>.from(x.map((x) => List<double>.from(x.map((x) => x.toDouble())))))),
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
    this.iconScale,
    this.icon,
    this.labelOpacity,
    this.labelColor,
    this.labelScale,
    this.strokeOpacity,
    this.stroke,
    this.strokeWidth,
    this.fillOpacity,
    this.fill,
    this.visibility,
  });

  String ?name;
  String ?styleUrl;
  String ?styleHash;
  double ?iconScale;
  String ?icon;
  int ?labelOpacity;
  String ?labelColor;
  int ? labelScale;
  int ?strokeOpacity;
  String ?stroke;
  int ?strokeWidth;
  double ?fillOpacity;
  String ?fill;
  String ?visibility;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    name: json["name"],
    styleUrl: json["styleUrl"],
    styleHash: json["styleHash"],
    iconScale: json["icon-scale"].toDouble(),
    icon: json["icon"],
    labelOpacity: json["label-opacity"],
    labelColor: json["label-color"],
    labelScale: json["label-scale"],
    strokeOpacity: json["stroke-opacity"],
    stroke: json["stroke"],
    strokeWidth: json["stroke-width"],
    fillOpacity: json["fill-opacity"].toDouble(),
    fill: json["fill"],
    visibility: json["visibility"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "styleUrl": styleUrl,
    "styleHash": styleHash,
    "icon-scale": iconScale,
    "icon": icon,
    "label-opacity": labelOpacity,
    "label-color": labelColor,
    "label-scale": labelScale,
    "stroke-opacity": strokeOpacity,
    "stroke": stroke,
    "stroke-width": strokeWidth,
    "fill-opacity": fillOpacity,
    "fill": fill,
    "visibility": visibility,
  };
}
