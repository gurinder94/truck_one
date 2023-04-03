import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/Provider/TripPlannerProvider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

class DriverDetails extends StatelessWidget {
  var Size;
  late TripPlannerListProvider _listProvider;

  Widget build(BuildContext context) {
    Size = MediaQuery.of(context).size;
    _listProvider =
        Provider.of<TripPlannerListProvider>(context, listen: false);
    return Container(
      child: _listProvider.tripViewDetails!.data!.driverData == null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 35,
                  child: Center(
                    child: Text(
                      AppLocalizations.instance.text("Driver Details"),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: PrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(AppLocalizations.instance.text("No Record Found")),
                SizedBox(
                  height: 20,
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 35,
                  child: Center(
                    child:
                      Text(AppLocalizations.instance.text("Driver Details"),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: PrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TripDeatils(
                    "Name",
                    _listProvider.tripViewDetails!.data!.driverData!.personName
                        .toString()),

                Divider(
                  color: Colors.black38,
                  height: 2,
                ),
                // TripDeatils("Address:", _listProvider.tripViewDetails!.data!.driverData!.address.toString()),
                // Divider(color: Colors.black38,height:2,),
                TripDeatils(
                    "Phone Number",
                    _listProvider
                        .tripViewDetails!.data!.driverData!.mobileNumber
                        .toString()),
                Divider(
                  color: Colors.black38,
                  height: 2,
                ),
                TripDeatils(
                    "Email",
                    _listProvider.tripViewDetails!.data!.driverData!.email
                        .toString()),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
      decoration: BoxDecoration(color: Color(0xFFEEEEEE), boxShadow: [
        BoxShadow(
          color: Color(0xFFD9D8D8),
          offset: Offset(5.0, 5.0),
          blurRadius: 7,
        ),
        BoxShadow(
          color: Colors.white.withOpacity(.5),
          offset: Offset(-5.0, -5.0),
          blurRadius: 7,
        ),
      ]),
    );
  }

  TripDeatils(String Heading, String value) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              width: Size.width * 0.40,

              child: Text(AppLocalizations.instance.text(Heading)+" :",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600))),
          Spacer(),
          Container(
              width: Size.width * 0.40, child: Text(value,style: TextStyle(fontSize: 12),)),
        ],
      ),
    );
  }
}
