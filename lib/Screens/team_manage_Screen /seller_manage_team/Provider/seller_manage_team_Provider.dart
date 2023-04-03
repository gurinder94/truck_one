import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/ecommerce_category_model.dart';
import 'package:my_truck_dot_one/Model/ManageTeamModel/seller_manage_team_model.dart';

class SellerManageTeamProvider extends ChangeNotifier
{
bool loading=true;
String ? message;
var valueItemSelected = "Accepted";
 SellerManageTeamModel ?sellerManageTeamModel;

 List <SellerManageTeam> sellerManageTeamList=[];


 String  ? valueSelectedCategory;
 String ? categoryId;

var  valueAccessRole="Accepted";
var valuePersonName=  "Salesperson";
List<String> items = [
  "Accepted",
  "Declined",
  "In Progress",
];
List<String> items1 = [
  "Salesperson",

];
hitManageTeam(BuildContext context, String ?type, String search, ) async {
  var getId= await getUserId();
  sellerManageTeamList.clear();
  Map<String, dynamic> map = {
    "accessLevel": "SALESPERSON",
    "companyId": getId,
    "isAccepted": valueAccessRole=="Declined"?'decline':valueAccessRole=='Accepted'?'accept':valueAccessRole=="In Progress"?"pending":'',
    "page": 1,
    "searchKey": search
  };

  loading = true;
notifyListeners();
  print(map);
  try {
    sellerManageTeamModel = await SellerManageTeamModelApi(map);
    sellerManageTeamList.addAll(sellerManageTeamModel!.data!);

    loading = false;
    notifyListeners();
  } on Exception catch (e) {
    loading = false;
    message = e.toString().replaceAll('Exception:', '');
    print(e.toString());
    notifyListeners();
  }
}


resetSellerManageList()
{
  sellerManageTeamList=[];
}

resetFilterValue()
{
  valueAccessRole="Accepted";
}
void setAccessRole(String s) {
  valueAccessRole = s;
  print(s);
  notifyListeners();
}

void setPerson(String s) {
  print(s);
  valuePersonName = s;
  notifyListeners();
}

}