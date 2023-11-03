import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TripPlannerListModel.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/Dispatcher_Screen/Component/trip_cancel_alert_box.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/Dispatcher_Screen/Provider/Dispatcher_provider.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/Provider/TripPlannerProvider.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/TripPlannerScreen/ViewTripPlanner.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/UserLiveMap/user_route_map.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../commanWidget/Comman_Alert_box.dart';
import '../../AddStoppageMap/Provider/route_add_marker_provider.dart';
import '../../AddStoppageMap/company_add_stoppage_map.dart';
import '../../UserLiveMap/Provider/route_marker_list_provider.dart';

class DispatcherItem extends StatelessWidget {
  DispatcherProvider listProvider;
  int index;
  String type;

  DispatcherItem(this.listProvider, this.index, this.type);

  @override
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Container()),
                if (data.runningStatus == "UPCOMING")
                  data.isExpired == true
                      ? Container(
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
                                      child: Text(AppLocalizations.instance
                                          .text("Trip Detail")),
                                      value: 1,
                                    ),
                                  ]),
                        )
                      : Container(
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
                                    getAddStoppage(data, context);

                                    break;
                                  case 3:
                                    getTripDetails(data, context, data1);
                                    break;
                                  case 4:
                                    listProvider.hitReasonList();
                                    listProvider.restDrop();

                                    TripCancelAlertBox(
                                            context,
                                            "Are you sure you want to cancel this trip?",
                                            listProvider,
                                            data.driverId.toString(),
                                            data.id.toString(),
                                            "CANCELLED")
                                        .then((value) {
                                      data.runningStatus = "CANCELLED";
                                    });
                                    break;
                                  case 5:
                                    DialogUtils.showMyDialog(
                                      context,
                                      onDoneFunction: () async {
                                        data.hitReasonCancel(
                                            data.driverId.toString(),
                                            data.id.toString(),
                                            "ACTIVE",
                                            listProvider,
                                            index);
                                      },
                                      oncancelFunction: () =>
                                          Navigator.pop(context),
                                      title: 'Active',
                                      alertTitle: "Trip Active Message",
                                      btnText: "Done",
                                    );
                                    break;
                                }
                              },
                              itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: Text(AppLocalizations.instance
                                          .text("Track")),
                                      value: 1,
                                    ),
                                    PopupMenuItem(
                                      child: Text(AppLocalizations.instance
                                          .text("Add Stoppage")),
                                      value: 2,
                                    ),
                                    PopupMenuItem(
                                      child: Text(AppLocalizations.instance
                                          .text("Trip Detail")),
                                      value: 3,
                                    ),
                                    PopupMenuItem(
                                      child: Text(AppLocalizations.instance
                                          .text("Cancel")),
                                      value: 4,
                                    ),
                                    PopupMenuItem(
                                      child: Text(AppLocalizations.instance
                                          .text("Mark As Start")),
                                      value: 5,
                                    ),
                                  ]),
                        ),
                if (data.runningStatus == "CANCELLED" ||
                    data.runningStatus == 'EXPIRED')
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
                                child: Text(AppLocalizations.instance
                                    .text("Trip Detail")),
                                value: 1,
                              ),
                            ]),
                  ),
                if (data.runningStatus == "UNASSINGED")
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
                            case 2:
                              listProvider.hitReasonList();
                              listProvider.restDrop();
                              TripCancelAlertBox(
                                  context,
                                  "Are you sure you want to cancel this trip?",
                                  listProvider,
                                  data.driverId.toString(),
                                  data.id.toString(),
                                  "CANCELLED");

                              break;
                            case 3:
                              DialogUtils.showMyDialog(
                                context,
                                onDoneFunction: () async {
                                  Navigator.pop(context);
                                },
                                oncancelFunction: () => Navigator.pop(context),
                                title: 'Assign Driver',
                                alertTitle: "Assign Driver Message",
                                btnText: "Done",
                              );
                          }
                        },
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text(AppLocalizations.instance
                                    .text("Trip Detail")),
                                value: 1,
                              ),
                              PopupMenuItem(
                                child: Text(
                                    AppLocalizations.instance.text("Cancel")),
                                value: 2,
                              ),
                              PopupMenuItem(
                                child: Text("Assign Driver"),
                                value: 3,
                              ),
                            ]),
                  ),
                if (data.runningStatus == "COMPLETED")
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
                                child: Text(AppLocalizations.instance
                                    .text("Trip Detail")),
                                value: 1,
                              ),
                            ]),
                  ),
                if (data.runningStatus == "ACTIVE")
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
                              getAddStoppage(data, context);

                              break;
                            case 3:
                              getTripDetails(data, context, data1);
                              break;
                            case 4:
                              DialogUtils.showMyDialog(
                                context,
                                onDoneFunction: () async {
                                  data.hitReasonCancel(
                                      data.driverId.toString(),
                                      data.id.toString(),
                                      "COMPLETED",
                                      listProvider,
                                      index);
                                },
                                oncancelFunction: () => Navigator.pop(context),
                                title: 'Complete',
                                alertTitle: 'Trip Complete Message',
                                btnText: "Done",
                              );
                              break;
                          }
                        },
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text(
                                    AppLocalizations.instance.text("Track")),
                                value: 1,
                              ),
                              PopupMenuItem(
                                child: Text(AppLocalizations.instance
                                    .text("Add Stoppage")),
                                value: 2,
                              ),
                              PopupMenuItem(
                                child: Text(AppLocalizations.instance
                                    .text("Trip Detail")),
                                value: 3,
                              ),
                              PopupMenuItem(
                                child: Text(AppLocalizations.instance
                                    .text("Mark As Complete")),
                                value: 4,
                              ),
                            ]),
                  ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
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
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.destination!.length,
                    itemBuilder: (BuildContext context, int index) =>
                        Text("${data.destination![index].address.toString()}, ",
                            maxLines: 3,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                  ),
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
                      text: 'Driver\n',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold, height: 2),
                      children: <InlineSpan>[
                        TextSpan(
                          text: data.driverName == null
                              ? ' _ '
                              : data.driverName.toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        )
                      ])),
                ),
                Flexible(
                  child: Text.rich(TextSpan(
                      text: 'Load Number \n',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold, height: 2),
                      children: <InlineSpan>[
                        TextSpan(
                          text: data.loadNumber,
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
        decoration: BoxDecoration(
            color: data.isAnotherDriverLeft == true
                ? Colors.pink.shade50
                : data.isDriverLeft == true
                    ? Colors.grey.shade300
                    : APP_BG,
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

  getTripDetails(TripPlannerModel data, BuildContext context,
      TripPlannerListProvider data1) async {
    var getId = await getUserId();
    Future.delayed(Duration(microseconds: 100),
        () => data1.hitViewTripPlannerView(data.id.toString(), context));
    Navigator.push(
            context, MaterialPageRoute(builder: (context) => ViewTripPlanner()));
        /*.then((_) {
      listProvider.resetList();
      print(type);
      listProvider..hitTripList(type.toUpperCase(), "");
    });*/
  }

  getTripPlanner(TripPlannerModel data, BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (BuildContext context) => RouteMarkerListProvider(),
              child: ChangeNotifierProvider<TripPlannerModel>.value(
                  value: data, child: UserRouteMap(data, "DISPATCHER"))),
        ))/*.then((_) {
      listProvider.resetList();
      listProvider.hitTripList(type.toUpperCase(), "");
    })*/;
  }

  getAddStoppage(TripPlannerModel data, BuildContext context) async {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddStoppageMap(data)))
        /*.then((_) {
      listProvider.resetList();
      listProvider.hitTripList(type.toUpperCase(), "");
    })*/;
  }

  //
  getstatus(TripPlannerModel data, BuildContext context,
      TripPlannerListProvider data1, String? checkValue) {
    switch (checkValue) {
      case "ACTIVE":
        return Container(
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
                    getAddStoppage(data, context);

                    break;
                  case 3:
                    getTripDetails(data, context, data1);
                    break;
                  case 4:
                    listProvider.hitReasonList();
                    listProvider.restDrop();
                    TripCancelAlertBox(
                            context,
                            "Are you sure you want to cancel this trip?",
                            listProvider,
                            data.driverId.toString(),
                            data.id.toString(),
                            "ACTIVE")
                        .then((value) {
                      if (value) {
                        print(value);
                      }
                    });

                    break;
                }
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text(AppLocalizations.instance.text("Track")),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child:
                          Text(AppLocalizations.instance.text("Add Stoppage")),
                      value: 2,
                    ),
                    PopupMenuItem(
                      child:
                          Text(AppLocalizations.instance.text("Trip Detail")),
                      value: 3,
                    ),
                    PopupMenuItem(
                      child: Text(AppLocalizations.instance.text("Cancel")),
                      value: 4,
                    ),
                    PopupMenuItem(
                      child:
                          Text(AppLocalizations.instance.text("Mark As Start")),
                      value: 5,
                    ),
                  ]),
          decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xF8C6C4C4),
                  offset: Offset(5.0, 5.0),
                  blurRadius: 6,
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(.4),
                  offset: Offset(-5.0, -5.0),
                  blurRadius: 7,
                ),
              ]),
        );
        break;
    }
  }
}
