import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/EditEventScreen/Component/Event_Form.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/EditEventScreen/Component/HeadPart.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/EditEventScreen/Provider/EditProvider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Custom_App_Bar_Widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customapp.dart';
import 'package:provider/provider.dart';


class EditEvent extends StatelessWidget {
  late EditEventProvider  _editEventProvider;
  @override
  Widget build(BuildContext context) {
    _editEventProvider=context.read<EditEventProvider>();
    _editEventProvider.hitUserEventView( "");
return CustomAppBarWidget(
    title: AppLocalizations.instance.text("Events"),
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    floatingActionWidget: SizedBox(),
    actions: SizedBox(),

    child: SingleChildScrollView(
      child: Consumer<EditEventProvider>(builder: (_, proData, __) {
        if (proData.loading && proData.eventModel==null) {
          return Column(

            children: [
              SizedBox(
                height: 120,
              ),
              Center(child: CircularProgressIndicator()),
            ],
          );
        }

        else
          return  Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                proData.eventModel==null?SizedBox():      HeadEditPart(proData),
                 proData.eventModel==null?SizedBox():      EventEditForm(proData)
              ],

          );
      }),
    ),);


  }
}
