import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/team_manage_Screen%20/seller_manage_team/Provider/seller_manage_team_Provider.dart';

import '../../../commanWidget/comman_button_widget.dart';
import 'drop_access_role_team_manage.dart';
import 'drop_manage_team_saleperson.dart';

class SellerFliter extends StatelessWidget {
  SellerManageTeamProvider manageTeamProvide;

  SellerFliter(this.manageTeamProvide);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            AppLocalizations.instance.text('Status'),
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 20,
          ),
          SellerAccessRole(),
          SizedBox(
            height: 20,
          ),
          ManageTeamPerson(),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: CommanButtonWidget(
                  title: AppLocalizations.instance.text('Cancel'),
                  buttonColor: PrimaryColor,
                  titleColor: APP_BG,
                  onDoneFuction: () {
                    Navigator.of(context).pop();
                  },
                  loder: false,
                ),
              ),
              Expanded(
                child: CommanButtonWidget(
                  title: AppLocalizations.instance.text('Apply'),
                  buttonColor: PrimaryColor,
                  titleColor: APP_BG,
                  onDoneFuction: () {
                    manageTeamProvide.resetSellerManageList();
                    manageTeamProvide.hitManageTeam(
                        context, manageTeamProvide.valueItemSelected, '');

                    Navigator.of(context).pop();
                  },
                  loder: false,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
