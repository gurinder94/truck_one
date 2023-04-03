

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TripPlannerListModel.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddStoppageMap/Provider/route_add_marker_provider.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/HosScreen/HosMap.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

import 'direction_route.dart';

class AddStoppageRouteList extends StatelessWidget {

  late RouteMarkerProvider _provider;
  TripPlannerModel data;

  AddStoppageRouteList( this.data);

  @override
  Widget build(BuildContext context) {
    _provider = context.read<RouteMarkerProvider>();
    return Container(
        color: Colors.white,
        child: Consumer<RouteMarkerProvider>(
          builder: (context, noti, child) =>
          noti.loading
              ? Center(child: CircularProgressIndicator.adaptive())
              : ListView.builder(
            itemBuilder: (context, index) =>
                Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 10),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Column(
                      children: [
                        Text(
                          'Route Details',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.truck,
                                  color: Colors.black45,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${((noti.routeModel.routes![index].summary!
                                      .lengthInMeters)! * 0.000621)
                                      .toStringAsFixed(2)} miles',
                                  style: TextStyle(color: Colors.black45),
                                ),
                              ],
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Icon(
                                  Icons.alarm,
                                  color: Colors.black45,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${getDuration(Duration(
                                      seconds: noti.routeModel.routes![index]
                                          .summary!.travelTimeInSeconds!))}',
                                  style: TextStyle(color: Colors.black45),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                                onPressed: () {
                                  _provider.applyRoute(index,context,_provider);
                                },
                                child: Text(AppLocalizations.instance.text('Add Stoppage'))),
                            TextButton(
                                onPressed: () {
                                  print(index);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => Direction(index,_provider)));
                                }, child: Text(AppLocalizations.instance.text('Direction'))),

                            TextButton(
                                onPressed: () {

                                  print(index);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          HosMap(data,index)
                                         ));
                                }, child: Text(AppLocalizations.instance.text('H.O.S')))
                          ],
                        )
                      ],
                    )),
            itemCount: noti.routeModel.routes!.length,
          ),
        ));
  }

  String getDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(
        duration.inHours)} h $twoDigitMinutes m $twoDigitSeconds s";
  }
}
