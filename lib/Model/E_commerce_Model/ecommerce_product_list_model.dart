// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel  {
  ProductListModel({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String? message;
  List<ProductModel>? data;
  int ?totalCount;

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
    code: json["code"],
    message: json["message"],
    data: List<ProductModel>.from(json["data"].map((x) => ProductModel.fromJson(x))),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}

class ProductModel  extends ChangeNotifier {
  ProductModel({
    this.id,
    this.wishListData,
    this.iswishList,
    this.productNumber,
    this.oem,
    this.suitableForModels,
    this.brandName,
    this.productName,
    this.categoryId,
    this.categoryName,
    this.constantName,
    this.subCategoryName,
    this.datumModelName,
    this.datumBrandName,
    this.createdById,
    this.isActive,
    this.isDeleted,
    this.noOfMiles,
    this.loadCapacity,
    this.wheels,
    this.breaks,
    this.wheelBase,
    this.fuelCapacity,
    this.fuelType,
    this.suspension,
    this.engineDisplacement,
    this.enginePoweroutput,
    this.engineBrand,
    this.vin,
    this.transmissionType,
    this.productType,
    this.payLoad,
    this.grossWeight,
    this.netWeight,
    this.weight,
    this.mileage,
    this.productionYear,
    this.quantity,
    this.description,
    this.price,
    this.height,
    this.width,
    this.length,
    this.condition,
    this.images,
    this.axles,
    this.location,
    this.color,
    this.engineHours,
    this.currency,
    this.manufactureName,
    this.modelName,
  });

  String ?id;
  List<dynamic>? wishListData;
  bool ?iswishList;
  String? productNumber;
  dynamic oem;
  List<dynamic>? suitableForModels;
  String ?brandName;
  String? productName;
  String ?categoryId;
  String ?categoryName;
  String ?constantName;
  String ?subCategoryName;
  String ?datumModelName;
  String ?datumBrandName;
  String ?createdById;
  bool ?isActive;
  bool ?isDeleted;
  dynamic noOfMiles;
  var loadCapacity;
  dynamic wheels;
  String ?breaks;
  var wheelBase;
  var fuelCapacity;
  String ?fuelType;
  String ?suspension;
  var engineDisplacement;
  var enginePoweroutput;
  String ?engineBrand;
  String ?vin;
  String ?transmissionType;
  String ?productType;
  var payLoad;
  var grossWeight;
  var netWeight;
  dynamic weight;
  var mileage;
  var productionYear;
  var quantity;
  String? description;
  var price;
  var height;
  var width;
  dynamic length;
  String ?condition;
  List<Images> ?images;
  dynamic axles;
  String ?location;
  List<String>? color;
  dynamic engineHours;
  String ?currency;
  dynamic manufactureName;
  String ?modelName;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["_id"],
    wishListData: List<dynamic>.from(json["wishListData"].map((x) => x)),
    iswishList: json["iswishList"],
    productNumber: json["productNumber"],
    oem: json["OEM"],
    suitableForModels: List<dynamic>.from(json["suitableForModels"].map((x) => x)),
    brandName: json["brandName"] == null ? null : json["brandName"],
    productName: json["productName"],
    categoryId: json["categoryId"],
    categoryName: json["category_name"],
    constantName: json["constant_name"],
    subCategoryName: json["subCategory_name"],
    datumModelName: json["model_name"] == null ? null : json["model_name"],
    datumBrandName: json["brand_name"] == null ? null : json["brand_name"],
    createdById: json["createdById"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    noOfMiles: json["noOfMiles"],
    loadCapacity: json["loadCapacity"],
    wheels: json["wheels"],
    breaks: json["breaks"],
    wheelBase: json["wheelBase"],
    fuelCapacity: json["fuelCapacity"],
    fuelType: json["fuelType"],
    suspension: json["suspension"],
    engineDisplacement: json["engineDisplacement"],
    enginePoweroutput: json["enginePoweroutput"],
    engineBrand: json["engineBrand"],
    vin: json["vin"] == null ? null : json["vin"],
    transmissionType: json["transmissionType"],
    productType: json["productType"],
    payLoad: json["payLoad"],
    grossWeight: json["grossWeight"],
    netWeight: json["netWeight"],
    weight: json["weight"],
    mileage: json["mileage"],
    productionYear: json["productionYear"],
    quantity: json["quantity"],
    description: json["description"],
    price: json["price"],
    height: json["height"],
    width: json["width"],
    length: json["length"],
    condition: json["condition"],
    images:json["images"]==null?[]: List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
    axles: json["axles"],
    location: json["location"],

    engineHours: json["engineHours"],
    currency: json["currency"],
    manufactureName: json["manufactureName"],
    modelName: json["modelName"] == null ? null : json["modelName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "wishListData": List<dynamic>.from(wishListData!.map((x) => x)),
    "iswishList": iswishList,
    "productNumber": productNumber,
    "OEM": oem,
    "suitableForModels": List<dynamic>.from(suitableForModels!.map((x) => x)),
    "brandName": brandName == null ? null : brandName,
    "productName": productName,
    "categoryId": categoryId,
    "category_name": categoryName,
    "constant_name": constantName,
    "subCategory_name": subCategoryName,
    "model_name": datumModelName == null ? null : datumModelName,
    "brand_name": datumBrandName == null ? null : datumBrandName,
    "createdById": createdById,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "noOfMiles": noOfMiles,
    "loadCapacity": loadCapacity,
    "wheels": wheels,
    "breaks": breaks,
    "wheelBase": wheelBase,
    "fuelCapacity": fuelCapacity,
    "fuelType": fuelType,
    "suspension": suspension,
    "engineDisplacement": engineDisplacement,
    "enginePoweroutput": enginePoweroutput,
    "engineBrand": engineBrand,
    "vin": vin == null ? null : vin,
    "transmissionType": transmissionType,
    "productType": productType,
    "payLoad": payLoad,
    "grossWeight": grossWeight,
    "netWeight": netWeight,
    "weight": weight,
    "mileage": mileage,
    "productionYear": productionYear,
    "quantity": quantity,
    "description": description,
    "price": price,
    "height": height,
    "width": width,
    "length": length,
    "condition": condition,
    "images": List<dynamic>.from(images!.map((x) => x.toJson())),
    "axles": axles,
    "location": location,
    "color": List<dynamic>.from(color!.map((x) => x)),
    "engineHours": engineHours,
    "currency": currency,
    "manufactureName": manufactureName,
    "modelName": modelName == null ? null : modelName,
  };

  void  addWishlist(
      String id, bool value,) async {
    var getid=await getUserId();
    Map<String, dynamic> map = {
      "productId": id,
      'userId': getid,
    };
    print(map);
    try {
      ResponseModel res = await hitAddWishlist(map);
      showMessage(res.message,);
      iswishList = value;
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message,);

      print(e.toString());
      notifyListeners();
    }
  }
  void  removeWishlist(
      String id, bool value,) async {
    var  getid= await getUserId();
    Map<String, dynamic> map = {
      "productId": id,
      '_id': getid,
    };

    print(map);
    try {
      ResponseModel res = await hitRemoveWishlist(map);
      showMessage(res.message,);
      iswishList = value;
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message,);

      print(e.toString());
      notifyListeners();
    }
  }
}

class Images  {
  Images({
    this.name,
    this.id,
  });

  String? name;
  String ?id;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    name: json["name"]==null?'':json["name"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "_id": id,
  };
}
