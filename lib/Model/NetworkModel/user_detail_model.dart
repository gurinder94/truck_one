import 'package:flutter/cupertino.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/Screens/Network/like_listener.dart';

import 'like_post_model.dart';

class UserDetailModel {
  UserDetailModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  UserDetail? data;

  factory UserDetailModel.fromJson(Map<String, dynamic> json) =>
      UserDetailModel(
        code: json["code"],
        message: json["message"],
        data: UserDetail.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data!.toJson(),
      };
}

class UserDetail extends ChangeNotifier {
  UserDetail({
    this.id,
    this.personName,
    this.city,
    this.image,
    this.postData,
    this.inConnection,
    this.mutual,
    this.email,
    this.mobile,
    this.roleTitle,
    this.aboutCompany,
    this.workPlace,
    this.invitationId,
    this.bannerImage,
    this.isActive,
    this.isDeleted,
  });

  // this.connectionData});

  String? id;
  String? personName;
  dynamic city;
  dynamic image;
  int? mutual;
  String? email;
  String? mobile;
  List<PostDatum>? postData;
  String? inConnection;
  String? aboutCompany;
  String? roleTitle;
  String? workPlace;
  String? invitationId;
  bool? isDeleted;
  bool? isActive;

  // List<dynamic> connectionData;
  String? bannerImage;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["_id"] ?? '',
        personName: json["personName"] ?? '',
        city: json["city"] ?? '',
        image: json["image"] ?? '',
        // mutual: json["mutual"]??'',
        postData: List<PostDatum>.from(
            json["postData"].map((x) => PostDatum.fromJson(x))),
        inConnection: json["inConnection"] ?? '',
        mobile: json["mobileNumber"] ?? '',
        aboutCompany: json["aboutCompany"] ?? 'N/A',
        email: json["email"] ?? '',
        roleTitle: json["roleTitle"] ?? '',
        workPlace: json["workPlace"] ?? '',
        invitationId: json["invitationId"],
        // connectionData:
        //     List<dynamic>.from(json["connectionData"].map((x) => x)),
        isDeleted: json["isDeleted"],
        isActive: json["isActive"],
        bannerImage: json["bannerImage"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "personName": personName,
        "city": city,
        "image": image,
        "mutual": mutual,
        "postData": List<dynamic>.from(postData!.map((x) => x.toJson())),
        "inConnection": inConnection,
        "mobile": mobile,
        "email": email,
        "roleTitle": roleTitle,
        "aboutCompany": aboutCompany,
        "workPlace": workPlace,
        "invitationId": invitationId,
        "bannerImage": bannerImage,
        // "connectionData": List<dynamic>.from(connectionData.map((x) => x)),
      };

}

class PostDatum extends ChangeNotifier {

  late  LikeListener listener;

  void setListener(listener) {
    this.listener = listener;
  }


  PostDatum({
    this.id,
    this.type,
    this.caption,
    this.totalLike,
    this.totalDislike,
    this.totalComment,
    this.postedById,
    this.createdAt,
    this.updatedAt,
    this.userData,
    this.shareUserData,
    this.isLiked,
    this.isDislike,
    this.media,
    this.postedAt,
    this.isMyPost,
    this.groupData,
    this.orignalPostData,
  });

  String? id;
  String? type;
  String? caption;
  int? totalLike;
  int? totalDislike;
  int? totalComment;
  String? postedById;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserData? userData;
  ShareUserData? shareUserData;
  bool? isLiked;
  bool? isDislike;
  List<Media>? media;
  String? postedAt;
  bool? isMyPost;
  GroupData? groupData;
  OrignalPostData? orignalPostData;

  factory PostDatum.fromJson(Map<String, dynamic> json) => PostDatum(
        id: json["_id"],
        type: json["type"] ?? '',
        caption: json["caption"],
        totalLike: json["totalLike"],
        totalDislike: json["totalDislike"],
        totalComment: json["totalCommentWithReComment"],
        postedById: json["postedById"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userData: UserData.fromJson(json["userData"]),
        shareUserData:json["shareUserData"]==null?null: ShareUserData.fromJson(json["shareUserData"]),
        isLiked: json["isLiked"],
        groupData: GroupData.fromJson(json["groupData"]),
        isDislike: json["isDislike"],
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
        postedAt: json["postedAt"],
        isMyPost: json["isMyPost"],
        orignalPostData: json["orignalPostData"] == null
            ? null
            : OrignalPostData.fromJson(json["orignalPostData"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "caption": caption,
        "totalLike": totalLike,
        "totalDislike": totalDislike,
        "totalCommentWithReComment": totalComment,
        "postedById": postedById,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "userData": userData!.toJson(),
        "shareUserData": shareUserData!.toJson(),
        "isLiked": isLiked,
        "isDislike": isDislike,
        "media": List<dynamic>.from(media!.map((x) => x.toJson())),
        "postedAt": postedAt,
        "isMyPost": isMyPost,
        "groupData": groupData!.toJson(),
        "orignalPostData":
            orignalPostData == null ? null : orignalPostData!.toJson(),
      };

  Future<void> makePostLike(Map<String, Object> map) async {
    LikePostModel _model;
    notifyListeners();
    print(map);
    try {
      _model = await hitLikeDislike(map);
      setData(_model);
      notifyListeners();
    } on Exception catch (e) {
      //message = e.toString().replaceAll('Exception:', '');
      print(e.toString());
      notifyListeners();
    }
  }

  void setData(LikePostModel model) {
    this.isDislike = model.data!.isDislike;
    this.isLiked = model.data!.isLiked;
    this.totalLike = model.data!.totalLike;
    this.totalDislike = model.data!.totalDislike;
    this.totalComment = model.data!.totalComment;
    notifyListeners();
  }
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
  dynamic image;
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

class Media {
  Media({
    this.name,
    this.id,
    this.type,
  });

  String? name;
  String? id;
  String? type;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        name: json["name"],
        id: json["_id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "_id": id,
        "type": type,
      };
}

class GroupData {
  GroupData({
    this.id,
    this.name,
    this.groupImage,
    this.description,
    this.totalMembers,
  });

  String? id;
  String? name;
  String? groupImage;
  String? description;
  int? totalMembers;

  factory GroupData.fromJson(Map<String, dynamic> json) => GroupData(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        groupImage: json["groupImage"] == null ? null : json["groupImage"],
        description: json["description"] == null ? null : json["description"],
        totalMembers:
            json["totalMembers"] == null ? null : json["totalMembers"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "groupImage": groupImage == null ? null : groupImage,
        "description": description == null ? null : description,
        "totalMembers": totalMembers == null ? null : totalMembers,
      };
}

class OrignalPostData {
  OrignalPostData({
    this.id,
    this.caption,
    this.isDeleted,
    this.media,
    this.userData,
  });

  String? id;
  String? caption;
  bool? isDeleted;
  List<Media>? media;
  UserData? userData;

  factory OrignalPostData.fromJson(Map<String, dynamic> json) =>
      OrignalPostData(
        id: json["_id"],
        caption: json["caption"],
        isDeleted: json["isDeleted"],
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
        userData: UserData.fromJson(json["userData"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "caption": caption,
        "isDeleted": isDeleted,
        "media": List<dynamic>.from(media!.map((x) => x.toJson())),
        "userData": userData!.toJson(),
      };
}
