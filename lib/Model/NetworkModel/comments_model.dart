import 'package:flutter/cupertino.dart';

class CommentsModel {
  CommentsModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int? code;
  String? message;
  List<CommentItemModel>? data;
  int? totalCount;

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        code: json["code"],
        message: json["message"],
        data: List<CommentItemModel>.from(
            json["data"].map((x) => CommentItemModel.fromJson(x))),
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalCount": totalCount,
      };
}

class CommentItemModel extends ChangeNotifier {
  CommentItemModel({
    this.id,
    this.userId,
    this.personName,
    this.image,
    this.designation,
    this.comment,
    this.role,
    this.totalReComment,
    this.isMyComment,
    this.isEdited,
  });

  String? id;
  String? userId;
  String? personName;
  dynamic image;
  dynamic designation;
  String? comment;
  String? role;
  int? totalReComment;
  bool checkComment = false;
  bool? isMyComment;
  bool ? isEdited;

  factory CommentItemModel.fromJson(Map<String, dynamic> json) =>
      CommentItemModel(
        id: json["_id"],
        userId: json["userId"],
        personName: json["personName"] ?? '',
        image: json["image"],
        designation: json["designation"],
        comment: json["comment"],
        role: json["role"],
        totalReComment: json["totalReComment"],
        isMyComment: json["isMyComment"],
          isEdited:json["isEdited"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "personName": personName,
        "image": image,
        "designation": designation,
        "comment": comment,
        "role": role,
        "totalReComment": totalReComment,
        "isMyComment": isMyComment,
       "isEdited":isEdited,
      };

  commentTotalCount(int totalReComment) {
    this.totalReComment = totalReComment + 1;
    notifyListeners();
  }
  reCommentTotalCount(int totalReComment) {
    if(this.totalReComment!=0)
     {
       this.totalReComment=(this.totalReComment! -1) ;
       notifyListeners();

     }

  }

  hideCommn(bool value) {
    print("hello");
    checkComment = value;
    notifyListeners();
  }
}
