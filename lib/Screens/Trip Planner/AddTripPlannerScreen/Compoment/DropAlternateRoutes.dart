import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/Compoment/drop_down_box.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddTripPlannerScreen/Provider/AddPlannerProvider.dart';
import 'package:provider/provider.dart';

class DropAlternateRoutes extends StatelessWidget {

  @override
  Widget build(final BuildContext context) {

    return Consumer<AddTripPlannerProvider>(
      builder: (context, notif, __) {
        return DropDownBox(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              prefixIcon: Icon(FontAwesomeIcons.route),
              enabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.all(15),
            ),
            hint: const Text(" Selected Alternate Routes"),
            isExpanded: true,

            value: notif.valueAlternateRoute,
            onChanged: (value) {
              notif.setAlternateRoute(value.toString());
            },
            items: notif.Alternate.map<DropdownMenuItem<String>>(
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

