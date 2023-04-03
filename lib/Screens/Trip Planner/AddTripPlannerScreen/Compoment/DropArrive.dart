import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/Compoment/drop_down_box.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddTripPlannerScreen/Provider/AddPlannerProvider.dart';
import 'package:provider/provider.dart';

class DropArrive extends StatelessWidget {


  @override
  Widget build(final BuildContext context) {

    return Consumer<AddTripPlannerProvider>(
      builder: (context, notif, __) {
        return DropDownBox(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
              prefixIcon: Icon(Icons.person),
              enabledBorder: InputBorder.none,
            ),
            isExpanded: true,

            value: notif.ValueArrive,
            onChanged: (value) {
              notif.setArriv(value.toString());
            },
            items: notif.Arrived.map<DropdownMenuItem<String>>(
                  (final String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Center(child: Text(value)),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
