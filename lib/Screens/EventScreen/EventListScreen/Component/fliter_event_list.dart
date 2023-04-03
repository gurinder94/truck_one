import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/EventListScreen/Provider/EventListProvider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_drop.dart';
import 'package:provider/provider.dart';

class FliterEvent extends StatelessWidget {
  EventListProvider eventListProvider;
  String taberName;
   FliterEvent(this.eventListProvider, this.taberName);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: APP_BG,
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
                       var  getId = await getUserId();
                        var roleName = await getRoleInfo();

                        eventListProvider.hitGetEvents(context, taberName, getId, 1, roleName,'',eventListProvider.valueSelectedActive,eventListProvider.valueSelectedarchive );
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
    );
  }
}

class Active extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<EventListProvider>(
      builder: (context, notify, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CommanDrop(
            title: "",
            onChangedFunction: (String newValue) {
              notify.setSelectedActive(newValue);
            },
            selectValue: notify.valueSelectedActive,
            itemsList: notify.Active.map<DropdownMenuItem<String>>(
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
    return Consumer<EventListProvider>(
      builder: (context, notify, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CommanDrop(
            title: "",
            onChangedFunction: (String newValue) {
              notify.setSelectedarchive(newValue);
            },
            selectValue: notify.valueSelectedarchive,
            itemsList: notify.archive.map<DropdownMenuItem<String>>(
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