// To parse this JSON data, do
//
//     final messagesListModel = messagesListModelFromJson(jsonString);

import 'dart:convert';

import 'MessageModel.dart';

MessagesListModel messagesListModelFromJson(String str) => MessagesListModel.fromJson(json.decode(str));

String messagesListModelToJson(MessagesListModel data) => json.encode(data.toJson());

class MessagesListModel {
  MessagesListModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String ?message;
  Data ?data;
  int ?totalCount;

  factory MessagesListModel.fromJson(Map<String, dynamic> json) => MessagesListModel(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data!.toJson(),
    "totalCount": totalCount,
  };
}

class Data {
  Data({
    this.isMuted,
    this.isAdmin,
    this.userId,
    this.addedbyId,
    this.conversationId,
    this.messagesData,
    this.onlyAdminCanMessage,
  });

  bool ?isMuted;
  bool ?isAdmin;
  String? userId;
  String? addedbyId;
  String? conversationId;
  MessagesData? messagesData;
  bool ?onlyAdminCanMessage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    isMuted: json["isMuted"],
    isAdmin: json["isAdmin"],
    userId: json["user_id"],
    addedbyId: json["addedby_id"],
    conversationId: json["conversation_id"],
    messagesData: MessagesData.fromJson(json["messagesData"]),
    onlyAdminCanMessage: json["onlyAdminCanMessage"],
  );

  Map<String, dynamic> toJson() => {
    "isMuted": isMuted,
    "isAdmin": isAdmin,
    "user_id": userId,
    "addedby_id": addedbyId,
    "conversation_id": conversationId,
    "messagesData": messagesData!.toJson(),
    "onlyAdminCanMessage": onlyAdminCanMessage,
  };
}

class MessagesData {
  MessagesData({
    this.allMessages,
    this.totalMsg,
  });

  List<MessageModel> ?allMessages;
  int ?totalMsg;

  factory MessagesData.fromJson(Map<String, dynamic> json) => MessagesData(
    allMessages: List<MessageModel>.from(json["allMessages"].map((x) => MessageModel.fromJson(x))),
    totalMsg: json["totalMsg"],
  );

  Map<String, dynamic> toJson() => {
    "allMessages": List<dynamic>.from(allMessages!.map((x) => x.toJson())),
    "totalMsg": totalMsg,
  };
}


