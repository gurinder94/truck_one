import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/ecommerce_category_model.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/seller_product_List_model.dart';

class SellerProductListProvider extends ChangeNotifier {
  bool loading = false;
  bool ecommerceloading = true;
  List<String> archive = ['Archive', 'Unarchive'];
  String? message;
  late SellerProductList sellerProductList;
  List<SellerProduct> ProductList = [];
  String? valueSelectedCategory;
  String? valueSelectedarchive = "Unarchive";
  String? categoryId;
  EcommerceCategoryModel? ecommerceCategoryModel;

  getSellerProduct(String search, String categoryId) async {
    print( valueSelectedarchive);
    var getid = await getUserId();
    var roleTitle=await getRoleInfo();
    var companyId=await getCompanyId();
    Map<String, dynamic> map = {
      "categoryId": categoryId,
      "companyId": companyId==""?getid:companyId,
      "isActive": "true",
      "isDeleted": valueSelectedarchive=="Archive" ?"true":"false",
      "page": 1,
      "searchText": search,
    };

    print(map);

    loading = true;
    notifyListeners();
    try {
      sellerProductList = await hitSellerProductListApi(map);

      ProductList.addAll(sellerProductList.data!);

      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      print("hh");
      message = e.toString().replaceAll('Exception:', '');
    }
    loading = false;
  }

  setSelectedItem(
    value,
    stateId,
  ) {
    valueSelectedCategory = value;
    categoryId = stateId;
    notifyListeners();
  }

  setSelectedarchive(
    value,
  ) {
    valueSelectedarchive = value;

    notifyListeners();
  }

  hitCategoryList() async {
    Map<String, dynamic> map = {
      "isActive": "true",
      "parentFlag": "true",
    };

    ecommerceloading = true;

    print(map);
    try {
      ecommerceCategoryModel = await hitGetCategoryApi(map);

      ecommerceloading = false;
      notifyListeners();
    } on Exception catch (e) {
      ecommerceloading = false;
      message = e.toString().replaceAll('Exception:', '');
      print(message);
      print(e.toString());
      notifyListeners();
    }
  }

  resetList() {
    ProductList = [];
  }

  resetDrop() {
    valueSelectedarchive = "Unarchive";
    valueSelectedCategory;
  }
}
