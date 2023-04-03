class MyFriendsModel {
  MyFriendsModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int? code;
  String? message;
  List<MyFriend>? data;
  int? totalCount;

  factory MyFriendsModel.fromJson(Map<String, dynamic> json) => MyFriendsModel(
    code: json["code"],
    message: json["message"],
    data: List<MyFriend>.from(json["data"].map((x) => MyFriend.fromJson(x))),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}

class MyFriend {
  MyFriend({
    this.id,
    this.userId,
    this.personName,
    this.image,
    this.aboutCompany,
    this.roleTitle,
  });

  String? id;
  String? userId;
  String? personName;
  String? image;
  String? aboutCompany;
  String? roleTitle;
  bool   isChecked=false;

  factory MyFriend.fromJson(Map<String, dynamic> json) => MyFriend(
    id: json["_id"],
    userId: json["userId"],
    personName: json["personName"],
    image: json["image"],
    aboutCompany: json["aboutCompany"],
    roleTitle: json["roleTitle"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "personName": personName,
    "image": image,
    "aboutCompany": aboutCompany,
    "roleTitle": roleTitle,
  };
}
