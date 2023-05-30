import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/BrandListModel.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/ecommerce_product_list_model.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/modelList.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/sub_category_list.dart';

class ProductListProvider extends ChangeNotifier {
  bool loading = true;
  bool Productloading = true;
  bool pagionation = false;
  String? message;
  TextEditingController searchText = TextEditingController();
  late ProductListModel productListModel;
  List<ProductModel> productList = [];
  late BrandListModel brandListModel;
  late SubCategoryList categoryList;
  late ModelList modelList;

  int menuClick = 0;
  var value;

  var valueCategory;
  var valueModel;
  var valueBrand = [];
  var valueProductCondation = [];
  var valuePriceStart;
  var valuePriceEnd;
  var valueYearStart;
  var valueYearEnd;
  Map<String, bool> newProduct = {
    'NEW': false,
    'USED': false,
  };
  var productCondation = ['NEW', 'USED'];

  setMenuClick(int pos) {
    menuClick = pos;
    print(pos);

    notifyListeners();
  }

  setModel(var val) {
    this.value = val;
    notifyListeners();
  }

  getProduct(String categoryId, int pagee, bool pagenationloading) async {
    var getid = await getUserId();
    Map<String, dynamic> map = {
      "isActive": "true",
      "isDeleted": "false",
      "brandId": valueBrand,
      "condition": valueProductCondation,
      "minPrice": valuePriceEnd == null ? '' : valuePriceEnd,
      "maxPrice": valuePriceStart == null ? '' : valuePriceStart,
      "minYear": valueYearEnd == null ? '' : valueYearEnd,
      "maxYear": valueYearStart == null ? '' : valueYearStart,
      "categoryId": categoryId,
      "subCategory": valueCategory == null ? '' : valueCategory,
      "manufactureId": "",
      "modelId": valueModel == null ? '' : valueModel,
      "page": pagee,
      "searchText": searchText.text,
      "userId": getid,
    };

    print(map);
    if (pagenationloading == false) {
      Productloading = true;
    } else {
      pagionation = true;
    }
    notifyListeners();

    try {
      productListModel = await hitGetProductListApi(map);

      productList.addAll(productListModel.data!);

      notifyListeners();
    } on Exception catch (e) {
      print("hh");
      pagionation = false;
      Productloading = false;
      message = e.toString().replaceAll('Exception:', '');
      //
      // print(e.toString());
      // notifyListeners();
    }
    Productloading = false;
    pagionation = false;
  }

  getBrandList() async {
    var getid = await getUserId();
    Map<String, dynamic> map = {
      "isActive": "true",
      "isDeleted": "false",
      "isAdminApprove": "APPROVED",
      "count": 100
    };
    loading = true;
    notifyListeners();
    print(map);
    try {
      brandListModel = await hitBrandListApi(map);
      loading = false;
      notifyListeners();
    } on Exception catch (e) {

      message = e.toString().replaceAll('Exception:', '');
      //
      // print(e.toString());
      // notifyListeners();
    }
  }

  getSubCategory(String categoryId) async {
    var getid = await getUserId();
    Map<String, dynamic> map = {
      "parentCategoryId": categoryId,
    };
    loading = true;
    print(map);
    try {
      categoryList = await hitSubCategoryApi(map);

      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      print("hh");
      message = e.toString().replaceAll('Exception:', '');
      //
      // print(e.toString());
      // notifyListeners();
    }
  }

  getModelList() async {
    var getid = await getUserId();
    Map<String, dynamic> map = {
      "count": 100,
      "isActive": "true",
      "isAdminApprove": "APPROVED",
      "isDeleted": "false",
      "sortOrder": 1,
      "sortValue": "model",
    };
    loading = true;
    print(map);
    try {
      modelList = await hitModelListApi(map);
      loading = false;
      Productloading = false;
      notifyListeners();
    } on Exception catch (e) {
      print("hh");
      message = e.toString().replaceAll('Exception:', '');
      //
      // print(e.toString());
      // notifyListeners();
    }
  }

  reset() {
    value = '';
    valueCategory = '';
    valueModel = '';

    valueBrand.clear();
    valueProductCondation = [];
    valuePriceStart = '';
    valuePriceEnd = '';
    valueYearStart = '';
    valueYearEnd = '';
    searchText.text = '';
  }

  resetFilter() {
    value = '';
    valueCategory = '';
    valueModel = '';

    valueBrand.clear();
    valueProductCondation = [];
    valuePriceStart = '';
    valuePriceEnd = '';
    valueYearStart = '';
    valueYearEnd = '';
    searchText.text = '';
    print(valueBrand);

    for (int i = 0; i < brandListModel.data!.length; i++) {
      if (brandListModel.data![i].check == true) {
        brandListModel.data![i].check = false;
        notifyListeners();
      }
    }
    for (int i = 0; i < newProduct.length; i++) {
      if (newProduct[productCondation[i]] == true) {
        newProduct[productCondation[i]] = false;
        notifyListeners();
      }
    }
    notifyListeners();
  }
}
