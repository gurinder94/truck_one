import 'dart:convert';

NewConversationList newConversationListFromJson(String str) =>
    NewConversationList.fromJson(json.decode(str));

String newConversationListToJson(NewConversationList data) =>
    json.encode(data.toJson());

class NewConversationList {
  NewConversationList({
     this.code,
    this.message,
   this.data,
  });

  int ? code;
  String ?message;
  List<Datum> ?data;

  factory NewConversationList.fromJson(Map<String, dynamic> json) =>
      NewConversationList(
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

class Datum {
  Datum({
    this.id,
    this.driverId,
    this.email,
    this.personName,
    this.driverImage,
    this.isActive,
    this.isAccepted,
    this.companyId,
    this.companyName,
    this.accessLevel,
    this.userId,
  });

  String ?id;
  String ?driverId;
  String ?email;
  String ?personName;
  int ?experience;
  String?driverImage;
  dynamic city;
  bool ?isDeleted;
  bool ?isActive;
  String ?isAccepted;
  String ?companyId;
  String ?companyName;
  String ?accessLevel;
  String ?userId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        driverId: json["driverId"],
        email: json["email"],
        personName: json["personName"],
        driverImage: json["driverImage"],
        isActive: json["isActive"],
        isAccepted: json["isAccepted"],
        companyId: json["companyId"],
        companyName: json["companyName"],
        accessLevel: json["accessLevel"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "driverId": driverId,
        "email": email,
        "personName": personName,
        "driverImage": driverImage,
        "isActive": isActive,
        "isAccepted": isAccepted,
        "companyId": companyId,
        "companyName": companyName,
        "accessLevel": accessLevel,
        "userId": userId,
      };
}
