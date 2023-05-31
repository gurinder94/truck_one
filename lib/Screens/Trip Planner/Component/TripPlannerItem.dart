import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TripPlannerListModel.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddStoppageMap/company_add_stoppage_map.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/Provider/TripPlannerProvider.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/TripPlannerScreen/ViewTripPlanner.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/UserLiveMap/Provider/route_marker_list_provider.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/UserLiveMap/user_route_map.dart';
import 'package:provider/provider.dart';

import '../AddStoppageMap/Provider/route_add_marker_provider.dart';

class TripItem extends StatelessWidget {
  @override
  var Size;

  Widget build(BuildContext context) {
    var data = context.watch<TripPlannerModel>();
    var data1 = context.watch<TripPlannerListProvider>();
    var Size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.all(4.0),
                width: Size.width * 0.25,
                child: Center(child: Text(data.source!.address.toString())),
              ),
              Container(
                padding: EdgeInsets.all(4.0),
                width: Size.width * 0.25,
                child:
                Center(child: Text(data.destination!.address.toString())),
              ),
              Container(
                padding: EdgeInsets.all(4.0),
                width: Size.width * 0.20,
                child: Center(child: Text(data.weight.toString())),
              ),
              Container(
                width: Size.width * 0.20,
                child: GestureDetector(
                  child: myPopMenu(data, data1, context),
                  onTap: () {
                    myPopMenu(data, data1, context);
                  },
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFD9D8D8),
                offset: Offset(5.0, 5.0),
                blurRadius: 7,
              ),
              BoxShadow(
                color: Colors.white.withOpacity(.4),
                offset: Offset(-5.0, -5.0),
                blurRadius: 10,
              ),
            ]),
      ),
    );
  }

  Widget myPopMenu(TripPlannerModel data, TripPlannerListProvider data1,
      BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) {
          switch (value) {
            case 1:
              getTripPlanner(data, context);
              break;
            case 2:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>ChangeNotifierProvider(
                  create: (BuildContext context) => RouteMarkerProvider(),
                  child: ChangeNotifierProvider<TripPlannerModel>.value(
                      value: data, child: AddStoppageMap(data)))));
              break;
            case 3:
              getTripDetails(data, context, data1);
              break;
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
              value: 1,
              child: Row(
                children: <Widget>[Text('Live Track')],
              )),
          PopupMenuItem(
              value: 2,
              child: Row(
                children: <Widget>[Text('Add Stopage')],
              )),
          PopupMenuItem(
              value: 3,
              child: Row(
                children: <Widget>[Text('Trip Details')],
              )),
        ]);
  }

  getTripDetails(TripPlannerModel data, BuildContext context,
      TripPlannerListProvider data1) async {
    var getId = await getUserId();
    data1.hitViewTripPlannerView(data.id.toString(), context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ViewTripPlanner()));
  }

  getTripPlanner(TripPlannerModel data, BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (BuildContext context) => RouteMarkerListProvider(),
              child: ChangeNotifierProvider<TripPlannerModel>.value(
                  value: data, child: UserRouteMap(data, "DISPATCHER"))),
        ));
  }
}
