class SingleConversationChatListModel {
  SingleConversationChatListModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  SingleConversationChatModel? data;

  factory SingleConversationChatListModel.fromJson(Map<String, dynamic> json) =>
      SingleConversationChatListModel(
        code: json["code"],
        message: json["message"],
        data: SingleConversationChatModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data!.toJson(),
      };
}

class SingleConversationChatModel {
  String? conversation_id;
  String? image;
  bool? isBlocked;
  bool? isMuted;
  String? name;
  int? totalMember;
  String? type;
  List<LastMessage>? lastMessages;
  int? unReadMsg;
  String? id;
  bool? isActive;

  SingleConversationChatModel(
      {this.conversation_id,
      this.image,
      this.isBlocked,
      this.isMuted,
      this.lastMessages,
      this.name,
      this.totalMember,
      this.type,
      this.unReadMsg,
      this.id,
      this.isActive});

  factory SingleConversationChatModel.fromJson(Map<String, dynamic> json) =>
      SingleConversationChatModel(
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
          id: json["_id"],
          isActive: json["isActive"]
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
        "_id": id,
        "isActive": isActive,
      };
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
