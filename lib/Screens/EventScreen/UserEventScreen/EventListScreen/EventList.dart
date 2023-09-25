import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/EventModel 2.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/ViewEventScreen/Provider/UserViewEventProvider.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/ViewEventScreen/ViewEvent.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../AppUtils/constants.dart';
import '../../../commanWidget/Custom_App_Bar_Widget.dart';
import '../../../commanWidget/PaginationWidget.dart';
import '../../../commanWidget/Search_bar.dart';
import '../../../commanWidget/SizeConfig.dart';
import '../../../commanWidget/comman_bottom_sheet.dart';
import '../../../commanWidget/pop_menu_Widget.dart';
import 'Component/EventTabBar.dart';
import 'Component/MenuBarEvent.dart';

import 'Component/User_event_Item.dart';
import 'Provider/UserEventListProvider.dart';
import 'Provider/UserEventTabBarProvider.dart';

class UserEventList extends StatefulWidget {
  const UserEventList({Key? key}) : super(key: key);

  @override
  _UserEventListState createState() => _UserEventListState();
}

class _UserEventListState extends State<UserEventList> {
  late UserEventListProvider _eventListProvider;

  String? getId;
  ScrollController _scrollController = new ScrollController();
  String Onserach = '';
  int pagee = 1;
  String taber = "UPCOMING";
  Timer? _debounce;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    _eventListProvider = context.read<UserEventListProvider>();
    var tab = context.read<UserEventTabBarProvider>();
    Future.delayed(Duration(milliseconds: 3000))
        .then((onValue) => tab.setMenuClick(0));
    pagee = 1;
    _eventListProvider.resetList();
    getEventList(context, taber, 1, "");
  }

  Widget build(BuildContext context) {
    addScrollListener(context);
    SizeConfig().init(context);

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizeConfig.screenHeight! < 1010
                ? SizedBox(
                    height: Platform.isIOS
                        ? SizeConfig.safeBlockVertical! * 17
                        : SizeConfig.safeBlockVertical! * 12, //10 for example
                  )
                : SizedBox(
                    height: Platform.isIOS
                        ? SizeConfig.safeBlockVertical! * 9
                        : SizeConfig.safeBlockVertical! * 9, //10 for example
                  ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: CommanSearchBar(
                  onTextChange: (val) {
                    if (searchText == '') {
                      searchText = val;
                      pagee = 1;
                      Onserach = '';
                    }

                    if (!_eventListProvider.loading) {
                      Onserach = val;
                      _eventListProvider.resetList();
                      getEventList(context, taber, 1, Onserach);
                    } else {}
                  },
                  IconName: GestureDetector(
                    child: Icon(
                      Icons.filter_list,
                      color: Colors.black,
                    ),
                    onTap: () {
                      CommanBottomSheet.ShowBottomSheet(context,
                          child: ChangeNotifierProvider(
                              create: (_) => UserEventListProvider(),
                              child: MenuBarEvent(_eventListProvider)));
                    },
                  ),
                )),
                SizedBox(
                  width: 5,
                ),
                Selector<UserEventListProvider, bool>(
                  selector: (_, provider) => provider.locationPermission,
                  builder: (context, locationPermission, child) {
                    return locationPermission == false
                        ? GestureDetector(
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.black,
                            ),
                            onTap: () {
                              showMessage('Please Enable Location');
                            })
                        : PopMenuBar(
                            iconsName: Icons.more_vert,
                            val: 0,
                            userMenuItems: [
                              ['50 Miles', 1],
                              ['100 Miles', 2],
                              ['150 Miles', 3],
                              ['200 Miles', 4]
                            ],
                            containerDecoration: 2,
                            onDoneFunction: (value) {

                              switch (value) {

                                case 1:
                                  _eventListProvider.resetList();

                                  _eventListProvider.hitGetEventsList(
                                      context, taber, 1, false, Onserach, 50);

                                  break;
                                case 2:
                                  _eventListProvider.resetList();

                                  _eventListProvider.hitGetEventsList(
                                      context, taber, 1, false, Onserach, 100);
                                  break;
                                case 3:
                                  _eventListProvider.resetList();

                                  _eventListProvider.hitGetEventsList(
                                      context, taber, 1, false, Onserach, 150);
                                  break;
                                case 4:
                                  _eventListProvider.resetList();

                                  _eventListProvider.hitGetEventsList(
                                      context, taber, 1, false, Onserach, 200);
                                  break;
                              }
                            });
                  },
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    EventTabBar(
                      pos: 0,
                      title: 'All',
                      onTabHit: (val) {

                        // if (_eventListProvider.eventListLoad)
                         // taber = "UPCOMING";//
                          taber = "UPCOMING";
                          print('onTabHit fff> $taber');
                        _eventListProvider.resetList();


                        _eventListProvider.hitGetEventsList(
                            context, taber, 1, false, Onserach, 0);
                      },
                    ),
                    EventTabBar(
                      pos: 1,
                      title: 'Top',
                      onTabHit: (val) {

                        taber = 'TOP';
                        print('onTabHit>> $taber');
                        _eventListProvider.resetList();
                        print(_eventListProvider.resetList());
                        _eventListProvider.hitGetEventsList(
                            context, taber, 1, false, Onserach, 0);
                      },
                    ),
                    EventTabBar(
                      pos: 2,
                      title: 'Weekly',
                      onTabHit: (val) {
                        taber = 'WEEKLY';
                        print('onTabHit>> $taber');
                        _eventListProvider.resetList();

                        _eventListProvider.hitGetEventsList(
                            context, taber, 1, false, Onserach, 0);
                      },
                    ),
                  ]),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Consumer<UserEventListProvider>(builder: (_, proData, __) {
                if (proData.eventListLoad) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (proData.Event.length == 0)
                  return Center(
                      child: Text(
                          AppLocalizations.instance.text("No Record Found")));
                else {
                  return ListView.builder(
                      itemCount: proData.Event.length,
                      padding: EdgeInsets.zero,
                      controller: _scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        return ChangeNotifierProvider<EventModel>.value(
                            value: proData.Event[index],
                            child: GestureDetector(
                              child: EventItem(),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeNotifierProvider(
                                              create: (_) =>
                                                  UserEventViewProvider(),
                                              child: UserViewEvent(proData
                                                  .Event[index].id
                                                  .toString()),
                                            )));
                              },
                            ));
                      });
                }
              }),
            ),
            SizedBox(
              height: 10,
            ),
            Selector<UserEventListProvider, bool>(
                selector: (_, provider) => provider.paginationLoading,
                builder: (context, paginationLoading, child) {
                  return PaginationWidget(paginationLoading);
                }),
            SizedBox(
              height: 10,
            ),
          ],
        ));
  }

  getEventList(BuildContext context, String taber, int page, val) async {
    getId = await getUserId();
    var getRoleName = await getRoleInfo();

    _eventListProvider.resetList();


    _eventListProvider
        .getLocation(context, taber, 1, false, val)
        .catchError((err) {
      print('error>> $err');

    });
    pagee = 1;
  }

  pagnationList(BuildContext context, int pagee) async {
    _eventListProvider.hitGetEventsList(
        context, taber, pagee, true, Onserach, 0);
  }

  void addScrollListener(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!_eventListProvider.paginationLoading) {
          if (_eventListProvider.eventListModel!.data!.length == 0) {
          } else {
            pagee = pagee + 1;
            pagnationList(context, pagee);
          }
          // Perform event when user reach at the end of list (e.g. do Api call)
        }
      }
    });
  }
}
