class ConstantModell {
  ConstantModell({
    this.code,
    this.message,
    this.data,
    this.startDate,
    this.promocode,
  });

  int? code;
  String? message;
  List<Datum>? data;
  DateTime? startDate;
  List<dynamic>? promocode;

  factory ConstantModell.fromJson(Map<String, dynamic> json) => ConstantModell(
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        startDate: DateTime.parse(json["startDate"]),
        promocode: List<dynamic>.from(json["promocode"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "startDate": startDate!.toIso8601String(),
        "promocode": List<dynamic>.from(promocode!.map((x) => x)),
      };
}

class Datum {
  Datum({
    this.group,
  });

  List<Group>? group;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        group: List<Group>.from(json["group"].map((x) => Group.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "group": List<dynamic>.from(group!.map((x) => x.toJson())),
      };
}

class Group {
  Group({
    this.startDate,
    this.endDate,
    this.data,
    this.paymentMode,
  });

  String? startDate;
  String? endDate;
  Data? data;
  String? paymentMode;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        startDate: json["startDate"],
        endDate: json["endDate"],
        data: Data.fromJson(json["data"]),
        paymentMode: json["paymentMode"],
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate,
        "endDate": endDate,
        "data": data!.toJson(),
        "paymentMode": paymentMode,
      };
}

class Data {
  Data({
    this.id,
    this.planName,
    this.description,
    this.heading,
    this.title,
    this.validity,
    this.planPrice,
    this.finalPrice,
    this.isActive,
    this.discountType,
    this.discountValue,
    this.maxDiscountValue,
    this.createdBy,
    this.createdDate,
    this.features,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.androidPercent,
    this.iphonePercent,
    this.androidPrice,
    this.iphonePrice,
  });

  String? id;
  String? planName;
  String? description;
  String? heading;
  String? title;
  String? validity;
  var planPrice;
  var finalPrice;
  bool? isActive;
  String? discountType;
  int? discountValue;
  dynamic maxDiscountValue;
  String? createdBy;
  DateTime? createdDate;
  List<Feature>? features;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  double? androidPercent;
  int? iphonePercent;
  double? androidPrice;
  int? iphonePrice;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        planName: json["plan_name"],
        description: json["description"],
        heading: json["heading"],
        title: json["title"],
        validity: json["validity"],
        planPrice: json["planPrice"],
        finalPrice: json["finalPrice"],
        isActive: json["isActive"],
        discountType: json["discountType"],
        discountValue: json["discountValue"],
        maxDiscountValue: json["maxDiscountValue"],
        createdBy: json["createdBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        androidPercent: json["android_percent"]?.toDouble(),
        iphonePercent: json["iphone_percent"],
        androidPrice: json["android_price"]?.toDouble(),
        iphonePrice: json["iphone_price"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "plan_name": planName,
        "description": description,
        "heading": heading,
        "title": title,
        "validity": validity,
        "planPrice": planPrice,
        "finalPrice": finalPrice,
        "isActive": isActive,
        "discountType": discountType,
        "discountValue": discountValue,
        "maxDiscountValue": maxDiscountValue,
        "createdBy": createdBy,
        "createdDate": createdDate!.toIso8601String(),
        "features": List<dynamic>.from(features!.map((x) => x.toJson())),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "android_percent": androidPercent,
        "iphone_percent": iphonePercent,
        "android_price": androidPrice,
        "iphone_price": iphonePrice,
      };
}

class Feature {
  Feature({
    this.keyName,
    this.constName,
    this.keyValue,
    this.id,
  });

  String? keyName;
  String? constName;
  int? keyValue;
  String? id;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        keyName: json["keyName"],
        constName: json["constName"],
        keyValue: json["keyValue"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "keyName": keyName,
        "constName": constName,
        "keyValue": keyValue,
        "_id": id,
      };
}
