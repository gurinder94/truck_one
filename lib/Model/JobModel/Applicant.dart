class Applicant {
  int? code;
  String? message;
  List<Datum>? data;
  int? totalCount;

  Applicant({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  factory Applicant.fromJson(Map<String, dynamic> json) =>
      Applicant(
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
  String? id;
  DateTime? createdAt;
  UserData? userData;
  dynamic resume;
  String? description;
  String? companyId;
  List<dynamic>? driverDocument;
  bool? isReaded;
  String? status;

  Datum({
    this.id,
    this.createdAt,
    this.userData,
    this.resume,
    this.description,
    this.companyId,
    this.driverDocument,
    this.isReaded,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        userData: UserData.fromJson(json["userData"]),
        resume: json["resume"],
        description: json["description"],
        companyId: json["companyId"],
        driverDocument:
            List<dynamic>.from(json["driverDocument"].map((x) => x)),
        isReaded: json["isReaded"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "userData": userData!.toJson(),
        "resume": resume,
        "description": description,
        "companyId": companyId,
        "driverDocument": List<dynamic>.from(driverDocument!.map((x) => x)),
        "isReaded": isReaded,
        "status": status,
      };
}

class UserData {
  String? id;
  String? personName;
  String? email;
  String? mobileNumber;

  UserData({
    this.id,
    this.personName,
    this.email,
    this.mobileNumber,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["_id"],
        personName: json["personName"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "personName": personName,
        "email": email,
        "mobileNumber": mobileNumber,
      };
}
