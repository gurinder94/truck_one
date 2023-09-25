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
  int page = 1;

  bool paginationLoder = false;

  getWishList() async {
    var getid = await getUserId();
    Map<String, dynamic> map = {"userId": getid, "page": page};

    print(map);
    if (paginationLoder == false) {
      loading = true;
    }
    notifyListeners();

    try {
      wishListModel = await hitWishListApi(map);
      if (wishListModel.data!.length > 0) WishList.addAll(wishListModel.data!);

      loading = false;
      paginationLoder = false;
      notifyListeners();
      print('WishList> ${WishList.length}');
    } on Exception catch (e) {
      print("hh");
      message = e.toString().replaceAll('Exception:', '');
      print(e.toString());
      paginationLoder = false;
      loading = false;
      notifyListeners();
    }
  }

  void removeWishlist(
    String id,
    int index,
    WishListProvider noti,
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

      showMessage(
        res.message,
      );

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

  void initScrollListener(ScrollController scrollController) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (paginationLoder == false) {
          paginationLoder = true;
          page = page + 1;
          getWishList();
        }
        // Perform event when user reach at the end of list (e.g. do Api call)
      }
    });
  }
}
