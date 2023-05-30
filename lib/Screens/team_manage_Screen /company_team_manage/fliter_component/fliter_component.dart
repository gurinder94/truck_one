import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/team_manage_Screen%20/company_team_manage/Provider/team_manger_provider.dart';
import 'package:provider/provider.dart';

import '../../../Language_Screen/application_localizations.dart';
import '../../../commanWidget/comman_drop.dart';
import '../../../commanWidget/input_shape.dart';
import 'drop_status.dart';
import 'drop_access_role.dart';

class FliterBottomSheet extends StatelessWidget {
  ManagerTeamProvider managerTeamProvider = ManagerTeamProvider();

  /*FliterBottomSheet(
    this.managerTeamProvider,
  );*/

  @override
  Widget build(BuildContext context) {
    return Consumer<ManagerTeamProvider>(builder: (context, notify, child) {
      return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 3,
            ),
            Text(
              AppLocalizations.instance.text('Status'),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 25,
            ),
            DropStatus(notify, onSelected: (val) {
              notify.setSelectedItem(val);
            }, answer: managerTeamProvider.valueItemSelected),
            SizedBox(
              height: 20,
            ),
            DropAccessRole(
              notify,
              onSelected: (val) {
                notify.setAccessRole(val);
              },
              answer: managerTeamProvider.valueAccessRole,
            ),
            SizedBox(
              height: 20,
            ),
            /*CommanDrop(
              title: "",
              onChangedFunction: (value) {
                notify.setData(value);
              },
              selectValue: notify.valueItemSelect,
              itemsList: notify.items
                  .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                        child: Center(child: Text(e)),
                        value: e,
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 20,
            ),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: GestureDetector(
                        child: Container(
                          height: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: APP_BAR_BG,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 3,
                                    offset: Offset(5, 5)),
                                BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 3,
                                    offset: Offset(-5, -5))
                              ]),
                          child: Text(
                            AppLocalizations.instance.text("Cancel"),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        })),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: GestureDetector(
                        child: Container(
                          height: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: APP_BAR_BG,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 3,
                                    offset: Offset(5, 5)),
                                BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 3,
                                    offset: Offset(-5, -5))
                              ]),
                          child: Text(
                            AppLocalizations.instance.text("Apply"),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                        onTap: () {
                          managerTeamProvider.paginationLoder = false;
                          Navigator.of(
                            navigatorKey.currentState!.context,
                          ).pop(notify);
                        })),
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      );
    });
  }
}
