// To parse this JSON data, do
//
//     final chatGroupViewModel = chatGroupViewModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/view_group_screen/view_group_chat_provider/chat_view_group_provider.dart';
import 'package:provider/provider.dart';

import '../../ApiCall/api_Call.dart';
import '../../AppUtils/UserInfo.dart';
import '../../AppUtils/constants.dart';
import '../../Screens/ChatScreen/chat_home_Page.dart';
import '../../Screens/ChatScreen/provider/chat_home_provider.dart';

ChatGroupViewModel chatGroupViewModelFromJson(String str) =>
    ChatGroupViewModel.fromJson(json.decode(str));

String chatGroupViewModelToJson(ChatGroupViewModel data) =>
    json.encode(data.toJson());

class ChatGroupViewModel {
  ChatGroupViewModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  Data? data;

  factory ChatGroupViewModel.fromJson(Map<String, dynamic> json) =>
      ChatGroupViewModel(
        code: json["code"],
        message: json["message"],
        data:json["data"]==null?null: Data.fromJson(json["data"])
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.image,
    this.membersData,
    this.createdBy,
    this.onlyAdminUpdateInfo,
    this.onlyAdminCanMessage,
    this.onlyAdminCanAddOrRemove,

  });

  String? id;
  String? name;
  String? image;
  List<MembersDatum>? membersData;
  CreatedBy? createdBy;
  bool? onlyAdminUpdateInfo;
  bool? onlyAdminCanMessage;
  bool? onlyAdminCanAddOrRemove;


  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        membersData: List<MembersDatum>.from(
            json["membersData"].map((x) => MembersDatum.fromJson(x))),
        createdBy: CreatedBy.fromJson(json["createdBy"]),
        onlyAdminUpdateInfo: json["onlyAdminUpdateInfo"],
        onlyAdminCanMessage: json["onlyAdminCanMessage"],
        onlyAdminCanAddOrRemove: json["onlyAdminCanAddOrRemove"],


      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "membersData": List<dynamic>.from(membersData!.map((x) => x.toJson())),
        "createdBy": createdBy!.toJson(),
        "onlyAdminUpdateInfo": onlyAdminUpdateInfo,
        "onlyAdminCanMessage": onlyAdminCanMessage,
        "onlyAdminCanAddOrRemove": onlyAdminCanAddOrRemove,
      };
}

class CreatedBy {
  CreatedBy({
    this.id,
    this.dateTime,
    this.lastName,
    this.firstName,
  });

  String? id;
  DateTime? dateTime;
  String? lastName;
  String? firstName;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["_id"],
        dateTime: DateTime.parse(json["dateTime"]),
        lastName: json["lastName"],
        firstName: json["firstName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "dateTime": dateTime!.toIso8601String(),
        "lastName": lastName,
        "firstName": firstName,
      };
}

class MembersDatum extends ChangeNotifier {
  MembersDatum({
    this.id,
    this.isAdmin,
    this.userId,
    this.image,
    this.lastName,
    this.firstName,
    this.isMyself,
  });

  String? id;
  bool? isAdmin;
  String? userId;
  String? image;
  String? lastName;
  String? firstName;
  bool? isMyself;

  factory MembersDatum.fromJson(Map<String, dynamic> json) => MembersDatum(
        id: json["_id"],
        isAdmin: json["isAdmin"],
        userId: json["user_id"],
        image: json["image"] == null ? null : json["image"],
        lastName: json["lastName"],
        firstName: json["firstName"],
        isMyself: json["isMyself"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "isAdmin": isAdmin,
        "user_id": userId,
        "image": image == null ? null : image,
        "lastName": lastName,
        "firstName": firstName,
        "isMyself": isMyself,
      };

  hitRemoveMember(MembersDatum data, String conversationId,
      ChatViewGroupProvider proData, int index, bool GroupAdmin, BuildContext context) async {
    var getId = await getUserId();

    notifyListeners();
    Map<String, dynamic> map = {};

    map = {
      "conversation_id": conversationId,
      "loggedInUser": getId,
      "member_id": data.userId.toString(),
      "nowTime": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .format(DateTime.now().toUtc()),
    };

    print(map);
    try {

      ResponseModel responseModel = await hitAdminRemoveMember(map);
      proData.removeList(index);
      proData.TotalMember(1);
if(GroupAdmin==true)
  {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (_) => ChatHomeProvider(), child: ChatHomePage(1))));
  }

      notifyListeners();
      showMessage(responseModel.message.toString());
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message);

      notifyListeners();
    }
  }

  hitMakeAdmin(MembersDatum data, String conversationId,
      ChatViewGroupProvider proData, int index, String actionType) async {
    var getId = await getUserId();

    notifyListeners();
    Map<String, dynamic> map = {};

    map = {
      "action": actionType,
      "conversation_id": conversationId,
      "loggedInUser": getId,
      "member_id": data.userId.toString(),
      "nowTime": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .format(DateTime.now().toUtc()),
    };

    print(map);
    try {
      ResponseModel responseModel = await hitMakeGroupAdmin(map);
      if (proData.memberDatumList[index].isAdmin == true) {
        proData.memberDatumList[index].isAdmin = false;
        notifyListeners();
      } else {
        proData.memberDatumList[index].isAdmin = true;
        notifyListeners();
      }

      notifyListeners();
      showMessage(responseModel.message.toString());
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message);

      notifyListeners();
    }
  }
}
