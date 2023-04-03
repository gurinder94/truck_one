import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/JobList/CompanyJob/Provider/JobListProvider.dart';
import 'package:provider/provider.dart';


class IsActive extends StatelessWidget {


  @override
  Widget build(final BuildContext context) {
    return Consumer<JobListProvider>(
      builder: (context, notify, __) {
        return DropdownButton<String>(
          hint: const Text("Not selected"),
          isExpanded: true,
          underline: Container(),
          value: notify.activeType,
          onChanged: (value)
          {
            notify.setSelectedItem(value.toString());
          }
          ,
          items: notify.items.map<DropdownMenuItem<String>>(
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
