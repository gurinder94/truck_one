import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/Provider/UserProfileProvider.dart';
import 'package:provider/provider.dart';

class MaritaleDrop extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, notif, __) {
        return DropdownButtonFormField<String>(
          hint: const Text("Marital Status"),
          isExpanded: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(border: InputBorder.none),
          value: notif.valueMaritalStatus == "null"
              ? null
              : notif.valueMaritalStatus,
          onChanged: (value) {
            notif.setSelectedMaritalStatus(value!);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter marital status';
            }
            return null;
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
