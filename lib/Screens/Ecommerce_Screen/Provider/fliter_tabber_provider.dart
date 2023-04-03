import 'package:flutter/cupertino.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';

import '../Fliter_component/heart_listener.dart';

class FliterProvider extends ChangeNotifier {

  double offset = 0.0;
  var scrollController = ScrollController();
  var checkFavourite = false;
  void scrollListener() {

    scrollController.addListener(() {
      offset = scrollController.offset;
      notifyListeners();
    });
  }

  FavouriteListener? listener;
  void setListener(listener) {
    this.listener = listener;
  }
  getFavourite(bool? iswishList)
  {
    checkFavourite=iswishList!;

  }
  void  addWishlist(
      String id, bool value,) async {
    var getid=await getUserId();
    Map<String, dynamic> map = {
      "productId": id,
      'userId': getid,
    };
    checkFavourite=value;
    notifyListeners();
    print(map);
    try {
      ResponseModel res = await hitAddWishlist(map);
      showMessage(res.message);
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message,);

      print(e.toString());
      notifyListeners();
    }
  }
  void  removeWishlist(
      String id, bool value,) async {
    var getid=await getUserId();
    Map<String, dynamic> map = {
      "productId": id,
      '_id': getid,
    };


    print(map);
    try {
      ResponseModel res = await hitRemoveWishlist(map);
      showMessage(res.message,);
      checkFavourite=false;
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message,);

      print(e.toString());
      notifyListeners();
    }
  }
  // hitRemoveWishlist(Map<String, dynamic> map)
}