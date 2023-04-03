import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:my_truck_dot_one/Screens/team_manage_Screen%20/company_team_manage/Provider/team_manger_provider.dart';
import 'package:my_truck_dot_one/Screens/team_manage_Screen%20/company_team_manage/company_team_mange_component/team_manage_screen.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';


class SendMemInviteProvider extends ChangeNotifier {
  late BuildContext context;
  bool loading = false
  ;

  setContext(BuildContext context) {
    this.context = context;
  }

  String message = '';
  ResponseModel _model = ResponseModel();
  var valueItemSelected;

  ResponseModel get model => _model;

  sendInviteMember(Map<String, dynamic> map) async {
    loading = true;
    notifyListeners();
    print(map);
    var rolename = await getRoleInfo();
    try {
      _model = await hitSendInviteMember(map,);

      print(_model.code);
      if (_model.code == 401) {
        loading = false;
        notifyListeners();

        return rolename == "COMPANY" ? DialogUtils.showMyDialog(
          context,
          onDoneFunction: () async {
            _launchURL();
            Navigator.pop(context);

          },
          oncancelFunction: () => Navigator.pop(context),
          title: 'Plan upgrade',
          alertTitle:"Other Plan",
          btnText: "Done",
        ) : DialogUtils.showMyDialog(
          context,
          onDoneFunction: () async {

            Navigator.pop(context);
          },
          oncancelFunction: () => Navigator.pop(context),
          title: 'Buy Plan !',
          alertTitle:
          "You Don't have any Plan yet. Please Click below to go on Pricing page.",
          btnText: "Done",
        );

      }
      else if(_model.code==200)
        {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>

                  ChangeNotifierProvider(
                      create: (_) => ManagerTeamProvider(),child: CompanyTeamManageScreen(0,true)),
              ));

        }

      showMessage(_model.message.toString());
      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
    loading = false;
  }

  var items = ["Dispatcher", "Driver", "HR"];


  setSelectedItem(value) {
    valueItemSelected = value;

    print(value);
    print(valueItemSelected);
    notifyListeners();
  }

  _launchURL() async {
    String url = "http://74.208.25.43:3001/pages/pricing-page";
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
      throw 'Could not launch $url';
    }
  }
}