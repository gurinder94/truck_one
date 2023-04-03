import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/Screens/Home/Listener/like_dislike_listener.dart';

import 'like_post_model.dart';

class PostListModel {
  PostListModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<PostItem>? data;

  factory PostListModel.fromJson(Map<String, dynamic> json) => PostListModel(
        code: json["code"],
        message: json["message"],
        data:
            List<PostItem>.from(json["data"].map((x) => PostItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PostItem extends ChangeNotifier {
  LikeDislikeListener? listener;

  void setListener(listener) {
    this.listener = listener;
  }

  Future<void> makePostLike(Map<String, dynamic> map) async {
    LikePostModel _model;
    print(map);
    notifyListeners();

    try {
      _model = await hitLikeDislike(map);
      setData(_model);
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

  PostItem(
      {this.id,
      this.caption,
      this.totalLike,
      this.totalDislike,
      this.totalComment,
      this.type,
      this.media,
      this.postedById,
      this.createdAt,
      this.updatedAt,
      this.isLiked,
      this.isDislike,
      this.userData,
      this.orignalPostData,
      this.isMyPost,
      this.postedAt,
      this.groupData,
      this.postId});

  String? id;
  String? caption;
  int? totalLike;
  int? totalDislike;
  int? totalComment;
  String? type;
  List<Media>? media;
  String? postedById;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isLiked;
  bool? isDislike;
  UserData? userData;
  String? postId;

  // ShareUserData? shareUserData;
  bool? isMyPost;
  OrignalPostData? orignalPostData;
  String? postedAt;
  GroupData? groupData;

  factory PostItem.fromJson(Map<String, dynamic> json) => PostItem(
        id: json["_id"],
        caption: json["caption"] ?? '',
        totalLike: json["totalLike"],
        totalDislike: json["totalDislike"],
        totalComment: json["totalCommentWithReComment"]??0,
        type: json["type"],
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
        postedById: json["postedById"],
        createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
        isLiked: json["isLiked"],
        isDislike: json["isDislike"],
        userData: UserData.fromJson(json["userData"]),
        orignalPostData: json["orignalPostData"] == null
            ? null
            : OrignalPostData.fromJson(json["orignalPostData"]),
        isMyPost: json["isMyPost"],
        postedAt: json["postedAt"],
        groupData: GroupData.fromJson(json["groupData"]),
        postId: json['postId'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "caption": caption,
        "totalLike": totalLike,
        "totalDislike": totalDislike,
        "totalCommentWithReComment": totalComment,
        "type": type,
        "media": List<dynamic>.from(media!.map((x) => x.toJson())),
        "postedById": postedById,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "isLiked": isLiked,
        "isDislike": isDislike,
        "userData": userData!.toJson(),
        "orignalPostData": orignalPostData == null ? '' : orignalPostData,
        "isMyPost": isMyPost,
        "postedAt": postedAt,
        "groupData": groupData!.toJson(),
        "postId": postId,
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
        media:List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
        userData: UserData.fromJson(json["userData"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "caption": caption,
        "isDeleted": isDeleted,
        "media": List<dynamic>.from(media!.map((x) => x)),
        "userData": userData!.toJson(),
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
  int  ?totalMembers;

  factory GroupData.fromJson(Map<String, dynamic> json) => GroupData(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        groupImage: json["groupImage"] == null ? null : json["groupImage"],
        description: json["description"] == null ? null : json["description"],
      totalMembers:json["totalMembers"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "groupImage": groupImage == null ? null : groupImage,
        "description": description == null ? null : description,
    "totalMembers":totalMembers,
      };
}

class ShareUserData {
  ShareUserData({
    this.id,
    this.personName,
    this.image,
    this.companyName,
    this.designation,
    this.shareText,
    this.roleTitle,
  });

  String? id;
  String? personName;
  String? image;
  String? companyName;
  String? designation;
  String? shareText;
  String? roleTitle;

  factory ShareUserData.fromJson(Map<String, dynamic> json) => ShareUserData(
        id: json["_id"],
        personName: json["personName"],
        image: json["image"],
        companyName: json["companyName"],
        designation: json["designation"],
        shareText: json["shareText"],
        roleTitle: json["roleTitle"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "personName": personName,
        "image": image,
        "companyName": companyName,
        "designation": designation,
        "shareText": shareText,
        "roleTitle": roleTitle,
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
