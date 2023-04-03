import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Fleet_Manager_Screen/Provider/fleet_manager_provider.dart';
import 'package:my_truck_dot_one/Screens/Fleet_Manager_Screen/fliter_screen/drop_archived.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

import 'drop_active.dart';

class Fliter extends StatelessWidget {
  late FleetManagerProvider fleetManagerProvider;

  Fliter(this.fleetManagerProvider);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Text(
            AppLocalizations.instance.text('Status'),
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 20,
          ),
          ChangeNotifierProvider(
            create: (_) => FleetManagerProvider(),
            child: Consumer<FleetManagerProvider>(
    builder: (context, notify, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child:
        IsActiveDrop(
          onSelectValue: (value) {

            fleetManagerProvider.setSelectedItem(value);

          },
          notify: notify, fleetManagerProvider: fleetManagerProvider,
        ),
      );
    }
            )
          ),
          SizedBox(
            height: 20,
          ),
          ChangeNotifierProvider(
            create: (_) => FleetManagerProvider(),
            child:  Consumer<FleetManagerProvider>(
    builder: (context, notify, child) {
      return
        Isarchived(
          onSelectValue: (val) {
            fleetManagerProvider.setSelectedValue(val);
          },
          notify: notify, fleetManagerProvider: fleetManagerProvider,
        );
    }
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: Center(
                        child: Text(
                      AppLocalizations.instance.text('Cancel'),
                      style: TextStyle(color: APP_BG, fontSize: 18),
                    )),
                    decoration: BoxDecoration(
                        color: APP_BAR_BG,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
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
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: Center(
                        child: Text(
                      AppLocalizations.instance.text('Apply'),
                      style: TextStyle(color: APP_BG, fontSize: 18),
                    )),
                    decoration: BoxDecoration(
                        color: APP_BAR_BG,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
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
                  ),
                  onTap: () {
                    fleetManagerProvider.restList();
                    fleetManagerProvider.statusFliter(
                        fleetManagerProvider.valueItemSelected,
                        fleetManagerProvider.valueItemSelected2);

                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
