class PostUploadModel {
  PostUploadModel({
    this.code,
    this.message,
  });

  int? code;
  String? message;

  factory PostUploadModel.fromJson(Map<String, dynamic> json) => PostUploadModel(
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
  };
}
