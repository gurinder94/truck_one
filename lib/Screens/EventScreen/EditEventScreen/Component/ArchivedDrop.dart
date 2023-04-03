import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/EditEventScreen/Provider/EditProvider.dart';
import 'package:provider/provider.dart';

class ArchivedDrop extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return Consumer<EditEventProvider>(
      builder: (context, notif, __) {
        return DropdownButton<String>(
          hint: const Text("Not selected"),
          isExpanded: true,
          underline: Container(),
          value: notif.valueSelected,
          onChanged: (value) {
            notif.setArchivedItem(value.toString());
          },
          items: notif.items2.map<DropdownMenuItem<String>>(
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
