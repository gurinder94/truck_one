import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/Provider/TripPlannerProvider.dart';
import 'package:provider/provider.dart';

import '../../../Language_Screen/application_localizations.dart';

class TrailerDetails extends StatelessWidget {
  @override
  var Size;
  late TripPlannerListProvider _listProvider;

  Widget build(BuildContext context) {
    Size = MediaQuery.of(context).size;
    _listProvider =
        Provider.of<TripPlannerListProvider>(context, listen: false);
    return Container(
      child: _listProvider.tripViewDetails!.data!.trailerData == null
          ? Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 35,
                  child: Center(
                    child: Text(
                      "Trailer Details",
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
                Text(AppLocalizations.instance.text('No Record Found')),
                SizedBox(
                  height: 10,
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
                    child: Text(
                      AppLocalizations.instance.text(
                        "Trailer Details",
                      ),
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
                    "Nick Name",
                    _listProvider.tripViewDetails!.data!.trailerData!.name
                        .toString()),
                Divider(
                  color: Colors.black38,
                  height: 2,
                ),
                TripDeatils(
                    "Trailer Type",
                    _listProvider
                        .tripViewDetails!.data!.trailerData!.trailerType
                        .toString()),
                Divider(
                  color: Colors.black38,
                  height: 2,
                ),
                TripDeatils(
                    "Height",
                    _listProvider.tripViewDetails!.data!.trailerData!.height
                            .toString() +
                        ' ' +
                        "in"),
                Divider(
                  color: Colors.black38,
                  height: 2,
                ),
                TripDeatils(
                    "Weight",
                    _listProvider.tripViewDetails!.data!.trailerData!.weight
                            .toString() +
                        ' ' +
                        "lbs"),
                Divider(
                  color: Colors.black38,
                  height: 2,
                ),
                TripDeatils(
                    "Width",
                    _listProvider.tripViewDetails!.data!.trailerData!.width
                            .toString() +
                        ' ' +
                        "in"),
                Divider(
                  color: Colors.black38,
                  height: 2,
                ),
                TripDeatils(
                    "Load Capacity",
                    _listProvider
                            .tripViewDetails!.data!.trailerData!.loadCapacity
                            .toString() +
                        ' ' +
                        "lbs"),
                Divider(
                  color: Colors.black38,
                  height: 2,
                ),
                SizedBox(
                  height: 20,
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
              child: Text(AppLocalizations.instance.text(Heading) + " :",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
          Spacer(),
          Container(
              width: Size.width * 0.40,
              child: Text(
                value,
                style: TextStyle(fontSize: 12),
              )),
        ],
      ),
    );
  }
}
