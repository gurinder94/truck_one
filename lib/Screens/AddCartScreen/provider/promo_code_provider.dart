

import 'package:flutter/material.dart';

import '../../../ApiCall/api_Call.dart';
import '../../../AppUtils/UserInfo.dart';
import '../../../AppUtils/constants.dart';
import '../../../Model/NetworkModel/normal_response.dart';
import '../../../Model/SubscriptionPlanModel/promo_code_model.dart';

class PromoCodeProvider extends ChangeNotifier {
  bool loading = false;
  bool ApplyPromoLoading = false;
  PromoCodeModel? promoCodeModel;

  hitGetPromoCodeList() async {
    var userId = await getUserId();
    loading = true;
    notifyListeners();
    Map<String, dynamic> map = {"userId": userId};

    print(map);
    try {
      promoCodeModel = await hitPromoCodeList(map);

      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      loading = false;
      print(e.toString());
      notifyListeners();
    }
  }




}
