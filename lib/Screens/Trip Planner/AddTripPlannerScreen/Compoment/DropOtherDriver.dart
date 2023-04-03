import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/Compoment/drop_down_box.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddTripPlannerScreen/Provider/AddPlannerProvider.dart';
import 'package:provider/provider.dart';

class DropOtherDriverName extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {


    return Consumer<AddTripPlannerProvider>(
      builder: (context, notif, __) {
        if (notif.isLoading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        return DropDownBox(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
              prefixIcon: Icon(Icons.person),
              enabledBorder: InputBorder.none,
            ),
            hint: const Text(" Selected Other Driver Name"),
            isExpanded: true,
            value: notif.ValueOtherSelectDriver,
            onChanged: (value) {
              notif.setSelectedOtherDriver(value.toString());
            },
            items: notif.otherDriverListModel!.data!.map(
              (otherDriverListModel) {
                return DropdownMenuItem(
                  child: Text(otherDriverListModel.personName.toString()),
                  value: otherDriverListModel.id.toString(),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
