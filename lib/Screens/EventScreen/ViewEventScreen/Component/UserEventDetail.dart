import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/data_items.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/EditEventScreen/Provider/EditProvider.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/EditEventScreen/editEventScreen.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/ViewEventScreen/Provider/UserViewEventProvider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/pop_menu_Widget.dart';

import 'package:provider/provider.dart';

import 'EventViewAttendee.dart';
import 'EventView_Deatil.dart';

class UserEventDetail extends StatelessWidget {
  UserEventViewProvider _eventViewProvider;

  UserEventDetail(this._eventViewProvider);

  @override
  Widget build(BuildContext context) {
    _eventViewProvider.eventModel!.getTime();
    print(_eventViewProvider.eventModel!.eventTime);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _eventViewProvider.eventModel!.name.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                  ),
                  // _eventViewProvider.roleTile == "COMPANY" ||
                  //         _eventViewProvider.roleTile == "HR"
                  //     ? _eventViewProvider.eventModel!.eventTime !=
                  //                 "On-going" ||
                  //             _eventViewProvider.eventModel!.eventTime ==
                  //                 "EXPIRED"
                  //         ? SizedBox()
                  //         : PopMenuBar(
                  //             iconsName: Icons.more_vert,
                  //             val: 1,
                  //             userMenuItems: eventAction,
                  //             containerDecoration: 3,
                  //             onDoneFunction: (value) {
                  //               switch (value) {
                  //                 case 1:
                  //                   Navigator.push(
                  //                       context,
                  //                       MaterialPageRoute(
                  //                           builder: (context) =>
                  //                               ChangeNotifierProvider(
                  //                                 create: (_) =>
                  //                                     EditEventProvider(
                  //                                         _eventViewProvider
                  //                                             .eventModel!.id!),
                  //                                 child: EditEvent(),
                  //                               )));
                  //
                  //                   break;
                  //               }
                  //             })
                  //     : SizedBox(),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                " ${AppLocalizations.instance.text("Event by")} ${_eventViewProvider.eventModel!.createdBy}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      "icons/C1.png",
                      width: 35,
                      height: 35,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 10,
                    child: Text(_eventViewProvider.eventModel!
                            .changeDateTimeZone(_eventViewProvider
                                .eventModel!.startDate
                                .toString()) +
                        ' at ' +
                        _eventViewProvider.eventModel!.changeTimeZone(
                            _eventViewProvider.eventModel!.startDate
                                .toString()) +
                        _eventViewProvider.eventModel!.changeDateTimeZone(
                            _eventViewProvider.eventModel!.endDate.toString()) +
                        ' at ' +
                        _eventViewProvider.eventModel!.changeTimeZone(
                            _eventViewProvider.eventModel!.endDate.toString())),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      "icons/video.png",
                      width: 25,
                      height: 25,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 10,
                    child: Text(
                        _eventViewProvider.eventModel!.eventMode.toString()),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      "icons/person.png",
                      width: 25,
                      height: 25,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 10,
                    child: Text(
                        _eventViewProvider.eventModel!.noOfAttendee.toString()),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              _eventViewProvider.eventModel!.eventMode == "online"
                  ? SizedBox()
                  : Row(
                      children: [
                        Expanded(flex: 1, child: Icon(Icons.location_pin)),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 10,
                          child: Text(_eventViewProvider.eventModel!.address
                              .toString()),
                        )
                      ],
                    ),
              _eventViewProvider.eventModel!.eventMode == "online"
                  ? SizedBox()
                  : SizedBox(
                      height: 15,
                    ),
              Row(
                children: [
                  Expanded(flex: 1, child: Icon(Icons.attach_money_sharp)),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 10,
                    child: Text(
                      "${_eventViewProvider.eventModel!.currency.toString()} ${_eventViewProvider.value.format(double.parse(_eventViewProvider.eventModel!.eventFee.toString()))}",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: menuWidget(context),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(color: Color(0xFFEEEEEE), boxShadow: [
          BoxShadow(
            color: Color(0xFFD9D8D8),
            offset: Offset(5.0, 5.0),
            blurRadius: 7,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(.5),
            offset: Offset(-5.0, -5.0),
            blurRadius: 7,
          ),
        ]),
      ),
    );
  }

  menuWidget(BuildContext context) {
    switch (
        Provider.of<UserEventViewProvider>(context, listen: true).menuClick) {
      case 0:
        return EventViewTabDetail();
      case 1:
        return EventViewAttendee();
    }
  }
}
