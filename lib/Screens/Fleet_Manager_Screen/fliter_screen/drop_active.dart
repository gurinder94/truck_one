import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../commanWidget/comman_drop.dart';
import '../Provider/fleet_manager_provider.dart';

class IsActiveDrop extends StatefulWidget {
  Function onSelectValue;
  var notify;
  FleetManagerProvider fleetManagerProvider;

  IsActiveDrop(
      {required this.onSelectValue,
      required this.notify,
      required this.fleetManagerProvider});

  @override
  State<IsActiveDrop> createState() => _IsActiveDropState();
}

class _IsActiveDropState extends State<IsActiveDrop> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setDate(
      widget.notify,
    );
  }

  @override
  Widget build(final BuildContext context) {
    return CommanDrop(
      title: "",
      onChangedFunction: (String newValue) {
        widget.notify.setSelectedItem(newValue.toString());
        widget.onSelectValue(newValue);
      },
      selectValue: widget.notify.valueItemSelected,
      itemsList: widget.notify.items.map<DropdownMenuItem<String>>(
        (final String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Center(child: Text(value)),
          );
        },
      ).toList(),
    );
  }

  void setDate(
    fleetManagerProvider,
  ) {
    var index = widget.notify.items.indexWhere(
        (element) => element == widget.fleetManagerProvider.valueItemSelected);

    if (index != -1) {
      widget.notify.valueItemSelected = widget.notify.items[index];
    }
  }
}
