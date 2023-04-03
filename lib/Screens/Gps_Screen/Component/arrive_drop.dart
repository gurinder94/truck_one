import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Gps_Screen/provider/add_Trip_Provider.dart';
import 'package:provider/provider.dart';

import '../../commanWidget/comman_drop.dart';
import '../provider/choose_Source_Provider.dart';

class TripDrop extends StatelessWidget {
  AddTripProvider addTripProvider;
 TripDrop(this.addTripProvider, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChooseSourceProvider>(
      builder: (context, notify, child) {
        return Padding(
          padding:  EdgeInsets.all(8.0),
          child: CommanDrop(
            title: "",
            onChangedFunction: (String newValue) {
              notify.setSelectedItem(newValue.toString());
              addTripProvider.setArrive(newValue.toString());
            },
            selectValue: addTripProvider.routeFlag,
            itemsList: notify.items.map<DropdownMenuItem<String>>(
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
