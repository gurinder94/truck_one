import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/UserProfileProvider.dart';

class MonthExperience extends StatefulWidget {
  const MonthExperience({Key? key}) : super(key: key);

  @override
  State<MonthExperience> createState() => _MonthExperienceState();
}

class _MonthExperienceState extends State<MonthExperience> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, notif, __) {
        return DropdownButtonFormField<String>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          hint: const Text("Month Experience *"),
          isExpanded: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter month experience';
            }
            return null;
          },
          decoration: InputDecoration(border: InputBorder.none),
          value: notif.valueExpMonth,
          onChanged: (value) {
            notif.setMonthExperience(value.toString());
          },
          items: notif.monthExp.map<DropdownMenuItem<String>>(
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
