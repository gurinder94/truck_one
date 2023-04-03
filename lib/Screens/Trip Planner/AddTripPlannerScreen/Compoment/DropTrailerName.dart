import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/Compoment/drop_down_box.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddTripPlannerScreen/Provider/AddPlannerProvider.dart';
import 'package:provider/provider.dart';

class DropTrailer extends StatelessWidget {
  const DropTrailer({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {

    return Consumer<AddTripPlannerProvider>(
      builder: (context, notif, __) {
        return DropDownBox(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              prefixIcon: Icon(FontAwesomeIcons.trailer),
              enabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.all(15),
            ),
            hint: const Text(" Selected Trailer Name"),
            isExpanded: true,

            value: notif.valueTrailerName,
            onChanged: (value) {
              notif.setTrailerName(value.toString());
            },
            items:notif.trailerListModel!.data!.map(
                  (trailerListModel) {
                return DropdownMenuItem(
                  child: Text(trailerListModel.trailerType.toString()),
                  value: trailerListModel.id.toString(),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }

}
