import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

import '../group_create_Post/Provider/create_group_provider.dart';

class DropVisibility extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return Consumer<CreateGroupProvider>(
      builder: (context, notif, __) {
        return DropdownButton<String>(
          hint:  Text(AppLocalizations.instance.text('Visibility')),
          isExpanded: true,
          underline: Container(),
          value: notif.visibility,

          onChanged: (value) {
            notif.setVisiblity(value.toString());
          },

          items: notif.visual.map<DropdownMenuItem<String>>(
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
