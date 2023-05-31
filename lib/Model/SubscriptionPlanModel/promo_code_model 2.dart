// To parse this JSON data, do
//
//     final promoCodeModel = promoCodeModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

import '../../ApiCall/api_Call.dart';
import '../../AppUtils/UserInfo.dart';
import '../../AppUtils/constants.dart';
import '../Apply_PromoCode_model.dart';
import '../NetworkModel/normal_response.dart';

PromoCodeModel promoCodeModelFromJson(String str) =>
    PromoCodeModel.fromJson(json.decode(str));

String promoCodeModelToJson(PromoCodeModel data) => json.encode(data.toJson());

class PromoCodeModel {
  PromoCodeModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<Datum>? data;

  factory PromoCodeModel.fromJson(Map<String, dynamic> json) => PromoCodeModel(
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum extends ChangeNotifier {
  Datum(
      {this.id,
      this.code,
      this.planId,
      this.title,
      this.toDate,
      this.fromDate,
      this.planName,
      this.discountType,
      this.isApplied,
      this.planAmount,
      this.discountupto,
      this.discountValue,
      this.discounttype});

  String? id;
  String? code;
  String? planId;
  String? title;
  DateTime? toDate;
  DateTime? fromDate;
  String? planName;
  String? discountType;
  bool? isApplied;
  var planAmount;
  var discountupto;
  var discounttype;
  var discountValue;

  bool ApplyPromoLoading = false;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        code: json["code"],
        planId: json["planId"],
        title: json["title"],
        toDate: DateTime.parse(json["toDate"]),
        fromDate: DateTime.parse(json["fromDate"]),
        planName: json["plan_name"],
        discountType: json["discountType"],
        isApplied: json["isApplied"],
        planAmount: json["planAmount"],
        discountupto: json["discountupto"],
        discounttype: json["discounttype"],
        discountValue: json["discountValue"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "code": code,
        "planId": planId,
        "title": title,
        "toDate": toDate!.toIso8601String(),
        "fromDate": fromDate!.toIso8601String(),
        "plan_name": planName,
        "discountType": discountType,
        "isApplied": isApplied,
        "planAmount": planAmount,
        "discountupto": discountupto,
        "discounttype": discounttype,
        "discountValue": discountValue,
      };
  ApplyPromoCodeModel ?_applyPromoCodeModel;
  hitApplyPromoCode(String promoCode, Datum datum) async {
    var userId = await getUserId();
    ApplyPromoLoading = true;
    notifyListeners();

    Map<String, dynamic> map = {
      "userId": userId,
      "deviceType": deviceType,
      "promocode": promoCode
    };

    print(map);
    try {
      _applyPromoCodeModel = await hitPromoCodeApply(map);

      datum.isApplied = true;
      ApplyPromoLoading = false;
      print(_applyPromoCodeModel!.planAmount!);
      setplanAmount(_applyPromoCodeModel!.planAmount!);
      Navigator.pop(navigatorKey.currentState!.context, _applyPromoCodeModel,);
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      ApplyPromoLoading = false;

      showMessage(message.toString());
      print(e.toString());
      notifyListeners();
    }
  }

  hitRemovePromo() async {
    var userId = await getUserId();
    ApplyPromoLoading = true;
    notifyListeners();

    Map<String, dynamic> map = {
      "userId": userId,
    };

    print(map);
    try {
      ResponseModel responseModel = await hitRemovePromoCode(map);
      isApplied = false;
      ApplyPromoLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      ApplyPromoLoading = false;
      print(e.toString());
      notifyListeners();
    }
  }
}
