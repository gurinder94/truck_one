import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/Provider/UserProfileProvider.dart';
import 'package:provider/provider.dart';

class GenderDrop extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, notif, __) {
        return DropdownButton<String>(
          hint: Text("Gender"),
          isExpanded: true,
          underline: Container(),
          value: notif.valueItemSelected,
          onChanged: (value) {
            notif.setSelectedItem(value.toString());
          },
          items: notif.items.map<DropdownMenuItem<String>>(
            (final String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Center(child: Text(value)),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
