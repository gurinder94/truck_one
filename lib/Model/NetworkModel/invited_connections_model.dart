class InvitedConnectionsModel {
  InvitedConnectionsModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int? code;
  String? message;
  List<InvitedConnection>? data;
  int? totalCount;

  factory InvitedConnectionsModel.fromJson(Map<String, dynamic> json) => InvitedConnectionsModel(
    code: json["code"],
    message: json["message"],
    data: List<InvitedConnection>.from(json["data"].map((x) => InvitedConnection.fromJson(x))),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}

class InvitedConnection {
  InvitedConnection({
    this.id,
    this.status,
    this.personName,
    this.email,
    this.mobileNumber,
    this.createdAt,
    this.userId,
  });

  String? id;

  String? status;
  DateTime? createdAt;
  String? personName;
  String? email;
  String? mobileNumber;
  String ? userId;

  factory InvitedConnection.fromJson(Map<String, dynamic> json) => InvitedConnection(
    id: json["_id"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    personName: json["personName"],
    email: json["email"],
    mobileNumber: json["mobileNumber"],
      userId:json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,

    "status": status,
    "createdAt": createdAt!.toIso8601String(),
    "personName": personName,
    "email": email,
    "mobileNumber": mobileNumber,
    "userId":userId,
  };
}
