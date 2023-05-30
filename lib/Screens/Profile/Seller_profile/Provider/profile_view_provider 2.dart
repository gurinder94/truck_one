import 'package:flutter/cupertino.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/seller_profile_model.dart';

class SellerProfileProvider extends ChangeNotifier
{
  late SellerProfileModel sellerProfileModel;
  bool loading=true;
  String? message;
 var  ProgressBar, getName , getProfileImage,precentindicate=0.0;

  hitSellerProfile(BuildContext context) async {
    var getId = await getUserId();
    Map<String, String> map = {
      'userId': getId,
    };

    loading = true;

    print(map);
    try {
      sellerProfileModel = await SellerProfileApi(map);

      loading = false;

      notifyListeners();
    } on Exception catch (e) {
      loading = false;
      message = e.toString().replaceAll('Exception:', '');

      print(message);
      showMessage(message!);
      print(e.toString());
      notifyListeners();
    }
  }
  getvalueSharedPreferences() async {
  getName = await getNameInfo() ?? "";
    ProgressBar = await getProgressBar() ?? 0;

    if (50 < ProgressBar!) {
      precentindicate = 0.6;
    }
    if (80 < ProgressBar!) precentindicate = 0.8;
    if (95 < ProgressBar!) precentindicate = 1.0;

    notifyListeners();
  }

  getProfileImageSharedPreferences() async {
  getProfileImage = await getprofileInfo() ?? "";
    notifyListeners();
  }
}