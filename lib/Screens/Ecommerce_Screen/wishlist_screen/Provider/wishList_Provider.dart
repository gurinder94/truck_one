import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/wish_list_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';

class WishListProvider extends ChangeNotifier {
  bool loading = true;
  late String message;
  late WishListModel wishListModel;

  List<Datum> WishList = [];

  getWishList() async {
    var getid = await getUserId();
    Map<String, dynamic> map = {"userId": getid, "page": 1};

    print(map);
    loading = true;
    notifyListeners();

    try {
      wishListModel = await hitWishListApi(map);

      WishList.addAll(wishListModel.data!);
      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      print("hh");
      message = e.toString().replaceAll('Exception:', '');
      print(e.toString());
      // notifyListeners();
    }
  }

  void removeWishlist(
    String id,
    int index, WishListProvider noti,

  ) async {
    var getid = await getUserId();
    Map<String, dynamic> map = {
      "productId": id,
      '_id': getid,
    };

    print(map);
    try {
      ResponseModel res = await hitRemoveWishlist(map);
      print("lajj$index");
      noti.WishList.removeAt(index);


      showMessage(res.message,);


      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(
        message,
      );

      print(e.toString());
      notifyListeners();
    }
  }
}
