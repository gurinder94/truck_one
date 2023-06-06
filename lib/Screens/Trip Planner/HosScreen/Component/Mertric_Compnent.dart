import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TripPlannerListModel.dart';

import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddStoppageMap/Provider/route_add_marker_provider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:provider/provider.dart';

import '../../../commanWidget/comman_button_widget.dart';
import '../HosList.dart';

class MetricComponent extends StatefulWidget {
  TripPlannerModel? data;
  int index;

  MetricComponent(this.data, this.index);

  @override
  _MetricComponentState createState() => _MetricComponentState(data, index);
}

class _MetricComponentState extends State<MetricComponent> {
  @override
  TripPlannerModel? data;
  int index;
  late RouteMarkerProvider provider;

  _MetricComponentState(this.data, this.index);

  TextEditingController sourceOrigin = TextEditingController();
  TextEditingController destinationOrigin = TextEditingController();

  void initState() {
    provider = Provider.of<RouteMarkerProvider>(context, listen: false);
    sourceOrigin.text = data!.source!.address.toString();
    destinationOrigin.text = data!.destination![0].address.toString();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        InputTextField(
          child: TextFormField(
            enabled: false,
            controller: sourceOrigin,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter Origin Location Source',
              contentPadding: EdgeInsets.all(15),
              prefixIcon: Icon(Icons.location_on),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter origin location';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          height: 30,
        ),
        InputTextField(
          child: TextFormField(
            enabled: false,
            controller: destinationOrigin,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter Origin Location Destination',
              contentPadding: EdgeInsets.all(15),
              prefixIcon: Icon(Icons.location_on),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter origin location';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          width: 350,
          height: 40,
          child: Center(
              child: Text(
            "Route Details : ${provider.calculateDistanceKm[index]} Km" +
                " " +
                '(${provider.calculateTime[index]})',
            style: TextStyle(color: Colors.white),
          )),
          decoration: BoxDecoration(
              color: PrimaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
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
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          child: Container(
            width: 350,
            height: 40,
            child: Center(
                child: Text(
              "Hours of Service",
              style: TextStyle(color: Colors.white),
            )),
            decoration: BoxDecoration(
                color: PrimaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
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
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HosList(data!, index,'104')));
          },
        ),
      ],
    );
  }
}
