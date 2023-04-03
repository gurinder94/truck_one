import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../AppUtils/UserInfo.dart';
import '../../../../../AppUtils/constants.dart';
import '../../../../commanWidget/comman_drop.dart';
import '../Provider/JobListProvider.dart';

class FliterJob extends StatelessWidget {
  JobListProvider jobListProvider;
   FliterJob(this.jobListProvider, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: APP_BG,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.instance.text("Status"),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 20,
            ),
            Active(),
            SizedBox(
              height: 10,
            ),
            UnArchive(),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Flexible(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width / 2,
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
                        onTap: () async {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width / 2,
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
                            AppLocalizations.instance.text("Submit"),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                        onTap: () async {
                                    getJobList(
                                        context,
                                        jobListProvider.activeType.toString(),
                                        jobListProvider.valueSelected.toString());
                                    Navigator.pop(context);

                        },
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  getJobList(BuildContext context, String filter1, String filter2) async {
    var  getId = await getUserId();
    var roleName = await getRoleInfo();

    jobListProvider.hitGetJobList(context, getId, roleName);
  }
}

class Active extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobListProvider>(
      builder: (context, notify, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CommanDrop(
            title: "",
            onChangedFunction: (String newValue) {
              notify.setSelectedItem(newValue);
            },
            selectValue: notify.activeType,
            itemsList: notify.items.map<DropdownMenuItem<String>>(
                  (final String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Center(child: Text(value)),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}

class UnArchive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobListProvider>(
      builder: (context, notify, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CommanDrop(
            title: "",
            onChangedFunction: (String newValue) {
              notify.setArchivedItem(newValue);
            },
            selectValue: notify.valueSelected,
            itemsList: notify.items2.map<DropdownMenuItem<String>>(
                  (final String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Center(child: Text(value)),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }

}