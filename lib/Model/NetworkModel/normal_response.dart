class ResponseModel {
  ResponseModel({
    this.code,
    this.message,
  });

  int? code;
  String? message;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
  };
}
