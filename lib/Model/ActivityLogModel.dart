// To parse this JSON data, do
//
//     final activityLog = activityLogFromJson(jsonString);

import 'dart:convert';

ActivityLog activityLogFromJson(String str) => ActivityLog.fromJson(json.decode(str));

String activityLogToJson(ActivityLog data) => json.encode(data.toJson());

class ActivityLog {
  ActivityLog({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String? message;
  List<Datum>? data;
  int ?totalCount;

  factory ActivityLog.fromJson(Map<String, dynamic> json) => ActivityLog(
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
    this.list,
    this.count,
  });

  String? id;
  List<ListElement>? list;
  int ?count;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "list": List<dynamic>.from(list!.map((x) => x.toJson())),
    "count": count,
  };
}

class ListElement {
  ListElement({
    this.id,
    this.location,
    this.source,
    this.clientIp,
    this.loginDate,
    this.logoutDate,
    this.lat,
    this.lng,
    this.address,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String ?id;
  Location ?location;
  String ?source;
  String ?clientIp;
  DateTime? loginDate;
  DateTime ?logoutDate;
  int ?lat;
  int ?lng;
  dynamic? address;
  String ?userId;
  DateTime ?createdAt;
  DateTime ?updatedAt;
  int ?v;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["_id"],
    location: Location.fromJson(json["location"]== null ? null :json["location"]),
    source: json["source"],
    clientIp: json["clientIp"],
    loginDate: DateTime.parse(json["loginDate"]),
    logoutDate: json["logoutDate"] == null ? null : DateTime.parse(json["logoutDate"]),

    address: json["address"],
    userId: json["userId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "location": location!.toJson(),
    "source": source,
    "clientIp": clientIp,
    "loginDate": loginDate!.toIso8601String(),
    "logoutDate": logoutDate == null ? null : logoutDate!.toIso8601String(),
    "lat": lat== null ? null : lat,
    "lng": lng== null ? null : lng,
    "address": address,
    "userId": userId,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}

class Location {
  Location({
    this.type,
    this.coordinates,
  });

  String? type;
  List<dynamic>? coordinates;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json["type"],
    coordinates: List<dynamic>.from(json["coordinates"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
  };
}
