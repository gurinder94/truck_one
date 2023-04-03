import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TripPlannerListModel.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddStoppageMap/Provider/route_add_marker_provider.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/HosScreen/Component/Hos_Tabber.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customapp.dart';
import 'package:provider/src/provider.dart';
import 'Component/Imperial_Component.dart';
import 'Component/Mertric_Compnent.dart';
import 'Provider/HosMapProvider.dart';

class HosMap extends StatelessWidget {
  TripPlannerModel?data;
 late  RouteMarkerProvider provider;
  int index;
  HosMap(this.data, this. index, );


  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: CustomAppBar(
        title: AppLocalizations.instance.text("H.O.S"),
        visual: false,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 110,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HosTabBar(
                        pos: 0,
                        title: 'Metric',
                      ),
                      HosTabBar(
                        pos: 1,
                        title: 'Imperial',
                      ),
                    ],
                  ),

                  Container(
                    child: menuWidget(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  menuWidget(BuildContext context) {
    var model = context.watch<HosMapProvider>();

    print(model.menuClick);
    switch (model.menuClick) {


       case 0:
         return MetricComponent(data,index);
      case 1:
        return

          ImperialHos(data,index);
    }
  }
}
