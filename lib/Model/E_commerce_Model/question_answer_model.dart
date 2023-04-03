// To parse this JSON data, do
//
//     final questionAnswerModel = questionAnswerModelFromJson(jsonString);

import 'dart:convert';

QuestionAnswerModel questionAnswerModelFromJson(String str) => QuestionAnswerModel.fromJson(json.decode(str));

String questionAnswerModelToJson(QuestionAnswerModel data) => json.encode(data.toJson());

class QuestionAnswerModel {
  QuestionAnswerModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String ?message;
  List<Datum>? data;
  int ?totalCount;

  factory QuestionAnswerModel.fromJson(Map<String, dynamic> json) => QuestionAnswerModel(
    code: json["code"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}

class Datum {
  Datum({
    this.id,
    this.question,
    this.answer,
  });

  String ?id;
  String ?question;
  String ?answer;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    question: json["question"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "question": question,
    "answer": answer,
  };
}
