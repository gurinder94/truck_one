import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/Debouncer.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:my_truck_dot_one/Screens/team_manage_Screen%20/Provider/_invite_member_provider.dart';
import 'package:my_truck_dot_one/Screens/team_manage_Screen%20/Invite_member/invite_friends.dart';

import 'package:my_truck_dot_one/Screens/commanWidget/comman_bottom_sheet.dart';
import 'package:my_truck_dot_one/Screens/team_manage_Screen%20/company_team_manage/company_team_mange_component/separated_manage_team_screen.dart';
import 'package:my_truck_dot_one/Screens/team_manage_Screen%20/company_team_manage/team_manage_tabber/Company_team_manager_tabber.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Home/Component/pagination_widget.dart';
import '../../../Language_Screen/application_localizations.dart';
import '../../../commanWidget/Custom_App_Bar_Widget.dart';
import '../../../commanWidget/Search_bar.dart';
import '../../../commanWidget/SizeConfig.dart';

import 'Manager_team_Screen.dart';
import '../Provider/team_manger_provider.dart';
import '../fliter_component/fliter_component.dart';

class CompanyTeamManageScreen extends StatelessWidget {
  int i;
  bool backVisal;

  CompanyTeamManageScreen(this.i, this.backVisal);

  late ManagerTeamProvider _managerTeamProvider;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _managerTeamProvider = context.read<ManagerTeamProvider>();
    _managerTeamProvider.setMenuClick(i);
    return Selector<ManagerTeamProvider, int>(
        selector: (_, provider) => provider.menuClick,
        builder: (context, tabber, child) {
          return CustomAppBarWidget(
              title: tabber == 0
                  ? AppLocalizations.instance.text('Manage Team')
                  : AppLocalizations.instance.text('Separated Employees'),
              leading: backVisal == false
                  ? SizedBox()
                  : IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
              floatingActionWidget: FloatingActionButton(
                onPressed: () async {
                  var planDate = await getplanDate();
                  var roleName = await getRoleInfo();

                  print(planDate);
                  planDate == true
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                create: (_) => SendMemInviteProvider(),
                                child: InviteFriends()),
                          ),
                        )
                      : DialogUtils.showMyDialog(
                          context,
                          onDoneFunction: () async {
                            Navigator.pop(context);
                          },
                          oncancelFunction: () => Navigator.pop(context),
                          title: 'Buy Event Plan!',
                          alertTitle: 'Pricing Price',
                          btnText: "Done",
                        ); /*DialogUtils.showMySuccessful(context,
                          child: AlertDialog(
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            title: Column(
                              children: [
                                Text(
                                    "You are logged in as a company, so this functionality is unavailable for purchase on the device. \nYou can access this functionality on web portal or contact support@mytruck.one",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                            actions: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  splashColor: PrimaryColor,
                                  highlightColor: Colors.white,
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  onTap: () async {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ));*/
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: PrimaryColor,
                elevation: 5,
              ),
              actions: SizedBox(),
              child: Column(
                children: [
                  SizeConfig.screenHeight! < 1010
                      ? SizedBox(
                          height: Platform.isIOS
                              ? SizeConfig.safeBlockVertical! * 15
                              : SizeConfig.safeBlockVertical! *
                                  12, //10 for example
                        )
                      : SizedBox(
                          height: Platform.isIOS
                              ? SizeConfig.safeBlockVertical! * 9
                              : SizeConfig.safeBlockVertical! *
                                  9, //10 for example
                        ),
                  tabber == 0
                      ? Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: CommanSearchBar(
                              onTextChange: (val) {
                                _managerTeamProvider.search(val, 0);
                              },
                              IconName: GestureDetector(
                                child: Icon(
                                  Icons.filter_list,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  CommanBottomSheet.ShowBottomSheet(context,
                                      child: ChangeNotifierProvider(
                                        create: (_) => ManagerTeamProvider(),
                                        child: FliterBottomSheet(),
                                      )).then((value) => {
                                        _managerTeamProvider.pagee = 1,
                                        _managerTeamProvider.paginationLoder =
                                            false,
                                        _managerTeamProvider.setSelectedItem(
                                            value.valueItemSelected),
                                        _managerTeamProvider.setAccessRole(
                                            value.valueAccessRole),
                                        _managerTeamProvider
                                            .hitCompanyManageTeam(
                                          context,
                                        ),
                                      });
                                },
                              ),
                            )),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: CommanSearchBar(onTextChange: (val) {
                              _managerTeamProvider.search(val, 2);
                            })),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ManagerTeamTabber(
                        pos: 0,
                        title: 'Manage Team',
                        onTabHit: (val) {
                          _managerTeamProvider.resetCompanyMangeTeamList();
                          _managerTeamProvider.resetDropdownValue();
                          _managerTeamProvider.resetUserLeftCompanyList();
                          _managerTeamProvider.hitCompanyManageTeam(context);
                        },
                      ),
                      ManagerTeamTabber(
                        pos: 1,
                        title: 'Separated Employees',
                        onTabHit: (val) {
                          _managerTeamProvider.resetUserLeftCompanyList();
                          _managerTeamProvider.resetCompanyMangeTeamList();
                          _managerTeamProvider.resetDropdownValue();
                          _managerTeamProvider.hitUserLeftCompany(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  tabber == 0
                      ? ManageTeam(_managerTeamProvider)
                      : SeparatedEmployees(_managerTeamProvider),
                  Selector<ManagerTeamProvider, bool>(
                      selector: (_, provider) => provider.paginationLoder,
                      builder: (context, paginationLoading, child) {
                        return SizedBox(
                            height: 10,
                            child: PaginationWidget(paginationLoading));
                      }),
                  SizedBox(
                    height: 10,
                  )
                ],
              ));
        });
  }
}
