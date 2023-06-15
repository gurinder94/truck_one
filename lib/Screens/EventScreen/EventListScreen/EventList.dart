import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/EventModel 2.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/AddEventScreen/AddEvent.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/AddEventScreen/Provider/AddEventProvider.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/AddEventScreen/Provider/show_date_time_Provider.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/EventListScreen/Provider/EventListProvider.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/UserEventScreen/EventListScreen/Component/EventTabBar.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/UserEventScreen/EventListScreen/Provider/UserEventTabBarProvider.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/ViewEventScreen/Provider/UserViewEventProvider.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/ViewEventScreen/ViewEvent.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

import '../../commanWidget/Custom_App_Bar_Widget.dart';
import '../../commanWidget/Search_bar.dart';
import '../../commanWidget/SizeConfig.dart';
import '../../commanWidget/comman_bottom_sheet.dart';
import 'Component/EventItem.dart';
import 'Component/fliter_event_list.dart';

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  late EventListProvider _eventListProvider;
  late ShowTimeProvider _showTimeProvider;
  String? getId;
  ScrollController _sc = new ScrollController();
  var page = 1;
  Timer? _debounce;
  String searchText = '';
  String? Onserach;
  String taber = "TOP";

  @override
  void initState() {
    // TODO: implement initState
    var tab = context.read<UserEventTabBarProvider>();

    _eventListProvider = context.read<EventListProvider>();

    _eventListProvider.resetvalueFliter();

    getEventList(context, 1, '');
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomAppBarWidget(
      title: AppLocalizations.instance.text("Events"),
      leading: GestureDetector(
        child: Icon(Icons.arrow_back),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      floatingActionWidget: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add),
        backgroundColor: PrimaryColor,
        onPressed: () async {
          var d = Provider.of<ShowTimeProvider>(context, listen: false);
          var planDate = await getplanDate();
          var roleName = await getRoleInfo();
          int noEvent = await getCreateEvent() ?? 0;
          var eventPlan = await getEventPlanData();
          d.selecteStartTime.text = "";
          d.selectEndTime.text = "";
          d.selectEnddate.text = "";
          d.selectStartdate.text = "";
          d.selectEnddate.text = "";
          d.valueItemSelected = null;

          planValidation(planDate, eventPlan,
              _eventListProvider.totalNumberEvent, roleName, context, noEvent);
        },
      ),
      actions: SizedBox(),
      child: Column(
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
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Expanded(
                    child: CommanSearchBar(
                  onTextChange: (val) {
                    if (searchText == '') {
                      searchText = val;
                      page = 1;
                    }

                    if (!_eventListProvider.loading) {
                      Onserach = val;
                      getEventList(context, 1, Onserach);
                    }
                  },
                  IconName: GestureDetector(
                    child: Icon(
                      Icons.filter_list,
                      color: Colors.black,
                    ),
                    onTap: () {
                      CommanBottomSheet.ShowBottomSheet(context,
                          child: FliterEvent(_eventListProvider, taber));
                    },
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  EventTabBar(
                    pos: 2,
                    title: 'All',
                    onTabHit: (val) {
                      taber = "UPCOMING";
                      getEventList(context, 1, Onserach);
                      setState(() {});
                    },
                  ),
                  EventTabBar(
                    pos: 0,
                    title: 'Top',
                    onTabHit: (val) {
                      print(val);
                      taber = "TOP";
                      getEventList(context, 1, Onserach);
                    },
                  ),
                  EventTabBar(
                    pos: 1,
                    title: 'Weekly',
                    onTabHit: (val) {
                      print(val);
                      taber = val;

                      getEventList(context, 1, Onserach);
                      setState(() {});
                    },
                  ),
                  EventTabBar(
                    pos: 3,
                    title: 'Booked',
                    onTabHit: (val) {
                      print(val);
                      taber = "Booked";
                      _eventListProvider.hitBookEventList(
                          context, 1, false, taber);
                      setState(() {});
                    },
                  ),
                ]),
          ),
          SizedBox(
            height: 10,
          ),
          taber == "Booked"
              ? Expanded(
                  child: Consumer<EventListProvider>(builder: (_, proData, __) {
                  if (proData.eventListLoad) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (proData.eventListModel == null ||
                      proData.eventListModel!.data!.length == 0)
                    return Center(
                        child: Text(
                            AppLocalizations.instance.text("No Record Found")));
                  else
                    return ListView.builder(
                      itemCount: proData.eventListModel!.data!.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        return ChangeNotifierProvider<EventModel>.value(
                            value: proData.eventListModel!.data![index],
                            child: GestureDetector(
                                child: EventItem(taber), onTap: () {}));
                      },
                    );
                }))
              : Expanded(
                  child: Consumer<EventListProvider>(builder: (_, proData, __) {
                    if (proData.eventListLoad) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    if (proData.eventListModel == null ||
                        proData.eventListModel!.data!.length == 0)
                      return Center(
                          child: Text(AppLocalizations.instance
                              .text("No Record Found")));
                    else
                      return ListView.builder(
                        itemCount: proData.eventListModel!.data!.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (BuildContext context, int index) =>
                            ChangeNotifierProvider<EventModel>.value(
                                value: proData.eventListModel!.data![index],
                                child: GestureDetector(
                                  child: EventItem(taber),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChangeNotifierProvider(
                                                  create: (_) =>
                                                      UserEventViewProvider(),
                                                  child: UserViewEvent(proData
                                                      .eventListModel!
                                                      .data![index]
                                                      .id
                                                      .toString()),
                                                )));
                                  },
                                )),
                      );
                  }),
                )
        ],
      ),
    );
  }

  getEventList(BuildContext context, int page, String? value) async {
    getId = await getUserId();
    var roleName = await getRoleInfo();

    _eventListProvider.hitGetEvents(
        context,
        taber,
        getId,
        page,
        roleName,
        value,
        _eventListProvider.valueSelectedActive,
        _eventListProvider.valueSelectedarchive);
  }

  planValidation(planDate, eventPlan, int totalNumberEvent, roleName,
      BuildContext context, int noEvent) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (_) => AddEventProvider(), child: AddEvent())));
  }
}
