import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/Provider/UserProfileProvider.dart';
import 'package:provider/provider.dart';

class ExperienceDrop extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, notif, __) {
        return DropdownButtonFormField<String>(
          hint: const Text("Experience *"),
          isExpanded: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter experience';
            }
            return null;
          },
          decoration: InputDecoration(border: InputBorder.none),
          value: notif.valueExperience,
          onChanged: (value) {
            notif.setSelectedExperience(value.toString());
          },
          items: notif.experience.map<DropdownMenuItem<String>>(
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
