import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/Provider/TripPlannerProvider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

import '../../../ActivityLogScreen/ActivityLog.dart';

class TripDetails extends StatelessWidget {
  @override
  var Size;
  late TripPlannerListProvider _listProvider;

  Widget build(BuildContext context) {
    Size = MediaQuery.of(context).size;

    _listProvider = context.watch<TripPlannerListProvider>();
    var formatter = new DateFormat('yyyy-MMM-dd');
    String dateToString =
        formatter.format(_listProvider.tripViewDetails!.data!.dateTime!);
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 35,
            child: Center(
              child: Text(
                AppLocalizations.instance.text("Trip Details",),
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
          TripDeatils("Source",
              _listProvider.tripViewDetails!.data!.source!.address.toString()),
          Divider(
            color: Colors.black38,
            height: 2,
          ),
          TripDeatils(
              "Destination",
              _listProvider.tripViewDetails!.data!.destination!.address
                  .toString()),
          Divider(
            color: Colors.black38,
            height: 2,
          ),
          TripDeatils(
              "Arrive Date",
              _listProvider.tripViewDetails!.data!.endDate == null
                  ? ''
                  : getCovert(_listProvider.tripViewDetails!.data!.endDate
                      .toString())),
          Divider(
            color: Colors.black38,
            height: 2,
          ),
          TripDeatils(
              "Depart Date",
              _listProvider.tripViewDetails!.data!.startDate == null
                  ? ''
                  : getCovert(
                      _listProvider.tripViewDetails!.data!.startDate.toString())),
          Divider(
            color: Colors.black38,
            height: 2,
          ),
          TripDeatils("Load Number",
              _listProvider.tripViewDetails!.data!.loadNumber.toString()),
          Divider(
            color: Colors.black38,
            height: 2,
          ),
          TripDeatils("Alternate Routes",
              _listProvider.tripViewDetails!.data!.alternateRoots.toString()),
          Divider(
            color: Colors.black38,
            height: 2,
          ),
          TripDeatils("Running Status",
              _listProvider.tripViewDetails!.data!.runningStatus.toString()),
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

              child: Text(AppLocalizations.instance.text(Heading)+" :",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600))),
          Spacer(),
          Container(
              width: Size.width * 0.40, child: Text(value,style: TextStyle(fontSize: 12),)),
        ],
      ),
    );
  }
}

getCovert(String value) {
  print(value);
  DateTime dt = DateTime.parse(value).toLocal();
  print(dt);
    String formattedDate = DateFormat('MMM-dd-yyyy , hh:mm:a').format(dt);

  return formattedDate;
}
