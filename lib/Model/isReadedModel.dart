class IsReaded {
  int? code;
  String? message;

  IsReaded({this.code, this.message});

  factory IsReaded.fromJson(Map<String, dynamic> json) =>
      IsReaded(code: json["code"], message: json['message']);
}
