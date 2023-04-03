import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Screens/Network/network_page/network_provider.dart';

import '../../AppUtils/constants.dart';
import 'normal_response.dart';

class RecommendationModel {
  RecommendationModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int? code;
  String? message;
  List<PersonInfo>? data;

  int? totalCount;

  factory RecommendationModel.fromJson(Map<String, dynamic> json) =>
      RecommendationModel(
        code: json["code"],
        message: json["message"],
        data: List<PersonInfo>.from(
            json["data"].map((x) => PersonInfo.fromJson(x))),
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalCount": totalCount,
      };
}

class PersonInfo extends ChangeNotifier {
  PersonInfo({
    this.id,
    this.personName,
    this.invitationId,
    this.image,
    this.city,
    this.aboutCompany,
    this.companyName,
    this. inConnection
  });

  String? id;
  String? personName;
  String? image;
  String? city;
  String? aboutCompany;
  String? companyName;
bool? inConnection;
  String? invitationId;

  factory PersonInfo.fromJson(Map<String, dynamic> json) => PersonInfo(
      id: json["userId"],
      personName: json["personName"],
      image: json["image"],
      city: json["city"] == null ? '' : json["city"],
      aboutCompany: json["aboutCompany"],
      companyName: json["companyName"],
      inConnection: json["inConnection"],
      invitationId: json["_id"]);

  Map<String, dynamic> toJson() => {
        "userId": id,
        "personName": personName,
        "image": image,
        "city": city,
        "aboutCompany": aboutCompany,
        "companyName": companyName,
        "inConnection":inConnection,
        "invitationId": invitationId,
      };
  bool loading = false;

  connectUser(
    Map<String, dynamic> map,
    BuildContext context,
    NetworkProvider provider,
    int index,
  ) async {
    loading = true;
    notifyListeners();

    try {
      var getid = await getUserId();
      ResponseModel model = await hitConnectPeople(map);

      provider.removeConnectionList(
        provider,
        index,
      );
      loading = false;

      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message.toString());
      print(e.toString());
      notifyListeners();
    }
    loading = false;
  }
}
