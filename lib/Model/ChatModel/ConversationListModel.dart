import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/Seller_Chat_Screen/seller_chat_provider.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/provider/chat_home_provider.dart';

import '../../AppUtils/UserInfo.dart';

class ConversationListModel {
  int? code;
  String? message;
  List<ConversationModel>? data;
  int? totalCount;

  ConversationListModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  factory ConversationListModel.fromJson(Map<String, dynamic> json) =>
      ConversationListModel(
        code: json["code"],
        message: json["message"],
        data: List<ConversationModel>.from(
            json["data"].map((x) => ConversationModel.fromJson(x))),
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

class ConversationModel extends ChangeNotifier {
  String? conversation_id;
  String? image;
  bool? isBlocked;
  bool? isMuted;

  String? name;
  int? totalMember;
  String? type;
  List<LastMessage>? lastMessages;
  int? unReadMsg;
  String? userId;
  ResponseModel responseModel = new ResponseModel();

  ConversationModel(
      {this.conversation_id,
      this.image,
      this.isBlocked,
      this.isMuted,
      this.lastMessages,
      this.name,
      this.totalMember,
      this.type,
      this.unReadMsg,
      this.userId});

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      ConversationModel(
        conversation_id: json['conversation_id'],
        image: json['image'],
        isBlocked: json['isBlocked'],
        isMuted: json['isMuted'],
        lastMessages: json["lastMessages"] == null
            ? []
            : List<LastMessage>.from(
                json["lastMessages"].map((x) => LastMessage.fromJson(x))),
        name: json["name"],

        totalMember: json["totalMember"],

        type: json["type"],
        unReadMsg: json["unReadMsg"],
        userId: json["userId"],
// currency: json["currency"]);
      );

  Map<String, dynamic> toJson() => {
        // "currency": currency,
        "conversation_id": conversation_id,
        "image": image,
        "isBlocked": isBlocked,
        "isMuted": isMuted,
        "lastMessages":
            List<dynamic>.from(lastMessages!.map((x) => x.toJson())),
        "name": name,
        "totalMember": totalMember,
        "type": type,
        "unReadMsg": unReadMsg,
        "userId": userId
      };

  getDeleteConversation(
      String conversationId, int index, ChatHomeProvider proData) async {
    var uId = await getUserId();

    Map<String, dynamic> map = {
      "conversation_id": conversationId,
      "loggedInUser": uId,
      "nowTime": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .format(DateTime.now().toUtc()),
    };

    try {
      responseModel = await hitDeleteConversations(map);

      proData.removeConverstionList(index);

      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      notifyListeners();
      notifyListeners();
    }
  }

  getDeleteGroup(
      String conversationId, int index, ChatHomeProvider proData) async {
    var uId = await getUserId();

    Map<String, dynamic> map = {
      "conversation_id": conversationId,
      "loggedInUser": uId,
      "member_id": uId,
      "nowTime":
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(DateTime.now()),
    };

    try {
      responseModel = await hitAdminRemoveMember(map);

      proData.removeConverstionList(index);

      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      notifyListeners();
      notifyListeners();
    }
  }

  getBlockUser(String conversationId, String blockType) async {
    var uId = await getUserId();

    Map<String, dynamic> map = {
      "action": blockType,
      "conversation_id": conversationId,
      "loggedInUser": uId,
      "nowTime": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .format(DateTime.now().toUtc()),
    };

    try {
      responseModel = await hitUserBlockApi(map);

      blockType == "BLOCK" ? isBlocked = true : isBlocked = false;
      showMessage(responseModel.message.toString());

      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      notifyListeners();
      notifyListeners();
    }
  }

  sellerDeleteConversation(
    String conversationId,
    int index,
    SellerChatProvider proData,
  ) async {
    var uId = await getUserId();

    Map<String, dynamic> map = {
      "conversation_id": conversationId,
      "loggedInUser": uId,
      "nowTime": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .format(DateTime.now().toUtc()),
    };

    try {
      responseModel = await hitDeleteConversations(map);

      proData.removeConverstionList(index);

      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      notifyListeners();
      notifyListeners();
    }
  }
}

class LastMessage {
  LastMessage({
    this.id,
    this.message,
    this.msgTime,
  });

  String? id;
  String? message;
  DateTime? msgTime;

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        id: json["_id"],
        message: json["message"],
        msgTime: DateTime.parse(json["msgTime"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "message": message,
        "msgTime": msgTime!.toIso8601String(),
      };
}
