import 'dart:convert';

ResetModel resetModelFromJson(String str) => ResetModel.fromJson(json.decode(str));

String resetModelToJson(ResetModel data) => json.encode(data.toJson());

class ResetModel {
  ResetModel({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String ?message;
  Data ?data;

  factory ResetModel.fromJson(Map<String, dynamic> json) => ResetModel(
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
    this.hash,
    this.userId,
  });

  String ?hash;
  String ?userId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    hash: json["hash"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "hash": hash,
    "userId": userId,
  };
}
