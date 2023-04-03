class LikePostModel {
  LikePostModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  Data? data;

  factory LikePostModel.fromJson(Map<String, dynamic> json) => LikePostModel(
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
    this.id,
    this.caption,
    this.totalLike,
    this.totalDislike,
    this.totalComment,
    this.type,
    this.postedById,
    this.createdAt,
    this.updatedAt,
    this.userData,
    this.shareUserData,
    this.postedAt,
    this.isLiked,
    this.isDislike,
  });

  String? id;
  String? caption;
  int? totalLike;
  int? totalDislike;
  int? totalComment;
  String? type;
  String? postedById;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserData? userData;
  ShareUserData? shareUserData;
  String? postedAt;
  bool? isLiked;
  bool? isDislike;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    caption: json["caption"],
    totalLike: json["totalLike"],
    totalDislike: json["totalDislike"],
    totalComment: json["totalComment"],
    type: json["type"],
    postedById: json["postedById"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    userData: UserData.fromJson(json["userData"]),
    shareUserData: ShareUserData.fromJson(json["shareUserData"]),
    postedAt: json["postedAt"],
    isLiked: json["isLiked"],
    isDislike: json["isDislike"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "caption": caption,
    "totalLike": totalLike,
    "totalDislike": totalDislike,
    "totalComment": totalComment,
    "type": type,
    "postedById": postedById,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "userData": userData!.toJson(),
    "shareUserData": shareUserData!.toJson(),
    "postedAt": postedAt,
    "isLiked": isLiked,
    "isDislike": isDislike,
  };
}

class ShareUserData {
  ShareUserData({
    this.shareText,
  });

  dynamic shareText;

  factory ShareUserData.fromJson(Map<String, dynamic> json) => ShareUserData(
    shareText: json["shareText"],
  );

  Map<String, dynamic> toJson() => {
    "shareText": shareText,
  };
}

class UserData {
  UserData({
    this.id,
    this.personName,
    this.image,
    this.roleTitle,
  });

  String? id;
  String? personName;
  String? image;
  String? roleTitle;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["_id"],
    personName: json["personName"],
    image: json["image"],
    roleTitle: json["roleTitle"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "personName": personName,
    "image": image,
    "roleTitle": roleTitle,
  };
}
