import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/Provider/UserProfileProvider.dart';
import 'package:provider/provider.dart';

class MaritaleDrop extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, notif, __) {
        return DropdownButton<String>(
          hint: const Text("Marital Status"),
          isExpanded: true,
          underline: Container(),
          value: notif.valueMaritalStatus=="null"?null:notif.valueMaritalStatus,
          onChanged: (value) {
            notif.setSelectedMaritalStatus(value!);
          },
          items: notif.maritalStatus.map<DropdownMenuItem<String>>(
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
