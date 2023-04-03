import 'dart:convert';

import 'JobModel.dart';

JobListModel jobListFromJson(String str) => JobListModel.fromJson(json.decode(str));

String jobListToJson(JobListModel data) => json.encode(data.toJson());

class JobListModel {
  JobListModel({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String? message;
  List<JobModel>? data;

  factory JobListModel.fromJson(Map<String, dynamic> json) => JobListModel(
    code: json["code"],
    message: json["message"],
    data: List<JobModel>.from(json["data"].map((x) => JobModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}


