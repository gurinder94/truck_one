import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../AppUtils/UserInfo.dart';
import '../../../AppUtils/constants.dart';
import '../../../Model/sellerDashBoardModel 2.dart';
class SellerDashBordProvider extends ChangeNotifier
{

  late SellerDashBoardModel dashBoardModel;
  late String message;
   List<GRAPTHDATA> dataa=[];
   bool loder=true;
  hitSellerDashBord()

  async {
    dataa=[];
    var  getId= await getUserId();
    var companyId =await getCompanyId();
    Map<String, dynamic> map={
      'sellerId':companyId==""?getId:companyId,
    };
    loder=true;
    notifyListeners();
    print(map);
    try {
      dashBoardModel  = await SellerDashBordApi(map);
      dataa.addAll(dashBoardModel.data![0].grapthdata!);

      dashBoardModel.setTotalAnswer(dashBoardModel.data!);
      loder=false;
notifyListeners();

    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(
        message,
      );
      print(e.toString());
    }
    loder=false;
    notifyListeners();
  }
var    selectionBehavior = SelectionBehavior(
  enable: true,

);
 var   tooltipBehavior = TooltipBehavior(
  enable: true,
  borderColor: Colors.black,
  borderWidth: 20,
  color: Colors.black.withOpacity(0.2),



  );


}