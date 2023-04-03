import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/add_seller_rating_model.dart';

class SupportInformationProvider extends ChangeNotifier
{

  bool loading = true;

  String? message;
  late AddSellerRatingModel addSellerRatingModel;
  TextEditingController supporEditingController = TextEditingController();
  getSellerRatingToken() async {
    var getid = await getUserId();
    Map<String, dynamic> map = {
      "path": "/pages/e-commerce/rating",
      "sellerId": getid,
      "userId": "617a2f9169297319abc21a05"
    };

    print(map);
    loading = true;



    try {
      addSellerRatingModel = await SellerRatingTokenApi(map);

      supporEditingController.text=SERVER_URL+addSellerRatingModel.data!.urlPath.toString();
      print(SERVER_URL+addSellerRatingModel.data!.urlPath.toString());
      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      print("hh");
      message = e.toString().replaceAll('Exception:', '');
      print(message);
      // print(e.toString());
      // notifyListeners();

    }
  }

}