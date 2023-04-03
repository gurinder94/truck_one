import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/JobList/UserComponent/Provider/UserJobProvider.dart';


class JobModel extends ChangeNotifier {
  JobModel({
    this.id,
    this.createdById,
    this.title,
    this.companyName,
    this.companyDetails,
    this.employmentType,
    this.description,
    this.skillData,
    this.industryData,
    this.industry,
    this.functionalArea,
    this.vacancy,
    this.qualification,
    this.walkInDetails,
    this.salaryRang,
    this.address,
    this.role,
    this.createdAt,
    this.minimumExperience,
    this.maximumExperience,
    this.isActive,
    this.isDeleted,
    this.city,
    this.postedAt,
    this.isSaved,
    this.companyLogo,
    this.fullAddress,
    this.companyImg,
  });

  String? id;
  String? createdById;
  String? title;
  String? companyName;
  String? companyDetails;
  String? employmentType;
  String? description;
  List<String>? skillData;
  Industry? industry;
  IndustryData? industryData;
  FunctionalArea? functionalArea;
  int? vacancy;
  List<FunctionalArea>? qualification;
  List<WalkInDetail>? walkInDetails;
  List<SalaryRang>? salaryRang;
  Address? address;
  String? role;
  DateTime? createdAt;
  int? minimumExperience;
  int? maximumExperience;
  bool? isActive;
  bool? isDeleted;
  String? city;
  String? postedAt;
  bool? isSaved;
  String? companyLogo;
  String ?fullAddress;
  String ?companyImg;

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      JobModel(
          id: json["_id"],
          createdById: json["createdById"],
          title: json["title"],
          companyName: json["companyName"],
          employmentType: json["employmentType"],
          description: json["description"],
          // skillData: List<String>.from(json["skillData"].map((x) => x)),
          vacancy: json["vacancy"],
          address: Address.fromJson(json["address"]),
          role: json["role"],
          isActive: json["isActive"],
          isDeleted: json["isDeleted"],
          city: json["city"],
          postedAt: json["postedAt"],
          companyLogo: json["companyLogo"],
          isSaved: json["isSaved"]
      ,fullAddress:json['fullAddress'],
          companyImg:json["companyImg"]);

  Map<String, dynamic> toJson() =>
      {
        "_id": id,
        "createdById": createdById,
        "title": title,
        "companyName": companyName,
        "employmentType": employmentType,
        "vacancy": vacancy,
        "address": address!.toJson(),
        "role": role,
        "createdAt": createdAt!.toIso8601String(),
        "isActive": isActive,
        "isDeleted": isDeleted,
        "city": city,
        "postedAt": postedAt,
        "companyLogo": companyLogo,
        "isSaved": isSaved,
        "fullAddress":fullAddress,
        "companyImg":companyImg
      };

  void addSave(String id, bool value, String userid,
      BuildContext context) async {
    Map<String, dynamic> map = {
      'jobId': id,
      'userId': userid,
      'isActive': true,
    };
    print(map);
    var res = await hitJobSaveApi(map);
    showMessage(res.toString());
    print(res);
    isSaved = value;
    print(isSaved);
    notifyListeners();
  }

  void removeSave(String id, bool value, String userid, BuildContext context,
      int index, UserJobProvider proData) async {
    print(userid);
    {
      var getId = await getUserId();
      Map<String, dynamic> map = {
        'jobId': id,
        'userId': getId,
        'isActive': false,
      };

      var res = await hitJobRemoveApi(map);
      print(res);
      // proData.SaveJoblist.removeAt(index);
      showMessage(res.toString());
      isSaved = value;
      print(isSaved);
      notifyListeners();
    }
  }

  void removeSaveJob(String id, bool value, String userid, BuildContext context,
      int index, UserJobProvider proData) async {
    print(userid);
    {
      var getId = await getUserId();
      Map<String, dynamic> map = {
        'jobId': id,
        'userId': getId,
        'isActive': false,
      };

      var res = await hitJobRemoveApi(map);
      print(res);
      proData.SaveJoblist.removeAt(index);
      proData.refeshList();
      showMessage(res.toString());
      isSaved = value;
      print(isSaved);
      notifyListeners();
    }
  }

}
class Address {
  Address({
    this.coordinates,
    this.fullAddress,
  });

  List<double>? coordinates;
  String? fullAddress;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        fullAddress: json["fullAddress"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
        "fullAddress": fullAddress,
      };
}

class FunctionalArea {
  FunctionalArea({
    this.id,
    this.name,
    this.isActive,
    this.isDeleted,
    this.roles,
    this.createdById,
    this.industryId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.qualification,
  });

  String? id;
  String? name;
  bool? isActive;
  bool? isDeleted;
  List<String>? roles;
  String? createdById;
  String? industryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? qualification;

  factory FunctionalArea.fromJson(Map<String, dynamic> json) => FunctionalArea(
        id: json["_id"],
        name: json["name"] == null ? null : json["name"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        roles: json["roles"] == null
            ? null
            : List<String>.from(json["roles"].map((x) => x)),
        createdById: json["createdById"] == null ? null : json["createdById"],
        industryId: json["industryId"] == null ? null : json["industryId"],
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        qualification:
            json["qualification"] == null ? null : json["qualification"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name == null ? null : name,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "roles":
            roles == null ? null : List<dynamic>.from(roles!.map((x) => x)),
        "createdById": createdById == null ? null : createdById,
        "industryId": industryId == null ? null : industryId,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "qualification": qualification == null ? null : qualification,
      };
}

class SalaryRang {
  SalaryRang({
    this.currency,
    this.min,
    this.max,
    this.visilble,
    this.id,
  });

  String? currency;
  int? min;
  int? max;
  bool? visilble;
  String? id;

  factory SalaryRang.fromJson(Map<String, dynamic> json) => SalaryRang(
        currency: json["currency"],
        min: json["min"],
        max: json["max"],
        visilble: json["visilble"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "min": min,
        "max": max,
        "visilble": visilble,
        "_id": id,
      };
}

class WalkInDetail {
  WalkInDetail({
    this.startDate,
    this.endDate,
    this.duration,
    this.timing,
    this.contactPerson,
    this.number,
    this.venue,
    this.url,
    this.id,
  });

  dynamic startDate;
  dynamic endDate;
  dynamic duration;
  dynamic timing;
  String? contactPerson;
  String? number;
  String? venue;
  dynamic? url;
  String? id;

  factory WalkInDetail.fromJson(Map<String, dynamic> json) => WalkInDetail(
        startDate: json["startDate"],
        endDate: json["endDate"],
        duration: json["duration"],
        timing: json["timing"],
        contactPerson: json["contactPerson"],
        number: json["number"],
        venue: json["venue"],
        url: json["url"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate,
        "endDate": endDate,
        "duration": duration,
        "timing": timing,
        "contactPerson": contactPerson,
        "number": number,
        "venue": venue,
        "url": url,
        "_id": id,
      };
}

class Industry {
  Industry({
    this.id,
    this.name,
    this.isActive,
    this.isDeleted,
    this.createdById,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.qualification,
  });

  String? id;
  String? name;
  bool? isActive;
  bool? isDeleted;
  String? createdById;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? qualification;

  factory Industry.fromJson(Map<String, dynamic> json) => Industry(
        id: json["_id"],
        name: json["name"] == null ? null : json["name"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        createdById: json["createdById"] == null ? null : json["createdById"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        qualification:
            json["qualification"] == null ? null : json["qualification"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name == null ? null : name,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "createdById": createdById == null ? null : createdById,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "qualification": qualification == null ? null : qualification,
      };
}

class IndustryData {
  IndustryData({
    this.id,
    this.name,
    this.isActive,
    this.isDeleted,
    this.createdById,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.qualification,
  });

  String? id;
  String? name;
  bool? isActive;
  bool? isDeleted;
  String? createdById;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? qualification;

  factory IndustryData.fromJson(Map<String, dynamic> json) => IndustryData(
        id: json["_id"],
        name: json["name"] == null ? null : json["name"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        createdById: json["createdById"] == null ? null : json["createdById"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        qualification:
            json["qualification"] == null ? null : json["qualification"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name == null ? null : name,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "createdById": createdById == null ? null : createdById,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "qualification": qualification == null ? null : qualification,
      };
}
