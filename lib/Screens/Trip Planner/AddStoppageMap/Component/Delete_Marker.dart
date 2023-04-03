import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/GetServiceMarker.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddStoppageMap/Provider/route_add_marker_provider.dart';


class DeleteMarker extends StatelessWidget {
  List<Datum> data;
  int  no;
  String ?tripId;
  String ? markerId;
  late RouteMarkerProvider _routeMarkerProvider;
   DeleteMarker(this. data, this.no, this._routeMarkerProvider, this.markerId);

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
        title: const Text('Remove Marker'),
    content: SingleChildScrollView(
    child: ListBody(
    children: const <Widget>[
    Text('Do you want to remove the stoppage?'),

    ],

    ),

    ),
      actions: <Widget>[
        TextButton(
          child: const Text('Yes'),
          onPressed: () {

            _routeMarkerProvider.RemoveMarker(data,_routeMarkerProvider,markerId );
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('No'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );


  }
}
