import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:provider/provider.dart';

import 'Compoment/DropTruckName.dart';
import 'Provider/AddPlannerProvider.dart';

class AddTruck extends StatefulWidget {
  const AddTruck({Key? key}) : super(key: key);

  @override
  _AddTruckState createState() => _AddTruckState();
}

class _AddTruckState extends State<AddTruck> {
  late AddTripPlannerProvider addTripPlannerProvider;

  void initState() {
    // TODO: implement initState
    addTripPlannerProvider =
        Provider.of<AddTripPlannerProvider>(context, listen: false);
    addTripPlannerProvider.hitGetTruck(context);
  }

  @override
  Widget build(BuildContext context) {
    var model = context.watch<AddTripPlannerProvider>();
    return model.getLoading==true?Center(child: CircularProgressIndicator()):Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          DropTruckName(),
          SizedBox(
            height: 20,
          ),


          model.valueTruckName == null ? Container() : buildName(model,context)
          // truckInformation(
          //         "Brand Name",
          //         model.truckDetailModel!.data!.brand!.name.toString(),
        ]));
  }
}

buildName(AddTripPlannerProvider model, BuildContext context) {
  return Container(
    child: model.isLoading==true?Center(child: CircularProgressIndicator()):Column(
      children: [
        SizedBox(height: 8,)
,        heading(
          context,
          "Truck Information",
        ),
        SizedBox(
          height: 8,
        ),
        truckInformation(
          "Brand Name",
          model.truckDetailModel!.data!.brand!.name.toString(),
        ),
        Divider(color: Colors.black.withOpacity(0.4),),
        truckInformation(
          "Name",
          model.truckDetailModel!.data!.name.toString(),
        ),
        Divider(color: Colors.black.withOpacity(0.4),),
        truckInformation(
          "Model Number",
          model.truckDetailModel!.data!.modelNumber.toString(),
        ),
        Divider(color: Colors.black.withOpacity(0.4),),
        truckInformation(
          "Height",
          model.truckDetailModel!.data!.height.toString(),
        ),
        Divider(color: Colors.black.withOpacity(0.4),),
        truckInformation(
          "Width",
          model.truckDetailModel!.data!.width!.toString(),
        ),
        Divider(color: Colors.black.withOpacity(0.4),),
        truckInformation(
          "weight",
          model.truckDetailModel!.data!.weight.toString(),
        ),
        Divider(color: Colors.black.withOpacity(0.4),),
        truckInformation(
          "Power",
          model.truckDetailModel!.data!.power.toString(),
        ),
        Divider(color: Colors.black.withOpacity(0.4),),
        truckInformation(
          "Engine Number",
          model.truckDetailModel!.data!.engine.toString(),
        ),
        Divider(color: Colors.black.withOpacity(0.4),),
        truckInformation(
          "Fuel Capacity",
          model.truckDetailModel!.data!.fuelCapacity.toString()+" "+"ltr",),
        Divider(color: Colors.black.withOpacity(0.4),),
        truckInformation(
          "Fuel Type",
          model.truckDetailModel!.data!.fuelType.toString()),
        Divider(color: Colors.black.withOpacity(0.4),),
        truckInformation(
          "Number of Tyres",
          model.truckDetailModel!.data!.numOfTyres!.toString(),),
        Divider(color: Colors.black.withOpacity(0.4),),
        truckInformation(
          "Wheel Base",
          model.truckDetailModel!.data!.wheelbase.toString()+" "+"mm",),
        SizedBox(height: 20,),
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
