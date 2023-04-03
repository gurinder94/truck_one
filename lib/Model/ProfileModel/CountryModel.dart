


class CountryModel {
  CountryModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String ?message;
  List<Datum> ?data;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    code: json["code"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.countryName,
    this.stateArr,
  });

  String ?id;
  String ?countryName;
  List<StateArr>? stateArr;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    countryName: json["countryName"],
    stateArr: List<StateArr>.from(json["stateArr"].map((x) => StateArr.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "countryName": countryName,
    "stateArr": List<dynamic>.from(stateArr!.map((x) => x.toJson())),
  };
}

class StateArr {
  StateArr({
    this.stateName,
    this.id,
  });

  String? stateName;
  String ? id;

  factory StateArr.fromJson(Map<String, dynamic> json) => StateArr(
    stateName: json["stateName"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "stateName": stateName,
    "_id":id,
  };
}
