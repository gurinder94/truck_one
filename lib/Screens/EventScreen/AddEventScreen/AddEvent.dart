import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/AddEventScreen/Component/Event_Form.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/AddEventScreen/Component/HeadPart.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customapp.dart';

class AddEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),

      body: CustomAppBar(
        title:AppLocalizations.instance.text("Create Event"),
        visual: false,

        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height:80,),
              HeadPart(),
               EventForm()

            ],
          ),
        ),
      ),
    );
  }
}
