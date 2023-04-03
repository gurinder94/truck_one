// To parse this JSON data, do
//
//     final productView = productViewFromJson(jsonString);

import 'dart:convert';

ProductView productViewFromJson(String str) => ProductView.fromJson(json.decode(str));

String productViewToJson(ProductView data) => json.encode(data.toJson());

class ProductView {
  ProductView({
    this.code,
    this.message,
    this.data,
  });

  int ?code;
  String? message;
  Data ?data;

  factory ProductView.fromJson(Map<String, dynamic> json) => ProductView(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.wishListData,
    this.iswishList,
    this.productNumber,
    this.oem,
    this.suitableForModels,
    this.brandName,
    this.productName,
    this.categoryId,
    this.brandId,
    this.modelId,
    this.subCategoryId,
    this.categoryName,
    this.constantName,
    this.subCategory,
    this.dataModelName,
    this.dataBrandName,
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
    this.sellerName,
    this.selleraddress,
    this.sellercity,
    this.currency,
    this.manufactureName,
    this.modelName,
  });

  String ?id;
  List<WishListDatum>? wishListData;
  bool ?iswishList;
  String? productNumber;
  dynamic oem;
  List<dynamic> ?suitableForModels;
  dynamic brandName;
  String ? productName;
  String ?categoryId;
  String ?brandId;
  String ?modelId;
  String ?subCategoryId;
  String ?categoryName;
  String ?constantName;
  String ?subCategory;
  String ?dataModelName;
  String ?dataBrandName;
  String ?createdById;
  bool? isActive;
  bool ?isDeleted;
  dynamic noOfMiles;
  int ?loadCapacity;
  dynamic wheels;
  String ?breaks;
  int ?wheelBase;
  int ?fuelCapacity;
  String? fuelType;
  String ?suspension;
  int? engineDisplacement;
  int ?enginePoweroutput;
  String ?engineBrand;
  dynamic vin;
  String ?transmissionType;
  String ?productType;
  int ?payLoad;
  int ?grossWeight;
  int ?netWeight;
  dynamic weight;
  int ?mileage;
  int ?productionYear;
  int ?quantity;
  String ?description;
  int ?price;
  int ?height;
  int ?width;
  dynamic length;
  String ?condition;
  List<Images>? images;
  dynamic axles;
  String ?location;
  List<String>? color;
  dynamic engineHours;
  String ?sellerName;
  String ?selleraddress;
  String ?sellercity;
  String ?currency;
  dynamic manufactureName;
  dynamic modelName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    wishListData: List<WishListDatum>.from(json["wishListData"].map((x) => WishListDatum.fromJson(x))),
    iswishList: json["iswishList"],
    productNumber: json["productNumber"],
    oem: json["OEM"],
    suitableForModels: List<dynamic>.from(json["suitableForModels"].map((x) => x)),
    brandName: json["brandName"],
    productName: json["productName"],
    categoryId: json["categoryId"],
    brandId: json["brandId"],
    modelId: json["modelId"],
    subCategoryId: json["subCategoryId"],
    categoryName: json["category_name"],
    constantName: json["constant_name"],
    subCategory: json["subCategory"],
    dataModelName: json["model_name"],
    dataBrandName: json["brand_name"],
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
    vin: json["vin"],
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
    images: List<Images>.from(json["images"]==null?[]:json["images"].map((x) => Images.fromJson(x))),
    axles: json["axles"],
    location: json["location"],
    color: List<String>.from(json["color"].map((x) => x)),
    engineHours: json["engineHours"],
    sellerName: json["seller_name"],
    selleraddress: json["selleraddress"],
    sellercity: json["sellercity"],
    currency: json["currency"],
    manufactureName: json["manufactureName"],
    modelName: json["modelName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "wishListData": List<dynamic>.from(wishListData!.map((x) => x.toJson())),
    "iswishList": iswishList,
    "productNumber": productNumber,
    "OEM": oem,
    "suitableForModels": List<dynamic>.from(suitableForModels!.map((x) => x)),
    "brandName": brandName,
    "productName": productName,
    "categoryId": categoryId,
    "brandId": brandId,
    "modelId": modelId,
    "subCategoryId": subCategoryId,
    "category_name": categoryName,
    "constant_name": constantName,
    "subCategory": subCategory,
    "model_name": dataModelName,
    "brand_name": dataBrandName,
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
    "vin": vin,
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
    "seller_name": sellerName,
    "selleraddress": selleraddress,
    "sellercity": sellercity,
    "currency": currency,
    "manufactureName": manufactureName,
    "modelName": modelName,
  };
}

class Images {
  Images({
    this.name,
    this.id,
  });

  String ?name;
  String ?  id;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    name: json["name"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "_id": id,
  };
}

class WishListDatum {
  WishListDatum({
    this.id,
    this.userId,
    this.productId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String ?id;
  String ?userId;
  String ?productId;
  DateTime ?createdAt;
  DateTime ?updatedAt;
  int ?v;

  factory WishListDatum.fromJson(Map<String, dynamic> json) => WishListDatum(
    id: json["_id"],
    userId: json["userId"],
    productId: json["productId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "productId": productId,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}
