class GetServiceMarkerModel {
  GetServiceMarkerModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int? code;
  String? message;
  List<Datum>? data;
  int? totalCount;

  factory GetServiceMarkerModel.fromJson(Map<String, dynamic> json) => GetServiceMarkerModel(
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
    this.location,
    this.serviceName,
    this.description,
    this.image,
    this.stoppageType,
    this.rootId,
    this.id,
    this.address,
  });

  Location? location;
  String? serviceName;
  dynamic description;
  String? image;
  String? stoppageType;
  String? rootId;
  String? id;
  String? address;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    location: Location.fromJson(json["location"]),
    serviceName: json["serviceName"],
    description: json["description"],
    image: json["image"],
    stoppageType: json["stoppageType"],
    rootId: json["rootId"],
    id: json["_id"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "location": location!.toJson(),
    "serviceName": serviceName,
    "description": description,
    "image": image,
    "stoppageType": stoppageType,
    "rootId": rootId,
    "_id": id,
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
    coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
  };
}
