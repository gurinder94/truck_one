// To parse this JSON data, do
//
//     final tripPlannerList = tripPlannerListFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/Dispatcher_Screen/Provider/Dispatcher_provider.dart';

import '../../ApiCall/api_Call.dart';
import '../../AppUtils/UserInfo.dart';
import '../../AppUtils/constants.dart';
import '../NetworkModel/normal_response.dart';
import '../ProfileModel/company_leave_model.dart';

TripPlannerList tripPlannerListFromJson(String str) => TripPlannerList.fromJson(json.decode(str));

String tripPlannerListToJson(TripPlannerList data) => json.encode(data.toJson());

class TripPlannerList {
  TripPlannerList({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String? message;
  List<TripPlannerModel> ?data;
  int ?totalCount;

  factory TripPlannerList.fromJson(Map<String, dynamic> json) => TripPlannerList(
    code: json["code"],
    message: json["message"],
    data: List<TripPlannerModel>.from(json["data"].map((x) => TripPlannerModel.fromJson(x))),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}

class TripPlannerModel  extends ChangeNotifier{
  TripPlannerModel({
    this.id,
    this.dateTime,
    this.routeFlag,
    this.weight,
    this.height,
    this.width,
    this.fuelType,
    this.loadCapacity,
    this.vehicleType,
    this.alternateRoots,
    this.source,
    this.destination,
    this.hoursOfServices,
    this.runningStatus,
    this.cancelReason,
    this.isDriverLeft,
    this.isAnotherDriverLeft,
    this.loadNumber,
    this.startDate,
    this.endDate,
    this.driverName,
    this.driverId,
    this.isExpired,
  });

  String ?id;
  DateTime? dateTime;
  String ?routeFlag;
  int ?weight;
  int ?height;
  int ?width;
  String? fuelType;
  int ?loadCapacity;
  String ?vehicleType;
  int? alternateRoots;
  Destination ?source;
  Destination? destination;
  bool ?hoursOfServices;
  String ?runningStatus;
  dynamic cancelReason;
  bool ?isDriverLeft;
  bool ?isAnotherDriverLeft;
  String ?loadNumber;
  DateTime? startDate;
  DateTime? endDate;
  String ?driverName;
  String ? driverId;
  bool ?isExpired;

  factory TripPlannerModel.fromJson(Map<String, dynamic> json) => TripPlannerModel(
    id: json["_id"],
    dateTime: DateTime.parse(json["date_Time"]),
    routeFlag: json["routeFlag"],
    weight: json["weight"],
    height: json["height"],
    width: json["width"],
    fuelType: json["fuelType"],
    loadCapacity: json["loadCapacity"],
    vehicleType: json["vehicleType"],
    alternateRoots: json["alternateRoots"],
    source: Destination.fromJson(json["source"]),
    destination: Destination.fromJson(json["destination"]),
    hoursOfServices: json["hoursOfServices"],
    runningStatus: json["runningStatus"],
    cancelReason: json["cancelReason"],
    isDriverLeft: json["isDriverLeft"],
    isAnotherDriverLeft: json["isAnotherDriverLeft"],
    loadNumber: json["loadNumber"],
    startDate:json["startDate"]==null?null: DateTime.parse(json["startDate"]),
    endDate:json["startDate"]==null?null: DateTime.parse(json["endDate"]),
      driverName:json["driverName"],
    driverId:json['driverId'],
      isExpired:json['isExpired'],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "date_Time": dateTime!.toIso8601String(),
    "routeFlag": routeFlag,
    "weight": weight,
    "height": height,
    "width": width,
    "fuelType": fuelType,
    "loadCapacity": loadCapacity,
    "vehicleType": vehicleType,
    "alternateRoots": alternateRoots,
    "source": source!.toJson(),
    "destination": destination!.toJson(),
    "hoursOfServices": hoursOfServices,
    "runningStatus": runningStatus,
    "cancelReason": cancelReason,
    "isDriverLeft": isDriverLeft,
    "isAnotherDriverLeft": isAnotherDriverLeft,
    "loadNumber": loadNumber,
    "startDate": startDate!.toIso8601String(),
    "endDate": endDate!.toIso8601String(),
    "driverName":driverName,
    "driverId":driverId,
    "isExpired":isExpired,
  };
  late ResponseModel responseModel;
  String ?message;
  hitReasonCancel( String driverId, String tripid, String typeReason, DispatcherProvider listProvider, int index,) async {
    var getId = await getUserId();
    var userName= await getNameInfo();
    print(id);
    Map<String, dynamic> map = {
      "cancelledById": getId,
      "reasonType": '',
      "runningStatus": typeReason,
      "_id": tripid,
      "userName":userName,
      "driverId":driverId,
      "userId":getId,

    };
    notifyListeners();
    print(map);
    try {
      responseModel = await hitReasonCancelApi(map);
      runningStatus=typeReason;
     listProvider.removeList(index);
     message = responseModel.message.toString();
     Navigator.pop(navigatorKey.currentState!.context);
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message!,);
      notifyListeners();
    }
  }

hitTripStatusDriver(String driverId, String tripid, String typeReason,)async {
  var getId = await getUserId();
  var userName= await getNameInfo();
  print(id);
  Map<String, dynamic> map = {
    "cancelledById": getId,
    "reasonType": '',
    "runningStatus": typeReason,
    "_id": tripid,
    "userName":userName,
    "driverId":driverId,
    "userId":getId,

  };
  notifyListeners();
  print(map);
  try {
    responseModel = await hitReasonCancelApi(map);
    runningStatus=typeReason;

    message = responseModel.message.toString();
    Navigator.pop(navigatorKey.currentState!.context);
    notifyListeners();
  } on Exception catch (e) {
    message = e.toString().replaceAll('Exception:', '');
    showMessage(message!,);
    notifyListeners();
  }
}
}

class Destination {
  Destination({
    this.location,
    this.address,
  });

  Location ?location;
  String ?address;

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
