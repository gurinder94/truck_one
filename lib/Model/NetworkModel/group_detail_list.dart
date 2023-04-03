// To parse this JSON data, do
//
//     final groupDetailsList = groupDetailsListFromJson(jsonString);

import 'dart:convert';

GroupDetailsList groupDetailsListFromJson(String str) => GroupDetailsList.fromJson(json.decode(str));

String groupDetailsListToJson(GroupDetailsList data) => json.encode(data.toJson());

class GroupDetailsList {
  GroupDetailsList({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String ?message;
  GroupDetails ?data;

  factory GroupDetailsList.fromJson(Map<String, dynamic> json) => GroupDetailsList(
    code: json["code"],
    message: json["message"],
    data:  GroupDetails.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data!.toJson(),
  };
}

class  GroupDetails {
  GroupDetails({
    this.id,
    this.name,
    this.groupImage,
    this.coverImage,
    this.description,
    this.createdById,
    this.type,
  });

  String? id;
  String ?name;
  String ?groupImage;
  String ?coverImage;
  String ?description;
  String ?createdById;
  String ?type;

  factory  GroupDetails.fromJson(Map<String, dynamic> json) => GroupDetails(
    id: json["_id"],
    name: json["name"],
    groupImage: json["groupImage"],
    coverImage: json["coverImage"],
    description: json["description"],
    createdById: json["createdById"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "groupImage": groupImage,
    "coverImage": coverImage,
    "description": description,
    "createdById": createdById,
    "type":type,
  };
}
