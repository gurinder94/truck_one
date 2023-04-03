// To parse this JSON data, do
//
//     final reCommentsListModel = reCommentsListModelFromJson(jsonString);

import 'dart:convert';

ReCommentsListModel reCommentsListModelFromJson(String str) =>
    ReCommentsListModel.fromJson(json.decode(str));

String reCommentsListModelToJson(ReCommentsListModel data) =>
    json.encode(data.toJson());

class ReCommentsListModel {
  ReCommentsListModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int? code;
  String? message;
  List<RecommentModel>? data;
  int? totalCount;

  factory ReCommentsListModel.fromJson(Map<String, dynamic> json) =>
      ReCommentsListModel(
        code: json["code"],
        message: json["message"],
        data: List<RecommentModel>.from(
            json["data"].map((x) => RecommentModel.fromJson(x))),
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalCount": totalCount,
      };
}

class RecommentModel {
  RecommentModel({
    this.id,
    this.userId,
    this.personName,
    this.image,
    this.comment,
    this.isMyComment,
  });

  String? id;
  String? userId;
  String? personName;
  String? image;
  String? comment;
  bool? isMyComment;

  factory RecommentModel.fromJson(Map<String, dynamic> json) => RecommentModel(
        id: json["_id"],
        userId: json["userId"],
        personName: json["personName"],
        image: json["image"],
        comment: json["comment"],
        isMyComment: json["isMyComment"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "personName": personName,
        "image": image,
        "comment": comment,
        "isMyCommen": isMyComment
      };
}
