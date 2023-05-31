import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/Provider/TripPlannerProvider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

class TruckDetails extends StatelessWidget {
  var Size;
  late TripPlannerListProvider _listProvider;

  Widget build(BuildContext context) {
    Size = MediaQuery.of(context).size;
    _listProvider =
        Provider.of<TripPlannerListProvider>(context, listen: false);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 35,
            child: Center(
              child: Text(
                AppLocalizations.instance.text(
                  "Truck Details",
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
          TripDeatils("Nick Name",
              _listProvider.tripViewDetails!.data!.truckData!.name.toString()),
          Divider(
            color: Colors.black38,
            height: 2,
          ),
          TripDeatils(
              "Height",
              _listProvider.tripViewDetails!.data!.truckData!.height
                      .toString() +
                  ' ' +
                  'in'),
          Divider(
            color: Colors.black38,
            height: 2,
          ),
          TripDeatils(
              "Power",
              _listProvider.tripViewDetails!.data!.truckData!.power.toString() +
                  ' ' +
                  'hp'),
          Divider(
            color: Colors.black38,
            height: 2,
          ),
          TripDeatils(
              "VIN",
              _listProvider.tripViewDetails!.data!.truckData!.number
                  .toString()),
          Divider(
            color: Colors.black38,
            height: 2,
          ),
          TripDeatils(
              "Weight",
              _listProvider.tripViewDetails!.data!.truckData!.weight
                      .toString() +
                  ' ' +
                  'lbs'),
          Divider(
            color: Colors.black38,
            height: 2,
          ),
          TripDeatils(
              "Brand",
              _listProvider.tripViewDetails!.data!.truckData!.brand == null
                  ? "Others"
                  : _listProvider.tripViewDetails!.data!.truckData!.brand!
                      .toString()),
          Divider(
            color: Colors.black38,
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: Size.width * 0.40,
                    child: Text("Other Brand" + " :",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600))),
                Spacer(),
                Container(
                    width: Size.width * 0.40,
                    child: Text(
                      _listProvider.tripViewDetails!.data!.truckData!
                                  .otherbrand ==
                              null
                          ? ""
                          : _listProvider
                              .tripViewDetails!.data!.truckData!.otherbrand!
                              .toString(),
                      style: TextStyle(fontSize: 12),
                    )),
              ],
            ),
          ),
          Divider(
            color: Colors.black38,
            height: 2,
          ),
          TripDeatils(
              "Width",
              _listProvider.tripViewDetails!.data!.truckData!.width.toString() +
                  ' ' +
                  'in'),
          Divider(
            color: Colors.black38,
            height: 2,
          ),
          TripDeatils(
              "Model Number",
              _listProvider.tripViewDetails!.data!.truckData!.modelNumber
                  .toString()),
          Divider(
            color: Colors.black38,
            height: 2,
          ),
          TripDeatils(
              "Engine Number",
              _listProvider.tripViewDetails!.data!.truckData!.engine
                  .toString()),
          Divider(
            color: Colors.black38,
            height: 2,
          ),
          TripDeatils(
              "WheelBase",
              _listProvider.tripViewDetails!.data!.truckData!.wheelbase
                      .toString() +
                  ' ' +
                  'in'),
          Divider(
            color: Colors.black38,
            height: 2,
          ),
          TripDeatils(
              "Fuel Capacity",
              _listProvider.tripViewDetails!.data!.truckData!.fuelCapacity
                      .toString() +
                  ' ' +
                  'gl'),
          Divider(
            color: Colors.black38,
            height: 2,
          ),
          TripDeatils(
              "Number of Tyres",
              _listProvider.tripViewDetails!.data!.truckData!.numOfTyres
                      .toString() +
                  ' ' +
                  'in'),
          Divider(
            color: Colors.black38,
            height: 2,
          ),
          TripDeatils(
              "Fuel Type",
              _listProvider.tripViewDetails!.data!.truckData!.fuelType
                  .toString()),
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
