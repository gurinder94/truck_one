import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/Provider/TripPlannerProvider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customLoder.dart';
import 'package:provider/provider.dart';

import '../../commanWidget/Custom_App_Bar_Widget.dart';
import 'Compoment/DriverDetails.dart';
import 'Compoment/TeamDetails.dart';
import 'Compoment/Trailerdetails.dart';
import 'Compoment/TripDetails.dart';
import 'Compoment/TripPlannerTabBar.dart';
import 'Compoment/TruckDetails.dart';
import 'Provider/TripPlannerTabbar.dart';

class ViewTripPlanner extends StatelessWidget {
  @override
  late TripPlannerListProvider _listProvider;

  Widget build(BuildContext context) {
    _listProvider = context.watch<TripPlannerListProvider>();
    return CustomAppBarWidget(
      title:AppLocalizations.instance.text('View Trip'),
      floatingActionWidget: SizedBox(),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: SizedBox(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 95,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TripPlannerTabBar(
                      pos: 0,
                      title: "Trip Details",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TripPlannerTabBar(
                      pos: 1,
                      title: "Driver Details",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TripPlannerTabBar(
                      pos: 2,
                      title: "Truck Details",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TripPlannerTabBar(
                      pos: 3,
                      title: "Trailer Details",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TripPlannerTabBar(
                      pos: 4,
                      title: "Another Driver ",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: menuWidget(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  menuWidget(BuildContext context) {
    switch (
        Provider.of<TripPlannerTabProvider>(context, listen: true).menuClick) {
      case 0:
        return _listProvider.loading == true
            ? Center(child: CustomLoder())
            : TripDetails();
      case 1:
        return _listProvider.loading == true
            ? Center(child: CustomLoder())
            : DriverDetails();
      case 2:
        return _listProvider.loading == true
            ? Center(child: CustomLoder())
            : TruckDetails();
      case 3:
        return _listProvider.loading == true
            ? Center(child: CustomLoder())
            : TrailerDetails();
      case 4:
        return _listProvider.loading == true
            ? Center(child: CustomLoder())
            : TeamDetails();
    }
  }
}
