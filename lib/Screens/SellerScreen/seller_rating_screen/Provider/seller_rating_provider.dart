import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/Seller_rating_given_by_customer_Model.dart';

class SellerRatingProvider extends ChangeNotifier {
  bool loading = true;
  late SellerRatingGivenByCustomerModel givenByCustomerModel;
  List<Datum> sellerRatingList = [];
  late String message;

  getSellerRatingGivenCustomer() async {
    var getid = await getUserId();
    Map<String, dynamic> map = {
      "sellerId": getid
    };

    print(map);
    loading = true;

    try {
      givenByCustomerModel = await SellerRatingGivenByCustomerApi(map);

      sellerRatingList.addAll(givenByCustomerModel.data!);

      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      print("hh");
      message = e.toString().replaceAll('Exception:', '');
    }
    loading = false;
  }

  resetList() {
    sellerRatingList = [];
  }
}