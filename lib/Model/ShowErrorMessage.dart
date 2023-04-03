class ShowErrorMessage
{
  int? code;
  String? message;


  ShowErrorMessage( {this.code, this.message});

  factory ShowErrorMessage.fromJson(Map<String, dynamic> json) => ShowErrorMessage(
    code: json["code"],
    message: json["message"],

  );

  //Lakshit

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,

  };
}