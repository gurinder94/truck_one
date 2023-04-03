class ThunderModelList {
  ThunderModelList({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  Data? data;

  factory ThunderModelList.fromJson(Map<String, dynamic> json) => ThunderModelList(
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

  String? type;
  List<Feature>? features;

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
  });

  String? type;
  Geometry? geometry;
  Properties? properties;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    type: json["type"],
    geometry: Geometry.fromJson(json["geometry"]),
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

  String? type;
  List<List<List<double>>>? coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
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
    this.strokeOpacity,
    this.stroke,
    this.strokeWidth,
    this.fillOpacity,
    this.fill,
    this.valid,
    this.expire,
    this.issue,
    this.label,
    this.label2,
  });

  String? name;
  int? strokeOpacity;
  String? stroke;
  int? strokeWidth;
  double? fillOpacity;
  String? fill;
  String? valid;
  String? expire;
  String? issue;
  String? label;
  String? label2;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    name: json["name"],
    strokeOpacity: json["stroke-opacity"],
    stroke: json["stroke"],
    strokeWidth: json["stroke-width"],
    fillOpacity: json["fill-opacity"].toDouble(),
    fill: json["fill"],
    valid: json["VALID"],
    expire: json["EXPIRE"],
    issue: json["ISSUE"],
    label: json["LABEL"],
    label2: json["LABEL2"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "stroke-opacity": strokeOpacity,
    "stroke": stroke,
    "stroke-width": strokeWidth,
    "fill-opacity": fillOpacity,
    "fill": fill,
    "VALID": valid,
    "EXPIRE": expire,
    "ISSUE": issue,
    "LABEL": label,
    "LABEL2": label2,
  };
}
