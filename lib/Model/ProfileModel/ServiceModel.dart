class ServiceModel {
  ServiceModel({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String ?message;
  List<Datm> ?data;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
    code: json["code"],
    message: json["message"],
    data: List<Datm>.from(json["data"].map((x) => Datm.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}
class Datm {
  Datm({
    this.id,
    this.serviceCost,
    this.serviceName,
  });

  String ?id;
  String ?serviceName;
  String ?serviceCost;
  bool check=false;


  factory Datm.fromJson(Map<String, dynamic> json) => Datm(
    id: json["_id"],
    serviceName: json["serviceName"],
    serviceCost: json["serviceCost"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "serviceCost":serviceCost,
    "serviceName": serviceName,
  };
}
