import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/product_view_model.dart';

class SellerViewProductProvider extends ChangeNotifier
{
  double offset = 0.0;
  var scrollController = ScrollController();
  var check = false;
  bool loading = true;
  late ProductView productView;
  void scrollListener() {
    scrollController.addListener(() {
      offset = scrollController.offset;
      notifyListeners();
    });
  }

  getProductView(String   value) async {
    var getId=await getUserId();
    Map<String, String> map = {"_id": value,
      };

    print(map);
     loading = true;

    try {
      productView = await  hitProductViewApi(map);

      loading = false;
      notifyListeners();

    } on Exception {
      print("hh");
      // message = e.toString().replaceAll('Exception:', '');
      //
      // print(e.toString());
      // notifyListeners();
    }



  }
}