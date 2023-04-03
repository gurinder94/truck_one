// To parse this JSON data, do
//
//     final chatConversationModelDetail = chatConversationModelDetailFromJson(jsonString);

import 'dart:convert';

import 'package:my_truck_dot_one/Model/ChatModel/MessageModel.dart';

ChatConversationModelDetail chatConversationModelDetailFromJson(String str) => ChatConversationModelDetail.fromJson(json.decode(str));

String chatConversationModelDetailToJson(ChatConversationModelDetail data) => json.encode(data.toJson());

class ChatConversationModelDetail {
  ChatConversationModelDetail({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String ?message;
  Data ? data;

  factory ChatConversationModelDetail.fromJson(Map<String, dynamic> json) => ChatConversationModelDetail(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.senderId,
    this.conversationId,
    this.type,
    this.isBlocked,
    this.isMuted,
    this.lastMessages,
    this.unReadMsg,
    this.name,
    this.image,
    this.userId
  });

  String ?senderId;
  String ?conversationId;
  String ?type;
  bool ?isBlocked;
  bool ?isMuted;
  List<MessageModel> ?lastMessages;
  int ?unReadMsg;
  String? name;
  dynamic image;
  String ?userId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    senderId: json["sender_id"],
    conversationId: json["conversation_id"],
    type: json["type"],
    isBlocked: json["isBlocked"],
    isMuted: json["isMuted"],
    lastMessages:json["lastMessages"]==null?[]: List<MessageModel>.from(json["lastMessages"].map((x) => MessageModel.fromJson(x))),
    unReadMsg: json["unReadMsg"],
    name: json["name"],
    image: json["image"],
      userId:json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "sender_id": senderId,
    "conversation_id": conversationId,
    "type": type,
    "isBlocked": isBlocked,
    "isMuted": isMuted,
    "lastMessages": List<dynamic>.from(lastMessages!.map((x) => x.toJson())),
    "unReadMsg": unReadMsg,
    "name": name,
    "image": image,
    "userId":userId,
  };
}


class UserData {
  UserData({
    this.id,
    this.firstName,
    this.lastName,
    this.image,
  });

  String ?id;
  String ?firstName;
  String ?lastName;
  String ?image;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "image": image,
  };
}
