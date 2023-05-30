import 'EventModel 2.dart';

class EventListModel {
  int? code;
  String? message;
  List<EventModel>? data;
  int ?totalCount;


  EventListModel({this.code, this.message,this.data,this.totalCount,});

  factory EventListModel.fromJson(Map<String, dynamic> json) => EventListModel(
    code: json["code"],
    message: json["message"],
    data: List<EventModel>.from(json["data"].map((x) => EventModel.fromJson(x))),
    totalCount: json["totalCount"],
  );

  //Lakshit

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}
