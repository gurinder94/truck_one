import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_drop.dart';
import 'package:my_truck_dot_one/Screens/team_manage_Screen%20/seller_manage_team/Provider/seller_manage_team_Provider.dart';
import 'package:provider/provider.dart';

class SellerAccessRole extends StatelessWidget {
  Widget build(final BuildContext context) {
    return Consumer<SellerManageTeamProvider>(
      builder: (context, notify, child) {
        return CommanDrop(
          title: "Select access level",
          onChangedFunction: (value) {
            notify.setAccessRole(value);
          },
          selectValue: notify.valueAccessRole,
          itemsList: notify.items.map<DropdownMenuItem<String>>(
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
