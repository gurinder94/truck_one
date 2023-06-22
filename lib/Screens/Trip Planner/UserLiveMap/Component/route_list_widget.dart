import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/UserLiveMap/Provider/route_marker_list_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

class RouteListWidget extends StatelessWidget {
  late RouteMarkerListProvider _provider;
  String roleName;

  RouteListWidget(this.roleName);

  @override
  Widget build(BuildContext context) {
    _provider = context.read<RouteMarkerListProvider>();
    return Container(
        color: Colors.grey.shade100,
        child: Consumer<RouteMarkerListProvider>(
          builder: (context, noti, child) => noti.loading
              ? Center(child: CircularProgressIndicator.adaptive())
              : noti.routeModel.routes == null
                  ? SizedBox()
                  : ListView.builder(
                      itemCount: noti.routeModel.routes!.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(2, 2),
                                      blurRadius: 2,
                                      color: Colors.black12),
                                  BoxShadow(
                                      offset: Offset(-2, -2),
                                      blurRadius: 2,
                                      color: Colors.black12)
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
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
                                          '${((noti.routeModel.routes![index].summary!.lengthInMeters)! * 0.000621).toStringAsFixed(2)} miles',
                                          style:
                                              TextStyle(color: Colors.black45),
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
                                          '${getDuration(Duration(seconds: noti.routeModel.routes![index].summary!.travelTimeInSeconds!))}',
                                          style:
                                              TextStyle(color: Colors.black45),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          _provider.applyRoute(index);
                                        },
                                        child: Text(AppLocalizations.instance
                                            .text("View"))),
                                    roleName.toUpperCase() == "DRIVER"
                                        ? TextButton(
                                            onPressed: () {
                                              _provider.openNavigation(
                                                  index, context);
                                            },
                                            child: Text(AppLocalizations
                                                .instance
                                                .text("Navigate")))
                                        : TextButton(
                                            onPressed: () {
                                              _provider.openNavigation(
                                                  index, context);
                                            },
                                            child: Text(AppLocalizations
                                                .instance
                                                .text("Tracking")))
                                  ],
                                )
                              ],
                            ));
                      }),
        ));
  }

  String getDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)} h $twoDigitMinutes m $twoDigitSeconds s";
  }
}
