class VinModel {
  int? count;
  String? message;
  String? searchCriteria;
  List<Map<String, String>>? results;

  VinModel({
    this.count,
    this.message,
    this.searchCriteria,
    this.results,
  });

  factory VinModel.fromJson(Map<String, dynamic> json) => VinModel(
        count: json["Count"],
        message: json["Message"],
        searchCriteria: json["SearchCriteria"],
        results: List<Map<String, String>>.from(json["Results"].map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v)))),
      );

  Map<String, dynamic> toJson() => {
        "Count": count,
        "Message": message,
        "SearchCriteria": searchCriteria,
        "Results": List<dynamic>.from(results!.map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
      };
}

class Result {
  String? Model;
  String? FuelTypePrimary;
  String? EngineHP;
  String? TrackWidth;
  String? Wheels;
  String? EngineManufacturer;

  Result({
    this.Model,
    this.FuelTypePrimary,
    this.EngineHP,
    this.TrackWidth,
    this.Wheels,
    this.EngineManufacturer,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        Model: json["Model"],
        FuelTypePrimary: json["FuelTypePrimary"],
        EngineHP: json["EngineHP"],
        TrackWidth: json["TrackWidth"],
        Wheels: json["Wheels"],
        EngineManufacturer: json["EngineManufacturer"],
      );

  Map<String, dynamic> toJson() => {
        "Model": Model,
        "FuelTypePrimary": FuelTypePrimary,
        "EngineHP": EngineHP,
        "TrackWidth": TrackWidth,
        "Wheels": Wheels,
        "EngineManufacturer": EngineManufacturer,
      };
}
