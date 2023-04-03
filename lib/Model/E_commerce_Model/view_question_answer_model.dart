// To parse this JSON data, do
//
//     final viewQuestionAnswerModel = viewQuestionAnswerModelFromJson(jsonString);

import 'dart:convert';

ViewQuestionAnswerModel viewQuestionAnswerModelFromJson(String str) => ViewQuestionAnswerModel.fromJson(json.decode(str));

String viewQuestionAnswerModelToJson(ViewQuestionAnswerModel data) => json.encode(data.toJson());

class ViewQuestionAnswerModel {
  ViewQuestionAnswerModel({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String ?message;
  Data? data;

  factory ViewQuestionAnswerModel.fromJson(Map<String, dynamic> json) => ViewQuestionAnswerModel(
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
    this.question,
    this.answer,
    this.id,
  });

  String ?question;
  String ?answer;
  String ?id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    question: json["question"],
    answer: json["answer"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answer": answer,
    "_id": id,
  };
}
