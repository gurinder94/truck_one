import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddTripPlannerScreen/Provider/AddPlannerProvider.dart';
import 'package:provider/src/provider.dart';

class OtherDriveDetails extends StatelessWidget {

  Widget build(BuildContext context) {
    var  model= context.read<AddTripPlannerProvider>();

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: model.isLoading==true?Center(child: CircularProgressIndicator()):Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          heading(context, "Other Driver Information"),
          SizedBox(
            height: 20,
          ),
          driverInformation("Name", model.otherDriverDetailListModel!.data!.personName.toString()),
          Divider(color: Colors.black.withOpacity(0.4),),
          driverInformation("Email", model.otherDriverDetailListModel!.data!.email.toString()),
          Divider(color: Colors.black.withOpacity(0.4),),
          driverInformation("Phone", model.otherDriverDetailListModel!.data!.mobileNumber.toString()),
          Divider(color: Colors.black.withOpacity(0.4),),
          driverInformation("Company Name",  model.otherDriverDetailListModel!.data!.companyName.toString()),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
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

driverInformation(
    String s,
    String value,
    ) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
          width: 150,

          child: Text(s,style: TextStyle(fontSize: 18),)),
      SizedBox(
        height: 30,
      ),
      Container(
          width: 200,

          child: Text(value,style: TextStyle(fontSize: 17),)),
      SizedBox(height: 30,),
    ],
  );
}
