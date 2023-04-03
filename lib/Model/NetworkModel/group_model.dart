// To parse this JSON data, do
//
//     final groupModel = groupModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';

import '../../Screens/Listener/group_like_listener.dart';
import 'like_post_model.dart';

GroupModel groupModelFromJson(String str) =>
    GroupModel.fromJson(json.decode(str));

String groupModelToJson(GroupModel data) => json.encode(data.toJson());

class GroupModel {
  GroupModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  Data? data;

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
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

class Data extends ChangeNotifier {
  Data({
    this.id,
    this.name,
    this.groupImage,
    this.coverImage,
    this.description,
    this.isAdmin,
    this.postData,
    this.totalMembers,
    this.isMember,
    this.type,
    this.status,
    this.invitationId,
    this.invitedBy,
  });

  String? id;
  String? name;
  String? groupImage;
  String? coverImage;
  String? description;
  bool? isAdmin;
  int? totalMembers;
  List<PostDatum>? postData;
  bool? isMember = false;
  String? invitationId;
  String? type;
  String? status;
  String? invitedBy;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        name: json["name"],
        groupImage: json["groupImage"] ?? '',
        coverImage: json["coverImage"] ?? '',
        totalMembers: json["totalMembers"],
        isAdmin: json["isAdmin"] ?? false,
        description: json["description"],
        isMember: json["isMember"],
        type: json['type'],
        status: json['status'],
        invitationId: json['invitationId'],
        invitedBy: json["invitedBy"],
        postData: List<PostDatum>.from(
            json["postData"].map((x) => PostDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "groupImage": groupImage,
        "coverImage": coverImage,
        "isAdmin": isAdmin,
        "description": description,
        "isMember": isMember,
        "type": type,
        'status': status,
        "invitationId": invitationId,
        "invitedBy": invitedBy,
        "postData": List<dynamic>.from(postData!.map((x) => x.toJson())),
      };

  changeStatus(String value) {
    status = value;
    notifyListeners();
    print(status);
  }
}

class PostDatum extends ChangeNotifier {
  PostDatum(
      {this.id,
      this.caption,
      this.totalLike,
      this.totalDislike,
      this.totalComment,
      this.type,
      this.postedById,
      this.createdAt,
      this.updatedAt,
      this.isLiked,
      this.isDislike,
      this.userData,
      this.postedAt,
      this.media,
      this.isMyPost});

  String? id;
  String? caption;
  int? totalLike;
  int? totalDislike;
  int? totalComment;
  String? type;
  String? postedById;
  List<Media>? media;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isLiked;
  bool? isDislike;
  UserData? userData;
  String? postedAt;
  bool? isMyPost;

  factory PostDatum.fromJson(Map<String, dynamic> json) => PostDatum(
        id: json["_id"],
        caption: json["caption"],
        totalLike: json["totalLike"],
        totalDislike: json["totalDislike"],
        totalComment: json["totalCommentWithReComment"],
        type: json["type"],
        postedById: json["postedById"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        isLiked: json["isLiked"],
        isDislike: json["isDislike"],
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
        userData: UserData.fromJson(json["userData"]),
        postedAt: json["postedAt"],
        isMyPost: json["isMyPost"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "caption": caption,
        "totalLike": totalLike,
        "totalDislike": totalDislike,
        "totalCommentWithReComment": totalComment,
        "type": type,
        "postedById": postedById,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "isLiked": isLiked,
        "isDislike": isDislike,
        "media": List<dynamic>.from(media!.map((x) => x.toJson())),
        "userData": userData!.toJson(),
        "postedAt": postedAt,
        "isMyPost": isMyPost,
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

  GroupLikeDislikeListener? listener;

  void setListener(listener) {
    this.listener = listener;
  }
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
