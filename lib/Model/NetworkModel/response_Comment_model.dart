// To parse this JSON data, do
//
//     final responseCommentModel = responseCommentModelFromJson(jsonString);

import 'dart:convert';

ResponseCommentModel responseCommentModelFromJson(String str) => ResponseCommentModel.fromJson(json.decode(str));

String responseCommentModelToJson(ResponseCommentModel data) => json.encode(data.toJson());

class ResponseCommentModel {
  ResponseCommentModel({
    this.code,
    this.message,

  });

  int? code;
  String ?message;

  factory ResponseCommentModel.fromJson(Map<String, dynamic> json) => ResponseCommentModel(
    code: json["code"],
    message: json["message"],

  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,

  };
}

