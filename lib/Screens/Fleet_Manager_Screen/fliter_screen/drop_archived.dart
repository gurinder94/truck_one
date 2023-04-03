
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../commanWidget/comman_drop.dart';
import '../Provider/fleet_manager_provider.dart';

class Isarchived extends StatefulWidget {

  Function onSelectValue;
  var notify;
  FleetManagerProvider fleetManagerProvider;
  Isarchived ({required this.onSelectValue, required this.notify,required this.fleetManagerProvider});

  @override
  State<Isarchived> createState() => _IsarchivedState();
}

class _IsarchivedState extends State<Isarchived> {
  void initState() {
    // TODO: implement initState
    super.initState();

    setDate(widget.notify,);
  }

  @override
  Widget build(final BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CommanDrop(
            title: "",
            onChangedFunction: (String newValue) {
              widget.notify.setSelectedValue(newValue.toString());
              widget.onSelectValue(newValue.toString());
            },
            selectValue: widget.notify.valueItemSelected2,
            itemsList: widget.notify.items2.map<DropdownMenuItem<String>>(
                  (final String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Center(child: Text(value)),
                );
              },
            ).toList(),
          ),
        );


  }

  void setDate(fleetManagerProvider,) {
    var index = widget.notify.items2
        .indexWhere((element) => element == widget.fleetManagerProvider.valueItemSelected2);

    if (index != -1) {
      widget.notify.valueItemSelected2 = widget.notify.items2[index];


    }
  }
}
