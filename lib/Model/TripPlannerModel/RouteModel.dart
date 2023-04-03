// To parse this JSON data, do
//
//     final routeModel = routeModelFromJson(jsonString);

import 'dart:convert';

RouteModel routeModelFromJson(String str) => RouteModel.fromJson(json.decode(str));

String routeModelToJson(RouteModel data) => json.encode(data.toJson());

class RouteModel {
  RouteModel({
    this.formatVersion,
    this.routes,
  });

  String? formatVersion;
  List<RoutePath>? routes;

  factory RouteModel.fromJson(Map<String, dynamic> json) => RouteModel(
    formatVersion: json["formatVersion"],
    routes: json["routes"]==null?null:List<RoutePath>.from(json["routes"].map((x) => RoutePath.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "formatVersion": formatVersion,
    "routes": List<dynamic>.from(routes!.map((x) => x.toJson())),
  };
}

class RoutePath {
  RoutePath({
    this.summary,
    this.legs,
    this.sections,
    this.guidance,
  });

  Summary? summary;
  List<Leg>? legs;
  List<Section>? sections;
  Guidance? guidance;

  factory RoutePath.fromJson(Map<String, dynamic> json) => RoutePath(
    summary: Summary.fromJson(json["summary"]),
    legs: List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
    sections: List<Section>.from(json["sections"].map((x) => Section.fromJson(x))),
    guidance: Guidance.fromJson(json["guidance"]),
  );

  Map<String, dynamic> toJson() => {
    "summary": summary!.toJson(),
    "legs": List<dynamic>.from(legs!.map((x) => x.toJson())),
    "sections": List<dynamic>.from(sections!.map((x) => x.toJson())),
    "guidance": guidance!.toJson(),
  };
}

class Guidance {
  Guidance({
    this.instructions,
    this.instructionGroups,
  });

  List<Instruction>? instructions;
  List<InstructionGroup>? instructionGroups;

  factory Guidance.fromJson(Map<String, dynamic> json) => Guidance(
    instructions: List<Instruction>.from(json["instructions"].map((x) => Instruction.fromJson(x))),
    instructionGroups: List<InstructionGroup>.from(json["instructionGroups"].map((x) => InstructionGroup.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "instructions": List<dynamic>.from(instructions!.map((x) => x.toJson())),
    "instructionGroups": List<dynamic>.from(instructionGroups!.map((x) => x.toJson())),
  };
}

class InstructionGroup {
  InstructionGroup({
    this.firstInstructionIndex,
    this.lastInstructionIndex,
    this.groupMessage,
    this.groupLengthInMeters,
  });

  int? firstInstructionIndex;
  int? lastInstructionIndex;
  String? groupMessage;
  int? groupLengthInMeters;

  factory InstructionGroup.fromJson(Map<String, dynamic> json) => InstructionGroup(
    firstInstructionIndex: json["firstInstructionIndex"],
    lastInstructionIndex: json["lastInstructionIndex"],
    groupMessage: json["groupMessage"],
    groupLengthInMeters: json["groupLengthInMeters"],
  );

  Map<String, dynamic> toJson() => {
    "firstInstructionIndex": firstInstructionIndex,
    "lastInstructionIndex": lastInstructionIndex,
    "groupMessage": groupMessage,
    "groupLengthInMeters": groupLengthInMeters,
  };
}

class Instruction {
  Instruction({
    this.routeOffsetInMeters,
    this.travelTimeInSeconds,
    this.point,
    this.pointIndex,
    this.instructionType,
    this.street,
    this.countryCode,
    this.stateCode,
    this.possibleCombineWithNext,
    this.drivingSide,
    this.maneuver,
    this.message,
  });

  int? routeOffsetInMeters;
  int? travelTimeInSeconds;
  Point? point;
  int? pointIndex;
  String? instructionType;
  String? street;
  String? countryCode;
  String? stateCode;
  bool? possibleCombineWithNext;
  String? drivingSide;
  String? maneuver;
  String? message;

  factory Instruction.fromJson(Map<String, dynamic> json) => Instruction(
    routeOffsetInMeters: json["routeOffsetInMeters"],
    travelTimeInSeconds: json["travelTimeInSeconds"],
    point: Point.fromJson(json["point"]),
    pointIndex: json["pointIndex"],
    instructionType: json["instructionType"],
    street: json["street"],
    countryCode: json["countryCode"],
    stateCode: json["stateCode"],
    possibleCombineWithNext: json["possibleCombineWithNext"],
    drivingSide: json["drivingSide"],
    maneuver: json["maneuver"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "routeOffsetInMeters": routeOffsetInMeters,
    "travelTimeInSeconds": travelTimeInSeconds,
    "point": point!.toJson(),
    "pointIndex": pointIndex,
    "instructionType": instructionType,
    "street": street,
    "countryCode": countryCode,
    "stateCode": stateCode,
    "possibleCombineWithNext": possibleCombineWithNext,
    "drivingSide": drivingSide,
    "maneuver": maneuver,
    "message": message,
  };
}

class Point {
  Point({
    this.latitude,
    this.longitude,
  });

  double? latitude;
  double? longitude;

  factory Point.fromJson(Map<String, dynamic> json) => Point(
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

class Leg {
  Leg({
    this.summary,
    this.points,
  });

  Summary? summary;
  List<Point>? points;

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
    summary: Summary.fromJson(json["summary"]),
    points: List<Point>.from(json["points"].map((x) => Point.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "summary": summary!.toJson(),
    "points": List<dynamic>.from(points!.map((x) => x.toJson())),
  };
}

class Summary {
  Summary({
    this.lengthInMeters,
    this.travelTimeInSeconds,
    this.trafficDelayInSeconds,
    this.trafficLengthInMeters,
    this.departureTime,
    this.arrivalTime,
  });

  int? lengthInMeters;
  int? travelTimeInSeconds;
  int? trafficDelayInSeconds;
  int? trafficLengthInMeters;
  DateTime? departureTime;
  DateTime? arrivalTime;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    lengthInMeters: json["lengthInMeters"],
    travelTimeInSeconds: json["travelTimeInSeconds"],
    trafficDelayInSeconds: json["trafficDelayInSeconds"],
    trafficLengthInMeters: json["trafficLengthInMeters"],
    departureTime: DateTime.parse(json["departureTime"]),
    arrivalTime: DateTime.parse(json["arrivalTime"]),
  );

  Map<String, dynamic> toJson() => {
    "lengthInMeters": lengthInMeters,
    "travelTimeInSeconds": travelTimeInSeconds,
    "trafficDelayInSeconds": trafficDelayInSeconds,
    "trafficLengthInMeters": trafficLengthInMeters,
    "departureTime": departureTime!.toIso8601String(),
    "arrivalTime": arrivalTime!.toIso8601String(),
  };
}

class Section {
  Section({
    this.startPointIndex,
    this.endPointIndex,
    this.sectionType,
    this.travelMode,
  });

  int? startPointIndex;
  int? endPointIndex;
  String? sectionType;
  String? travelMode;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    startPointIndex: json["startPointIndex"],
    endPointIndex: json["endPointIndex"],
    sectionType: json["sectionType"],
    travelMode: json["travelMode"],
  );

  Map<String, dynamic> toJson() => {
    "startPointIndex": startPointIndex,
    "endPointIndex": endPointIndex,
    "sectionType": sectionType,
    "travelMode": travelMode,
  };
}
