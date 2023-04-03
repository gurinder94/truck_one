import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_drop.dart';
import 'package:my_truck_dot_one/Screens/team_manage_Screen%20/seller_manage_team/Provider/seller_manage_team_Provider.dart';
import 'package:provider/provider.dart';

class ManageTeamPerson extends StatelessWidget {
  const ManageTeamPerson({Key? key}) : super(key: key);

  Widget build(final BuildContext context) {
    return Consumer<SellerManageTeamProvider>(
      builder: (context, notify, child) {
        return CommanDrop(
          title: "",
          onChangedFunction: (value) {
            notify.setPerson(value);
          },
          selectValue: notify.valuePersonName,
          itemsList: notify.items1.map<DropdownMenuItem<String>>(
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
