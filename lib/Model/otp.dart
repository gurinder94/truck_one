import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  OtpModel({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String ?message;
  Data ?data;

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
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
    this.resetkey,
  });

  String ?resetkey;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    resetkey: json["resetkey"],
  );

  Map<String, dynamic> toJson() => {
    "resetkey": resetkey,
  };
}
