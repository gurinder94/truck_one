import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/CompanyProfile.dart';

class CompanyViewProvider extends ChangeNotifier {
  bool _loading = false;

  get loading => _loading;
   CompanyDetail ? companyDetail;
  String? message;

  hitCompanyProfile(BuildContext context) async {
    var getId = await getUserId();
    Map<String, String> map = {
      'companyId': getId,
    };

    _loading = true;
    notifyListeners();
    print(map);
    try {
      companyDetail = await hitCompanyProfileApi(map);
      setNameInfo(companyDetail!.companyName==null?companyDetail!
          .firstName:companyDetail!.firstName.toString()+' '+companyDetail!.lastName.toString());


      setprofileInfo(companyDetail!.companyLogo == null ? '' : companyDetail!.companyLogo);
      _loading = false;
      notifyListeners();
    } on Exception catch (e) {
      _loading = false;
      message = e.toString().replaceAll('Exception:', '');

      print(message);
      showMessage(message!);
      print(e.toString());
      notifyListeners();
    }
  }
}
