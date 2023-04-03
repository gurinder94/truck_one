import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/Provider/TripPlannerProvider.dart';
import 'package:provider/provider.dart';

class TripPlannerList extends StatelessWidget {
  @override
  late TripPlannerListProvider _listProvider;

  Widget build(BuildContext context) {
    _listProvider =
        Provider.of<TripPlannerListProvider>(context, listen: false);
    return Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 45,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Location",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text("Destination", style: TextStyle(color: Colors.white)),
                  Text('Weight', style: TextStyle(color: Colors.white)),
                  Text("Action", style: TextStyle(color: Colors.white))
                ],
              ),
              decoration: BoxDecoration(
                color: PrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
        ]));
  }
  getEventList(BuildContext context, int page) async {
    var getId = await getUserId();
    var roleName=await getRoleInfo();


    _listProvider.hitGetTripPannerList(context );
  }
}

