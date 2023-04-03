import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/team_manage_Screen%20/company_team_manage/Provider/team_manger_provider.dart';
import '../../../commanWidget/comman_drop.dart';


class DropAccessRole extends StatefulWidget {
  ManagerTeamProvider notify;
  Function onSelected;
  var  answer;
  DropAccessRole(this.notify,{required this.onSelected,this.answer});

  @override
  State<DropAccessRole> createState() => _DropAccessRoleState();
}

class _DropAccessRoleState extends State<DropAccessRole> {
  void initState() {
    // TODO: implement initState
    super.initState();

    setData(
      widget.notify,
    );
  }
  @override
  Widget build(final BuildContext context) {

        return CommanDrop(
          title: "Select access level",
          onChangedFunction: (value) {
            widget.onSelected(value);

          },
          selectValue: widget.notify.valueAccessRole,
          itemsList: widget.notify.items1.map<DropdownMenuItem<String>>(
            (final String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Center(child: Text(value)),
              );
            },
          ).toList(),
        );

  }

  void setData(ManagerTeamProvider notify) {
    var index = widget.notify.statusItems
        .indexWhere((element) => element == widget.answer);

    if (index != -1) {
      widget.notify.valueItemSelected = widget.notify.statusItems[index];


    }

  }


}
