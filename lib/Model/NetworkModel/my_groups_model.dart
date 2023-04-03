class MyGroupsModel {
  MyGroupsModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<MyGroup>? data;

  factory MyGroupsModel.fromJson(Map<String, dynamic> json) => MyGroupsModel(
    code: json["code"],
    message: json["message"],
    data: List<MyGroup>.from(json["data"].map((x) => MyGroup.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class MyGroup {
  MyGroup({
    this.datumGroupId,
    this.groupId,
    this.name,
    this.groupImage,
    this.coverImage,
    this.description,
    this.isDeleted,
    this.isActive,
    this.createdById,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.invitationId,
  });

  String? datumGroupId;
  dynamic groupId;
  String? name;
  dynamic groupImage;
  String? coverImage;
  String? description;
  bool? isDeleted;
  bool? isActive;
  String? createdById;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? role;
  String ?invitationId;

  factory MyGroup.fromJson(Map<String, dynamic> json) => MyGroup(
    datumGroupId: json["group_Id"],
    groupId: json["groupId"],
    name: json["name"],
    groupImage: json["groupImage"]??'',
    coverImage: json["coverImage"],
    description: json["description"],
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    createdById: json["createdById"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    role: json["role"],
      invitationId:json["invitationId"],
  );

  Map<String, dynamic> toJson() => {
    "group_Id": datumGroupId,
    "groupId": groupId,
    "name": name,
    "groupImage": groupImage,
    "coverImage": coverImage,
    "description": description,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdById": createdById,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "role": role,
    "invitationId":invitationId,
  };
}
