import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/ViewEventScreen/Component/UserHeadPart.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customapp.dart';
import 'package:provider/provider.dart';
import 'Component/UserEventDetail.dart';
import 'Provider/UserViewEventProvider.dart';

class UserViewEvent extends StatelessWidget {
  String id;

  UserViewEvent(this.id);

  late UserEventViewProvider _eventViewProvider;

  @override
  Widget build(BuildContext context) {
    _eventViewProvider = context.read<UserEventViewProvider>();

    _eventViewProvider.hitUserEventView(context, id, ' ');
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: CustomAppBar(
        visual: false,
        title: AppLocalizations.instance.text("View Event"),
        child: SingleChildScrollView(
          child: Consumer<UserEventViewProvider>(builder: (_, proData, __) {
            return proData.loading == true && proData.eventModel == null
                ? Column(
                    children: [
                      SizedBox(
                        height: 300,
                      ),
                      Center(child: CircularProgressIndicator()),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      proData.eventModel == null
                          ? SizedBox()
                          : UserHeadPart(proData),
                      proData.eventModel == null
                          ? SizedBox()
                          : UserEventDetail(proData)
                    ],
                  );
          }),
        ),
      ),
    );
  }
}
