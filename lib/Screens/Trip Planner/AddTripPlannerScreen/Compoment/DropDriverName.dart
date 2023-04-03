import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/Compoment/drop_down_box.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddTripPlannerScreen/Provider/AddPlannerProvider.dart';
import 'package:provider/provider.dart';

class DropDriverName extends StatelessWidget {
  const DropDriverName({Key? key}) : super(key: key);

  @override
  Widget build( BuildContext context) {

    return Consumer<AddTripPlannerProvider>(
      builder: (context, notif, __) {

        if (notif.getLoading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        return  DropDownBox(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
              prefixIcon: Icon(Icons.person),
              enabledBorder: InputBorder.none,
            ),
            hint: const Text(" Selected  Driver Name"),
            isExpanded: true,

            value: notif.ValueSelectDriver,
            onChanged: (value) {
              notif.setSelectedDriver(value.toString());
            },
            items: notif.driverListModel!.data!.map(
                  (driverListModel) {
                return DropdownMenuItem(
                  child: Text(driverListModel.personName.toString()),
                  value: driverListModel.id.toString(),
                );
              },
            ).toList(),
            validator: (value) {
              if (value == null) return "Please select your gender";
              return null;
            },
          ),
        );
      },
    );
  }
}
