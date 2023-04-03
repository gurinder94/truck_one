import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TripPlannerListModel.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/Provider/TripPlannerProvider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';

import 'package:my_truck_dot_one/Screens/commanWidget/SizeConfig.dart';

import 'package:provider/provider.dart';
import '../../commanWidget/Search_bar.dart';
import 'Component/UserTripItem.dart';

class UserTripPlanner extends StatefulWidget {
  @override
  _UserTripPlannerState createState() => _UserTripPlannerState();
}

class _UserTripPlannerState extends State<UserTripPlanner> {
  var size;
  late TripPlannerListProvider _listProvider;
  String type = "ALL";

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _listProvider =
        Provider.of<TripPlannerListProvider>(context, listen: false);

    getEventList(context, type);

    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xFFEEEEEE),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 60,
          title: Text("Trips Detail"),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                color: APP_BAR_BG,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
          ),
          actions: [],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizeConfig.screenHeight! < 1010
                ? SizedBox(
                    height: Platform.isIOS
                        ? SizeConfig.safeBlockVertical! * 15
                        : SizeConfig.safeBlockVertical! * 12, //10 for example
                  )
                : SizedBox(
                    height: Platform.isIOS
                        ? SizeConfig.safeBlockVertical! * 9
                        : SizeConfig.safeBlockVertical! * 9, //10 for example
                  ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: CommanSearchBar(
                        onTextChange: (val) {
                          if (!_listProvider.tripPlannerListLoad) {
                            _listProvider.hitGetDriverList(context, type, val);
                          }
                        },
                        IconName: PopupMenuButton(
                            elevation: 20,
                            enabled: true,
                            child: Container(
                              width: 40,
                              height: 40,
                              child: Icon(
                                Icons.more_vert,
                                color: Colors.black,
                              ),
                            ),
                            onSelected: (value) {
                              switch (value) {
                                case 1:
                                  getEventList(context, 'ALL');
                                  type = 'ALL';
                                  break;
                                case 2:
                                  getEventList(context, 'ACTIVE');
                                  type = 'ACTIVE';
                                  break;
                                case 3:
                                  getEventList(context, 'CANCELLED');
                                  type = 'CANCELLED';
                                  break;
                                case 4:
                                  getEventList(context, 'COMPLETED');
                                  type = 'COMPLETED';
                                  break;
                                case 5:
                                  getEventList(context, 'UPCOMING');
                                  type = 'UPCOMING';
                                  break;
                              }
                            },
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: Text("All"),
                                    value: 1,
                                  ),
                                  PopupMenuItem(
                                    child: Text("Active"),
                                    value: 2,
                                  ),
                                  PopupMenuItem(
                                    child: Text("Cancelled"),
                                    value: 3,
                                  ),
                                  PopupMenuItem(
                                    child: Text("Completed"),
                                    value: 4,
                                  ),
                                  PopupMenuItem(
                                    child: Text("UpComing"),
                                    value: 5,
                                  )
                                ])),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(child:
                Consumer<TripPlannerListProvider>(builder: (_, proData, __) {
              if (proData.tripPlannerListLoad) {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (proData.tripPlannerList == null ||
                  proData.tripPlannerList!.data!.length == 0)
                return Center(
                    child: Text(
                        AppLocalizations.instance.text("No Record Found")));
              else
                return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: proData.tripPlannerList!.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChangeNotifierProvider<TripPlannerModel>.value(
                          value: proData.tripPlannerList!.data![index],
                          child: DriverTripItem(proData));
                    });
            }))
          ],
        ));
  }

  getEventList(
    BuildContext context,
    String type,
  ) async {
    var getId = await getUserId();

    _listProvider.hitGetDriverList(context, type, '');
  }
}
