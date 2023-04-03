import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddTripPlannerScreen/AddTripPlanner.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddTripPlannerScreen/Provider/AddPlannerProvider.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddTripPlannerScreen/Provider/TripTabBarProvider.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddTripTabber/TripTabBar.dart';
import 'package:provider/provider.dart';

import '../../../commanWidget/Custom_App_Bar_Widget.dart';
import '../AddTruck.dart';
import 'Driverdetails.dart';
import 'TrailerTruck.dart';

class Trip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var  addTripPlannerProvider =context.read<AddTripPlannerProvider>();
    // return Scaffold(
    //   body: CustomAppBar(
    //     title: 'Add Trip',
    //     visual: false,
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //
    //           SingleChildScrollView(
    //             scrollDirection: Axis.horizontal,
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
    //               children: [
    //                 TripTabBar(
    //                   pos: 0,
    //                   title: 'Driver Details',
    //                 ),
    //                 TripTabBar(
    //                   pos: 1,
    //                   title: 'Truck details',
    //                 ),
    //                 TripTabBar(
    //                   pos: 2,
    //                   title: 'Trailer details',
    //                 ),
    //                 TripTabBar(
    //                   pos: 3,
    //                   title: 'Add Trip',
    //                 ),
    //               ],
    //             ),
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           Container(
    //             child: menuWidget(context),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    return CustomAppBarWidget(
      title: 'View Trip',
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

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TripTabBar(
                    pos: 0,
                    title: 'Driver Details',
                  ),
                  TripTabBar(
                    pos: 1,
                    title: 'Truck details',
                  ),
                  TripTabBar(
                    pos: 2,
                    title: 'Trailer details',
                  ),
                  TripTabBar(
                    pos: 3,
                    title: 'Add Trip',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: menuWidget(context),
            ),
          ],
        ),
      ),
    );
  }

  menuWidget(BuildContext context) {
    var model = context.read<TripTabBarProvider>();


    switch (Provider.of<TripTabBarProvider>(context, listen: true).menuClick) {
      case 0:

       return DriverDetails();

      case 1:
        return AddTruck();

      case 2:
        return AddTrailer();
      case 3:
        return AddTripPlanner();
    }
  }
}
