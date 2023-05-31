import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TripPlannerListModel.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/Provider/TripPlannerProvider.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/TripPlannerScreen/ViewTripPlanner.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/UserLiveMap/user_route_map.dart';
import 'package:provider/provider.dart';

import '../../../commanWidget/Comman_Alert_box.dart';

class DriverTripItem extends StatelessWidget {
  TripPlannerListProvider proData;

  DriverTripItem(this.proData);

  Widget build(BuildContext context) {
    var data = context.watch<TripPlannerModel>();
    var data1 = context.watch<TripPlannerListProvider>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(child: Container()),
              if (data.runningStatus.toString().toUpperCase() == "UPCOMING")
                Container(
                  width: 30,
                  height: 30,
                  child: PopupMenuButton(
                      elevation: 10,
                      enabled: true,
                      child: Center(
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                      onSelected: (value) {
                        switch (value) {
                          case 1:
                            getTripPlanner(data, context);
                            break;
                          case 2:
                            getTripDetails(data, context, data1);
                            break;
                          case 3:
                            DialogUtils.showMyDialog(
                              context,
                              onDoneFunction: () async {
                                data.hitTripStatusDriver(
                                  data.driverId.toString(),
                                  data.id.toString(),
                                  "ACTIVE",
                                );
                              },
                              oncancelFunction: () => Navigator.pop(context),
                              title: 'Active',
                              alertTitle: "Trip Active Message",
                              btnText: "Done",
                            );
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text("Navigate"),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text(AppLocalizations.instance
                              .text("Trip Detail")),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text("Mark As Start"),
                          value: 3,
                        ),
                      ]),
                ),
              if (data.runningStatus.toString().toUpperCase() == "CANCELLED" ||
                  data.runningStatus.toString().toUpperCase() == "EXPIRED")
                Container(
                  width: 30,
                  height: 30,
                  child: PopupMenuButton(
                      elevation: 10,
                      enabled: true,
                      child: Center(
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                      onSelected: (value) {
                        switch (value) {
                          case 1:
                            getTripDetails(data, context, data1);
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text("Trip Detail"),
                          value: 1,
                        ),
                      ]),
                ),
              if (data.runningStatus.toString().toUpperCase() == "COMPLETED")
                Container(
                  width: 30,
                  height: 30,
                  child: PopupMenuButton(
                      elevation: 10,
                      enabled: true,
                      child: Center(
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                      onSelected: (value) {
                        switch (value) {
                          case 1:
                            getTripDetails(data, context, data1);
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text("Trip Detail"),
                          value: 1,
                        ),
                      ]),
                ),
              if (data.runningStatus.toString().toUpperCase() == "ACTIVE")
                Container(
                  width: 30,
                  height: 30,
                  child: PopupMenuButton(
                      elevation: 10,
                      enabled: true,
                      child: Center(
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                      onSelected: (value) {
                        switch (value) {
                          case 1:
                            getTripPlanner(data, context);
                            break;
                          case 2:
                            getTripDetails(data, context, data1);
                            break;
                          case 3:
                            DialogUtils.showMyDialog(
                              context,
                              onDoneFunction: () async {
                                data.hitTripStatusDriver(
                                  data.driverId.toString(),
                                  data.id.toString(),
                                  "COMPLETED",
                                );
                              },
                              oncancelFunction: () => Navigator.pop(context),
                              title: 'Complete',
                              alertTitle: "Trip Complete Message",
                              btnText: "Done",
                            );
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text("Track"),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text("Trip Detail"),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text("Mark As Complete"),
                          value: 3,
                        ),
                      ]),
                ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    data.source!.address.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: [
                    Icon((FontAwesomeIcons.truck)),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 2,
                      color: Colors.black,
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(data.destination!.address.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text.rich(TextSpan(
                      text: 'Running Status \n',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1.5),
                      children: <InlineSpan>[
                        TextSpan(
                          text: data.runningStatus.toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        )
                      ])),
                ),
                Flexible(
                  child: Text.rich(TextSpan(
                      text: 'Load Number \n',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1.5),
                      children: <InlineSpan>[
                        TextSpan(
                          text: data.loadNumber.toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        )
                      ])),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        decoration: const BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 4, offset: Offset(5, 5)),
              BoxShadow(
                  color: Colors.white, blurRadius: 4, offset: Offset(-5, -5))
            ]),
      ),
    );
  }

  Widget myPopMenu(
      TripPlannerModel data, TripPlannerListProvider data1, BuildContext con) {
    return PopupMenuButton(
        onSelected: (value) {},
        itemBuilder: (context) => [
          PopupMenuItem(
              value: 1,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                      child: Text('Live Track'),
                      onTap: () {
                        Navigator.pop(context);
                        getTripPlanner(data, context);
                      })
                ],
              )),
          PopupMenuItem(
              value: 3,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: Text('Trip Details'),
                    onTap: () {
                      Navigator.pop(context);
                      getTripDetails(data, context, data1);
                    },
                  )
                ],
              )),
        ]);
  }

  getTripDetails(TripPlannerModel data, BuildContext context,
      TripPlannerListProvider data1) async {
    var getId = await getUserId();
    Future.delayed(Duration(microseconds: 100),
            () => data1.hitViewTripPlannerView(data.id.toString(), context));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ViewTripPlanner()));
  }

  getTripPlanner(TripPlannerModel data, BuildContext context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UserRouteMap(data, "DRIVER")));
  }
}
