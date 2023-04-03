import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/TimezoneModel.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/AddEventScreen/Provider/show_date_time_Provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:provider/provider.dart';

class TimeZoneDrop extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Consumer<ShowTimeProvider>(
      builder: (context, notif, __) {
        if(notif.loading==true)
          {
            print(notif.valueItemSelected);
            return CircularProgressIndicator();
          }
        else
        return InputTextField(
          child: DropdownButton<Datum>(
            hint:  Text(AppLocalizations.instance.text("Select Time Zone")),
            isExpanded: true,
            underline: Container(),
             value: notif.valueItemSelected,

            onChanged: (value) {
             notif.setTimeZone(value!);
            },

            items: notif.timeZone.data!.map((Datum map) {
              return new DropdownMenuItem<Datum>(
                value: map,
                child: new Text(map.name.toString(),
                    style: new TextStyle(color: Colors.black)),
              );
            }).toList(),

          ),
        );

      },
    );
  }
}
