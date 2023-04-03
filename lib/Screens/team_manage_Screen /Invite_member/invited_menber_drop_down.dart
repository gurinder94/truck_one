import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/team_manage_Screen%20/Provider/_invite_member_provider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_drop.dart';
import 'package:provider/provider.dart';

class InvitedMenberDropDownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SendMemInviteProvider>(
      builder: (context, notify, child) {
        return CommanDrop(
          title: "Select Access Level",
          onChangedFunction: (value) {
            notify.setSelectedItem(value);
          },
          selectValue: notify.valueItemSelected,
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
// InputShape(
// child: CommanDrop(
// onChangedFunction: (value) {
//
// _provider.setSelectedItem(value);
// },
// selectValue: _provider.valueItemSelected,
// itemsList: _provider.items.map<DropdownMenuItem<String>>(
// (final String value) {
// return DropdownMenuItem<String>(
// value: value,
// child: Center(child: Text(value)),
// );
// },
// ).toList(),
// ),
//
// );
