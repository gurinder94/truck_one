// // // To parse this JSON data, do
// // //
// // //     final cartModel = cartModelFromJson(jsonString);
// //
// // import 'dart:convert';
// //
// // import 'package:flutter/material.dart';
// // import 'package:my_truck_dot_one/Screens/AddCartScreen/provider/add_cart_provider.dart';
// //
// // import '../../ApiCall/api_Call.dart';
// // import '../../AppUtils/UserInfo.dart';
// // import '../NetworkModel/normal_response.dart';
// //
// // CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));
// //
// // String cartModelToJson(CartModel data) => json.encode(data.toJson());
// //
// // class CartModel {
// //   CartModel({
// //     this.code,
// //     this.message,
// //     this.data,
// //     this.grandTotal,
// //     this.finalPrice,
// //     this.planDiscount,
// //     this.discountedAmount,
// //     this.remainingPrice,
// //     this.totalCount,
// //   });
// //
// //   int? code;
// //   String? message;
// //   List<CardModelData>? data;
// //
// //   double? grandTotal;
// //   double? finalPrice;
// //   int? planDiscount;
// //   int? discountedAmount;
// //   double? remainingPrice;
// //   int? totalCount;
// //
// //   factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
// //         code: json["code"],
// //         message: json["message"],
// //         data: json["data"] == null
// //             ? []
// //             : List<CardModelData>.from(
// //                 json["data"].map((x) => CardModelData.fromJson(x))),
// //         grandTotal: json["GrandTotal"] == null
// //             ? 0.toDouble()
// //             : json["GrandTotal"].toDouble(),
// //         finalPrice: json["finalPrice"] == null
// //             ? 0.toDouble()
// //             : json["finalPrice"].toDouble(),
// //         planDiscount: json["planDiscount"],
// //         discountedAmount: json["discountedAmount"],
// //         remainingPrice: json["remainingPrice"] == null
// //             ? 0.toDouble()
// //             : json["remainingPrice"].toDouble(),
// //         totalCount: json["totalCount"],
// //       );
// //
// //   Map<String, dynamic> toJson() => {
// //         "code": code,
// //         "message": message,
// //         "data": List<dynamic>.from(data!.map((x) => x.toJson())),
// //         "GrandTotal": grandTotal,
// //         "finalPrice": finalPrice,
// //         "planDiscount": planDiscount,
// //         "discountedAmount": discountedAmount,
// //         "remainingPrice": remainingPrice,
// //         "totalCount": totalCount,
// //       };
// // }
// //
// // class CardModelData extends ChangeNotifier {
// //   CardModelData({
// //     this.id,
// //     this.planId,
// //     this.planName,
// //     this.title,
// //     this.validity,
// //     this.planPrice,
// //     this.finalPrice,
// //   });
// //
// //   String? id;
// //   String? planId;
// //   String? planName;
// //   String? title;
// //   String? validity;
// //   double? planPrice;
// //   double? finalPrice;
// //   bool isDelete = false;
// //
// //   factory CardModelData.fromJson(Map<String, dynamic> json) => CardModelData(
// //         id: json["_id"],
// //         planId: json["planId"],
// //         planName: json["plan_name"],
// //         title: json["title"],
// //         validity: json["validity"],
// //         planPrice: json["planPrice"].toDouble(),
// //         finalPrice: json["finalPrice"].toDouble(),
// //       );
// //
// //   Map<String, dynamic> toJson() => {
// //         "_id": id,
// //         "planId": planId,
// //         "plan_name": planName,
// //         "title": title,
// //         "validity": validity,
// //         "planPrice": planPrice,
// //         "finalPrice": finalPrice,
// //       };
// //   bool removeLoding = false;
// //
// //   void hitRemoveToCart(String id, int index, AddCartProvider proData) async {
// //     var userId = await getUserId();
// //     removeLoding = true;
// //     notifyListeners();
// //     Map<String, dynamic> map = {"_id": planId};
// //
// //     print(map);
// //     try {
// //        ResponseModel responseModel = await hitRemoveItemCart(map);
// //       proData.setDelete(index);
// //       removeLoding = false;
// //       notifyListeners();
// //     } on Exception catch (e) {
// //       var message = e.toString().replaceAll('Exception:', '');
// //       removeLoding = false;
// //       print(e.toString());
// //       notifyListeners();
// //     }
// //   }
// // }
// // To parse this JSON data, do
// //
// //     final cartModel = cartModelFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
//
// import '../../ApiCall/api_Call.dart';
// import '../../Screens/AddCartScreen/provider/add_cart_provider.dart';
// import '../NetworkModel/normal_response.dart';
//
// CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));
//
// String cartModelToJson(CartModel data) => json.encode(data.toJson());
//
// class CartModel {
//   CartModel({
//     this.code,
//     this.message,
//     this.data,
//     this.promoData,
//     this.grandTotal,
//     this.finalPrice,
//     this.planDiscount,
//     this.discountedAmount,
//     this.remainingPrice,
//     this.totalCount,
//     this.iphonePercent,
//     this.androidPercent,
//   });
//
//   int ?code;
//   String ?message;
//   List<CardModelData>? data;
//   PromoData ?promoData;
//  var  grandTotal;
// var  finalPrice;
//   var  planDiscount;
//   var discountedAmount;
//   var remainingPrice;
//   int ?totalCount;
//   var iphonePercent;
//    var androidPercent;
//
//   factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
//     code: json["code"],
//     message: json["message"],
//     data: List<CardModelData>.from(json["data"].map((x) => CardModelData.fromJson(x))),
//     promoData:json["promoData"]==null?null: PromoData.fromJson(json["promoData"]),
//     grandTotal: json["GrandTotal"]??0.0,
//     finalPrice: json["finalPrice"]??0.0,
//     planDiscount: json["planDiscount"],
//     discountedAmount: json["discountedAmount"],
//     remainingPrice: json["remainingPrice"]??0.0,
//     totalCount: json["totalCount"],
//     iphonePercent: json["iphone_percent"],
//     androidPercent: json["android_percent"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "code": code,
//     "message": message,
//     "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//     "promoData": promoData!.toJson(),
//     "GrandTotal": grandTotal,
//     "finalPrice": finalPrice??0,
//     "planDiscount": planDiscount,
//     "discountedAmount": discountedAmount,
//     "remainingPrice": remainingPrice,
//     "totalCount": totalCount,
//     "iphone_percent": iphonePercent,
//     "android_percent": androidPercent,
//   };
// }
//
// class CardModelData extends ChangeNotifier {
//   CardModelData({
//     this.id,
//     this.planId,
//     this.planName,
//     this.title,
//     this.validity,
//     this.planPrice,
//     this.finalPrice,
//     this.appliedpromoData,
//     this.iphonePercent,
//     this.androidPercent,
//     this.iphone_price,
//     this.android_price,
//   });
//
//   String ?id;
//   String ?planId;
//   String ?planName;
//   String ?title;
//   String ?validity;
//   var planPrice;
//  var  finalPrice;
//   PromoData ?appliedpromoData;
// var  iphonePercent;
// var androidPercent;
// var   iphone_price;
// var  android_price;
//
//   factory CardModelData.fromJson(Map<String, dynamic> json) =>
//       CardModelData(
//         id: json["_id"],
//         planId: json["planId"],
//         planName: json["plan_name"],
//         title: json["title"],
//         validity: json["validity"],
//         planPrice: json["planPrice"],
//         finalPrice: json["finalPrice"],
//         appliedpromoData: json["appliedpromoData"] == null ? null : PromoData
//             .fromJson(json["appliedpromoData"]),
//         iphonePercent: json["iphone_percent"] == 0.0
//             ? 0.0
//             : json["iphone_percent"],
//         androidPercent: json["android_percent"] == 0.0
//             ? 0.0
//             : json["android_percent"],
//           iphone_price:json["iphone_price"]??0.0,
//           android_price:json["android_price"]??0.0
//       );
//
//   Map<String, dynamic> toJson() =>
//       {
//         "_id": id,
//         "planId": planId,
//         "plan_name": planName,
//         "title": title,
//         "validity": validity,
//         "planPrice": planPrice,
//         "finalPrice": finalPrice,
//         "appliedpromoData": appliedpromoData == null ? null : appliedpromoData!
//             .toJson(),
//         "iphone_percent": iphonePercent == null ? null : iphonePercent,
//         "android_percent": androidPercent == null ? null : androidPercent,
//         "iphone_price":iphone_price??0.0,
//         "android_price":android_price??0.0
//
//       };
//
//   bool removeLoding = false;
//
//   void hitRemoveToCart(String id, int index, AddCartProvider proData) async {
//     var userId = await getUserId();
//     removeLoding = true;
//     notifyListeners();
//     Map<String, dynamic> map = {"_id": id};
//
//     print(map);
//     try {
//       ResponseModel responseModel = await hitRemoveItemCart(map);
//
//       hitRemovePromo();
//       proData.setDelete(index);
//       removeLoding = false;
//       notifyListeners();
//     } on Exception catch (e) {
//       var message = e.toString().replaceAll('Exception:', '');
//       removeLoding = false;
//       print(e.toString());
//       notifyListeners();
//     }
//   }
//   hitRemovePromo()
//   async {
//     var userId = await getUserId();
//
//     notifyListeners();
//
//
//     Map<String, dynamic> map = {
//       "userId": userId,
//
//     };
//
//     print(map);
//     try {
//       ResponseModel responseModel = await   hitRemovePromoCode(map);
//
//       notifyListeners();
//     } on Exception catch (e) {
//       var message = e.toString().replaceAll('Exception:', '');
//
//       print(e.toString());
//       notifyListeners();
//     }
//   }
// }
//
// class PromoData {
//   PromoData({
//     this.id,
//     this.appliedCode,
//     this.isActive,
//     this.planDiscount,
//     this.planprice,
//     this.discountedAmount,
//     this.remainingPrice,
//     this.userId,
//     this.planId,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });
//
//   String ?id;
//   List<AppliedCode>? appliedCode;
//   bool ?isActive;
//   var  planDiscount;
//   var planprice;
//   var discountedAmount;
//  var  remainingPrice;
//   String ?userId;
//   String ?planId;
//   DateTime ?createdAt;
//   DateTime ?updatedAt;
//   int ?v;
//
//   factory PromoData.fromJson(Map<String, dynamic> json) => PromoData(
//     id: json["_id"],
//     appliedCode: json["appliedCode"]==null?[]:List<AppliedCode>.from(json["appliedCode"].map((x) => AppliedCode.fromJson(x))),
//     isActive: json["isActive"],
//     planDiscount: json["planDiscount"],
//     planprice: json["planprice"],
//     discountedAmount: json["discountedAmount"],
//     remainingPrice: json["remainingPrice"],
//     userId: json["userId"],
//     planId: json["planId"],
//     createdAt: DateTime.parse(json["createdAt"]),
//     updatedAt: DateTime.parse(json["updatedAt"]),
//     v: json["__v"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "appliedCode": List<dynamic>.from(appliedCode!.map((x) => x.toJson())),
//     "isActive": isActive,
//     "planDiscount": planDiscount,
//     "planprice": planprice,
//     "discountedAmount": discountedAmount,
//     "remainingPrice": remainingPrice,
//     "userId": userId,
//     "planId": planId,
//     "createdAt": createdAt!.toIso8601String(),
//     "updatedAt": updatedAt!.toIso8601String(),
//     "__v": v,
//   };
// }
//
// class AppliedCode {
//   AppliedCode({
//     this.id,
//     this.type,
//     this.title,
//     this.code,
//     this.isActive,
//     this.fromDate,
//     this.toDate,
//     this.discountType,
//     this.discountValue,
//     this.statusType,
//     this.maxDiscountValue,
//     this.activeType,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//     this.description,
//   });
//
//   String ?id;
//   String ?type;
//   String ?title;
//   String ?code;
//   bool ?isActive;
//   DateTime? fromDate;
//   DateTime ?toDate;
//   String ?discountType;
//   int ?discountValue;
//   dynamic statusType;
//   int ?maxDiscountValue;
//   String ?activeType;
//   DateTime ?createdAt;
//   DateTime ?updatedAt;
//   int ?v;
//   String ?description;
//
//   factory AppliedCode.fromJson(Map<String, dynamic> json) => AppliedCode(
//     id: json["_id"],
//     type: json["type"],
//     title: json["title"],
//     code: json["code"],
//     isActive: json["isActive"],
//     fromDate: DateTime.parse(json["fromDate"]),
//     toDate: DateTime.parse(json["toDate"]),
//     discountType: json["discountType"],
//     discountValue: json["discountValue"],
//     statusType: json["statusType"],
//     maxDiscountValue: json["maxDiscountValue"],
//     activeType: json["activeType"],
//     createdAt: DateTime.parse(json["createdAt"]),
//     updatedAt: DateTime.parse(json["updatedAt"]),
//     v: json["__v"],
//     description: json["description"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "type": type,
//     "title": title,
//     "code": code,
//     "isActive": isActive,
//     "fromDate": fromDate!.toIso8601String(),
//     "toDate": toDate!.toIso8601String(),
//     "discountType": discountType,
//     "discountValue": discountValue,
//     "statusType": statusType,
//     "maxDiscountValue": maxDiscountValue,
//     "activeType": activeType,
//     "createdAt": createdAt!.toIso8601String(),
//     "updatedAt": updatedAt!.toIso8601String(),
//     "__v": v,
//     "description": description,
//   };
// }
