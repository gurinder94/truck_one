import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/ecommerce_category_model.dart';

class CategoryProvider extends ChangeNotifier {
  bool loading = true;
  String? message;

  late EcommerceCategoryModel ecommerceCategoryModel;

  getCategory() async {
    Map<String, String> map = {"parentFlag": "true"};

    print(map);
    loading = true;
    notifyListeners();

    try {
      ecommerceCategoryModel = await hitGetCategoryApi(map);

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
}
