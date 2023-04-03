// To parse this JSON data, do
//
//     final sellerProductList = sellerProductListFromJson(jsonString);

import 'dart:convert';

SellerProductList sellerProductListFromJson(String str) => SellerProductList.fromJson(json.decode(str));

String sellerProductListToJson(SellerProductList data) => json.encode(data.toJson());

class SellerProductList {
  SellerProductList({
    this.code,
    this.message,
    this.data,
    this.totalCount,
  });

  int ?code;
  String ?message;
  List<SellerProduct>? data;
  int ?totalCount;

  factory SellerProductList.fromJson(Map<String, dynamic> json) => SellerProductList(
    code: json["code"],
    message: json["message"],
    data: List<SellerProduct>.from(json["data"].map((x) => SellerProduct.fromJson(x))),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}

class SellerProduct {
  SellerProduct({
    this.id,
    this.brandName,
    this.productNumber,
    this.oem,
    this.suitableForModels,
    this.categoryName,
    this.constantName,
    this.subCategoryName,
    this.categoryId,
    this.datumModelName,
    this.datumBrandName,
    this.axles,
    this.images,
    this.condition,
    this.length,
    this.width,
    this.height,
    this.price,
    this.description,
    this.quantity,
    this.productName,
    this.productionYear,
    this.mileage,
    this.weight,
    this.netWeight,
    this.grossWeight,
    this.payLoad,
    this.color,
    this.transmissionType,
    this.vin,
    this.suspension,
    this.fuelType,
    this.fuelCapacity,
    this.wheelBase,
    this.breaks,
    this.wheels,
    this.loadCapacity,
    this.location,
    this.isActive,
    this.isDeleted,
    this.engineHours,
    this.currency,
    this.manufactureName,
    this.modelName,
  });

  String ?id;
  String ?brandName;
  String ?productNumber;
  dynamic oem;
  List<dynamic> ?suitableForModels;
  String? categoryName;
  String ?constantName;
  String ?subCategoryName;
  String ?categoryId;
  String ?datumModelName;
  String ?datumBrandName;
  dynamic axles;
  List<Image> ?images;
  String ?condition;
  dynamic length;
  int ?width;
  int ?height;
  int ?price;
  String ?description;
  int ?quantity;
  String ?productName;
  int ?productionYear;
  int ?mileage;
  dynamic weight;
  int ?netWeight;
  int ?grossWeight;
  int ?payLoad;
  List<String>? color;
  String ?transmissionType;
  String ?vin;
  String ?suspension;
  String ?fuelType;
  int ?fuelCapacity;
  int ?wheelBase;
  String ?breaks;
  dynamic wheels;
  int ?loadCapacity;
  String ?location;
  bool ?isActive;
  bool ?isDeleted;
  dynamic engineHours;
  String ?currency;
  dynamic manufactureName;
  String ?modelName;

  factory SellerProduct.fromJson(Map<String, dynamic> json) => SellerProduct(
    id: json["_id"],
    brandName: json["brandName"] == null ? null : json["brandName"],
    productNumber: json["productNumber"],
    oem: json["OEM"],
    suitableForModels: List<dynamic>.from(json["suitableForModels"].map((x) => x)),
    categoryName: json["category_name"],
    constantName: json["constant_name"],
    subCategoryName: json["subCategory_name"],
    categoryId: json["categoryId"],
    datumModelName: json["model_name"] == null ? null : json["model_name"],
    datumBrandName: json["brand_name"] == null ? null : json["brand_name"],
    axles: json["axles"],
    images:json["images"]==null?[]: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    condition: json["condition"],
    length: json["length"],
    width: json["width"],
    height: json["height"],
    price: json["price"],
    description: json["description"],
    quantity: json["quantity"],
    productName: json["productName"],
    productionYear: json["productionYear"],
    mileage: json["mileage"],
    weight: json["weight"],
    netWeight: json["netWeight"],
    grossWeight: json["grossWeight"],
    payLoad: json["payLoad"],
    // color: List<String>.from(json["color"].map((x) => x)),
    transmissionType: json["transmissionType"],
    vin: json["vin"] == null ? null : json["vin"],
    suspension: json["suspension"],
    fuelType: json["fuelType"],
    fuelCapacity: json["fuelCapacity"],
    wheelBase: json["wheelBase"],
    breaks: json["breaks"],
    wheels: json["wheels"],
    loadCapacity: json["loadCapacity"],
    location: json["location"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    engineHours: json["engineHours"],
    currency: json["currency"],
    manufactureName: json["manufactureName"],
    modelName: json["modelName"] == null ? null : json["modelName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "brandName": brandName == null ? null : brandName,
    "productNumber": productNumber,
    "OEM": oem,
    "suitableForModels": List<dynamic>.from(suitableForModels!.map((x) => x)),
    "category_name": categoryName,
    "constant_name": constantName,
    "subCategory_name": subCategoryName,
    "categoryId": categoryId,
    "model_name": datumModelName == null ? null : datumModelName,
    "brand_name": datumBrandName == null ? null : datumBrandName,
    "axles": axles,
    "images": List<dynamic>.from(images!.map((x) => x.toJson())),
    "condition": condition,
    "length": length,
    "width": width,
    "height": height,
    "price": price,
    "description": description,
    "quantity": quantity,
    "productName": productName,
    "productionYear": productionYear,
    "mileage": mileage,
    "weight": weight,
    "netWeight": netWeight,
    "grossWeight": grossWeight,
    "payLoad": payLoad,
    // "color": List<dynamic>.from(color!.map((x) => x)),
    "transmissionType": transmissionType,
    "vin": vin == null ? null : vin,
    "suspension": suspension,
    "fuelType": fuelType,
    "fuelCapacity": fuelCapacity,
    "wheelBase": wheelBase,
    "breaks": breaks,
    "wheels": wheels,
    "loadCapacity": loadCapacity,
    "location": location,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "engineHours": engineHours,
    "currency": currency,
    "manufactureName": manufactureName,
    "modelName": modelName == null ? null : modelName,
  };
}

class Image {
  Image({
    this.name,
    this.id,
  });

  String ?name;
  String ?id;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    name: json["name"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "_id": id,
  };
}
