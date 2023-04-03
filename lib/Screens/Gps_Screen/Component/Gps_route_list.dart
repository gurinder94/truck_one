import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_truck_dot_one/Screens/Gps_Screen/provider/add_Trip_Provider.dart';
import 'package:provider/provider.dart';

class GpsRouteListWidget extends StatelessWidget {

late   AddTripProvider _provider;
  @override
  Widget build(BuildContext context) {
    _provider = context.read<AddTripProvider>();

    return Container(
        color: Colors.white,
        child: Consumer<AddTripProvider>(
          builder: (context, noti, child) => noti.getLoading
              ? Center(child: CircularProgressIndicator.adaptive())
              : ListView.builder(
            itemBuilder: (context, index) => Container(
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
                              '${((noti.model.routes![index].summary!.lengthInMeters)! * 0.000621).toStringAsFixed(2)} miles',
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
                              '${getDuration(Duration(seconds: noti.model.routes![index].summary!.travelTimeInSeconds!))}',
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
                               _provider.applyRoute(index);
                            },
                            child: Text('View')),
                        TextButton(
                            onPressed: () {
                              _provider.applyRoute(index);
                              _provider.openNavigation(index,context);
                            },
                            child: Text('Navigate')),
                        // roleName.toUpperCase()=="DRIVER"?     TextButton(
                        //     onPressed: () {
                        //       _provider.openNavigation(index,context);
                        //     }, child: Text('Navigate')):TextButton(
                        //     onPressed: () {
                        //       _provider.openNavigation(index,context);

                      ],
                    )
                  ],
                )),
            itemCount: noti.model.routes!.length,
          ),
        ));
  }
String getDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)} h $twoDigitMinutes m $twoDigitSeconds s";
}
}
