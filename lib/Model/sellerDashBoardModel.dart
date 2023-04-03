// To parse this JSON data, do
//
//     final sellerDashBoardModel = sellerDashBoardModelFromJson(jsonString);

import 'dart:convert';

import 'package:my_truck_dot_one/Screens/SellerScreen/provider/seller_dash_bord_provider.dart';

SellerDashBoardModel sellerDashBoardModelFromJson(String str) =>
    SellerDashBoardModel.fromJson(json.decode(str));

String sellerDashBoardModelToJson(SellerDashBoardModel data) =>
    json.encode(data.toJson());

class SellerDashBoardModel {
  SellerDashBoardModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<Datum>? data;

  factory SellerDashBoardModel.fromJson(Map<String, dynamic> json) =>
      SellerDashBoardModel(
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  void setTotalAnswer(List<Datum>? list) {
    if (  list![0].totalAnsweredQueries!.length==0) {

    }
    else
      {
        list[0].totalAnsweredQueries![0].count =
        (list[0].totalQueries![0].count! -
            list[0].totalAnsweredQueries![0].count!) as int?;
      }
  }
}

class Datum {
  Datum({
    // this.graphData,
    this.totalQueries,
    this.totalAnsweredQueries,
    this.percent,
    this.grapthdata,
  });

  //  List<Grapdatum> ?graphData;
  List<TotalQuery>? totalQueries;
  List<TotalQuery>? totalAnsweredQueries;
  int? percent;
  List<GRAPTHDATA>? grapthdata;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        // graphData: List<Grapdatum>.from(json["graphData"].map((x) => Grapdatum.fromJson(x))),
        totalQueries: json["totalQueries"] == null
            ? []
            : List<TotalQuery>.from(
                json["totalQueries"].map((x) => TotalQuery.fromJson(x))),
        totalAnsweredQueries: json["totalAnsweredQueries"] == null
            ? []
            : List<TotalQuery>.from(json["totalAnsweredQueries"]
                .map((x) => TotalQuery.fromJson(x))),
        percent: json["percent"] == null ? 0 : json["percent"],
        grapthdata: json["GRAPTHDATA"] == 0
            ? []
            : List<GRAPTHDATA>.from(
                json["GRAPTHDATA"].map((x) => GRAPTHDATA.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        // "graphData": List<dynamic>.from(graphData!.map((x) => x.toJson())),
        "totalQueries":
            List<dynamic>.from(totalQueries!.map((x) => x.toJson())),
        "totalAnsweredQueries":
            List<dynamic>.from(totalAnsweredQueries!.map((x) => x.toJson())),
        "percent": percent,
        "GRAPTHDATA": List<dynamic>.from(grapthdata!.map((x) => x.toJson())),
      };
}

// class Grapdatum {
//   Grapdatum({
//     this.id,
//     this.count,
//   });
//
//   String ?id;
//   int ?count;
//
//   factory Grapdatum.fromJson(Map<String, dynamic> json) => Grapdatum(
//     id: json["_id"].toString(),
//     count: json["count"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "count": count,
//   };
// }

class TotalQuery {
  TotalQuery({
    this.id,
    this.count,
  });

  Id? id;
  int? count;

  factory TotalQuery.fromJson(Map<String, dynamic> json) => TotalQuery(
        id: Id.fromJson(json["_id"]),
        count: json["count"] == null ? 0 : json["count"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id!.toJson(),
        "count": count,
      };
}

class Id {
  Id({
    this.id,
  });

  String? id;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
      };
}

class GRAPTHDATA {
  GRAPTHDATA({
    this.id,
    this.count,
  });

  DateTime? id;
  int? count;

  factory GRAPTHDATA.fromJson(Map<String, dynamic> json) => GRAPTHDATA(
        id: DateTime.parse(json["_id"]),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "count": count,
      };
}
