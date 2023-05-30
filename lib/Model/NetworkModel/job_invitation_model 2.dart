// To parse this JSON data, do
//
//     final jobInvitationModel = jobInvitationModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/Screens/LoginScreen/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

JobInvitationModel jobInvitationModelFromJson(String str) => JobInvitationModel.fromJson(json.decode(str));

String jobInvitationModelToJson(JobInvitationModel data) => json.encode(data.toJson());

class JobInvitationModel {
  JobInvitationModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String ?message;
  List<Datum>? data;
  int ?totalCount;

  factory JobInvitationModel.fromJson(Map<String, dynamic> json) => JobInvitationModel(
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

class Datum extends ChangeNotifier {
  Datum({
    this.id,
    this.image,
    this.companyName,
    this.companyId,
    this.accessLevel,
    this.status,
    this.resetkey,
    this.userId,
  });

  String ?id;
  String ?image;
  String ?companyName;
  String ?companyId;
  String ?accessLevel;
  String ?status;
  dynamic resetkey;
  String ? userId;

  factory Datum.fromJson(Map<String, dynamic> json) =>
      Datum(
        id: json["_id"],
        image: json["image"],
        companyName: json["companyName"],
        companyId: json["companyId"],
        accessLevel: json["AccessLevel"],
        status: json["status"],
        resetkey: json["resetkey"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() =>
      {
        "_id": id,
        "image": image,
        "companyName": companyName,
        "companyId": companyId,
        "AccessLevel": accessLevel,
        "status": status,
        "resetkey": resetkey,
        "userId": userId,
      };

  hitAcceptOffer(Map<String, dynamic> map, String status, BuildContext context) async {
    try {
      print(map);
      var res = await hitAcceptJobOfferApi(map);

      this.status = status;
      final pref = await SharedPreferences.getInstance();
      await pref.clear();

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => LoginScreen()),
              (Route<dynamic> route) => false);
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      // showMessage(message, context);

      print(e.toString());
      notifyListeners();
    }
  }

  hitRejectOffer(Map<String, dynamic> map, String status) async {
    try {
      var res = await hitRejectOfferApi(map);

      this.status = status;

      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      // showMessage(message, context);

      print(e.toString());
      notifyListeners();
    }
  }

}