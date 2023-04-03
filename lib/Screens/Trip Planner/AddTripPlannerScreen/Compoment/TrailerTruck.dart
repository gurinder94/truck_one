import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddTripPlannerScreen/Provider/AddPlannerProvider.dart';
import 'package:provider/provider.dart';

import 'DropTrailerName.dart';

class AddTrailer extends StatefulWidget {
  @override
  _AddTrailerState createState() => _AddTrailerState();
}

class _AddTrailerState extends State<AddTrailer> {
  late AddTripPlannerProvider addTripPlannerProvider;

  void initState() {
    // TODO: implement initState
    addTripPlannerProvider =
        Provider.of<AddTripPlannerProvider>(context, listen: false);
    addTripPlannerProvider.hitGetTrailer(context);
  }

  @override
  Widget build(BuildContext context) {
    var model = context.watch<AddTripPlannerProvider>();
    return model.getLoading==true?CircularProgressIndicator():Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          DropTrailer(),
          SizedBox(
            height: 20,
          ),

          model.valueTrailerName == null ? Container() : buildName(model,context)
          // truckInformation(
          //         "Brand Name",
          //         model.truckDetailModel!.data!.brand!.name.toString(),
        ]));
  }
}

buildName(AddTripPlannerProvider model, BuildContext context
    ) {
  return model.isLoading==true?Center(child: CircularProgressIndicator()):Container(
    child: Column(
      children: [
        SizedBox(height: 10,),
        heading(
          context,
          "Trailer Information",
        ),
        SizedBox(
          height: 8,
        ),
        truckInformation(
          "Trailer Type",
          model.trailerDetailModel!.data!.trailerType.toString(),
        ),
        Divider(
          color: Colors.black.withOpacity(0.4),
        ),
        truckInformation(
          "Height",
          model.trailerDetailModel!.data!.height.toString() + " " + "m",
        ),
        Divider(
          color: Colors.black.withOpacity(0.4),
        ),
        truckInformation(
          "Width",
          model.trailerDetailModel!.data!.width.toString() + " " + "m",
        ),
        Divider(
          color: Colors.black.withOpacity(0.4),
        ),
        truckInformation(
          "Weight",
          model.trailerDetailModel!.data!.width.toString() + " " + "lb",
        ),
        Divider(
          color: Colors.black.withOpacity(0.4),
        ),
        truckInformation(
          "Load Capacity",
          model.truckDetailModel!.data!.fuelCapacity.toString() + " " + "ltr",
        ),
        Divider(
          color: Colors.black.withOpacity(0.4),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}

heading(
  BuildContext context,
  String title,
) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 35,
    child: Center(
        child: Text(
      title,
      style: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
    )),
    decoration: BoxDecoration(
      color: PrimaryColor,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

truckInformation(
  String s,
  String value,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
          width: 150,
          child: Text(
            s,
            style: TextStyle(fontSize: 18),
          )),
      SizedBox(
        height: 30,
      ),
      Container(
          width: 200,
          child: Text(
            value,
            style: TextStyle(fontSize: 17),
          )),
      SizedBox(
        height: 30,
      ),
    ],
  );
}
