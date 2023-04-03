import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddTripPlannerScreen/Provider/AddPlannerProvider.dart';
import 'package:provider/src/provider.dart';

import 'DropDriverName.dart';
import 'DropOtherDriver.dart';
import 'OtherDriverdetails.dart';
import 'Single_Driver_Detail.dart';

class DriverDetails extends StatefulWidget {
  const DriverDetails({Key? key}) : super(key: key);

  @override
  _DriverDetailsState createState() => _DriverDetailsState();
}

class _DriverDetailsState extends State<DriverDetails> {
  late AddTripPlannerProvider addTripPlannerProvider;

  @override
  void initState() {
    // TODO: implement initState
    addTripPlannerProvider =
        Provider.of<AddTripPlannerProvider>(context, listen: false);
    addTripPlannerProvider.hitUserGetJobList(context);
    addTripPlannerProvider.hitGetOtherDriver();
  }

  Widget build(BuildContext context) {
    var model = context.watch<AddTripPlannerProvider>();
    return model.getLoading==true?CircularProgressIndicator():

    addTripPlannerProvider.driverListModel!.data!.length==0?CircularProgressIndicator(): Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropDriverName(),
          SizedBox(
            height: 20,
          ),
          DropOtherDriverName(),
          SizedBox(
            height: 20,
          ),

          model.ValueSelectDriver == null ? Container() : SingleDriveDetails(),
          model.ValueOtherSelectDriver == null
              ? Container()
              : OtherDriveDetails()
        ],
      ),
    );
  }
}
