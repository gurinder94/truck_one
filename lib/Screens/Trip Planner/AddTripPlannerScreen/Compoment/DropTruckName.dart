import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/Compoment/drop_down_box.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddTripPlannerScreen/Provider/AddPlannerProvider.dart';
import 'package:provider/provider.dart';

class DropTruckName extends StatelessWidget {


  @override
  Widget build( BuildContext context) {

    return Consumer<AddTripPlannerProvider>(
      builder: (context, notif, __) {
        return DropDownBox(
          child: DropdownButtonFormField<String>(

            decoration: InputDecoration(
              prefixIcon:Icon( FontAwesomeIcons.truck,),
contentPadding: EdgeInsets.all(15),
              enabledBorder: InputBorder.none,
            ),
            hint: const Text(" Selected Truck Name"),
            isExpanded: true,

            value: notif.valueTruckName,
            onChanged: (value) {
              notif.setTruckName(value.toString());
            },
            items:notif.truckListModel!.data!.map(
                  (truckListModel) {
                return DropdownMenuItem(
                  child: Text(truckListModel.name.toString()),
                  value: truckListModel.id.toString(),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
