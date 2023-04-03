import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../commanWidget/comman_drop.dart';
import '../Provider/team_manger_provider.dart';

class  DropStatus extends StatefulWidget {
  ManagerTeamProvider notify;
  Function onSelected;
 var  answer;
  DropStatus(this.notify,{required this.onSelected,required this.answer});

  @override
  State<DropStatus> createState() => _DropStatusState();
}

class _DropStatusState extends State<DropStatus> {
  @override
  void initState() {
    // TODO: implement initState
    setData(widget.notify);
    super.initState();
  }
  @override
  Widget build(final BuildContext context) {

    return CommanDrop(
      title: "",
          onChangedFunction: (value) {
          widget.onSelected(value);
          },
          selectValue: widget.notify.valueItemSelected,
          itemsList: widget.notify.statusItems.map<DropdownMenuItem<String>>(
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
