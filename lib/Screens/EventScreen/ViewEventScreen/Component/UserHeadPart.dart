import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/ViewEventScreen/Provider/UserViewEventProvider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';

class UserHeadPart extends StatelessWidget {
  UserEventViewProvider _eventViewProvider;

  UserHeadPart(this._eventViewProvider);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      child: Stack(children: [
        Container(
            width: double.infinity,
            height: 250,
            child: CustomImage(
                image: SERVER_URL +
                    '/uploads/event/image/' +
                    _eventViewProvider.eventModel!.bannerImage.toString(),
                width: double.infinity,
                boxFit: BoxFit.fill,
                height: 250)),
        Positioned(
          left: 20,
          bottom: 10,
          child: CustomImageProfile(
            image: _eventViewProvider.eventModel!.brandLogo == null
                ? ''
                : Event_logo_Url +
                    _eventViewProvider.eventModel!.brandLogo.toString(),
            width: 80,
            boxFit: BoxFit.fill,
            height: 80,
          ),
        ),
      ]),
    );
  }
}
