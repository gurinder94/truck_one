import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_drop.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/pop_menu_Widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../commanWidget/Search_bar.dart';
import '../../commanWidget/SizeConfig.dart';
import 'Component/dispatcher_list.dart';
import 'Provider/Dispatcher_provider.dart';

class DispatcherScreen extends StatefulWidget {
  String roleName;

  DispatcherScreen(this.roleName);

  @override
  State<DispatcherScreen> createState() => _DispatcherScreenState();
}

class _DispatcherScreenState extends State<DispatcherScreen> {
  var size;

  late DispatcherProvider _listProvider;

  String? type = "UPCOMING";

  int indexFliter = 4;

  initState() {
    super.initState();
    _listProvider = Provider.of<DispatcherProvider>(context, listen: false);
    _listProvider.getrole();
    indexFliter = 4;
    type = "UPCOMING";
    _listProvider.resetFliter();
    _listProvider.tripList = [];
    getTripList(context, 'UPCOMING', '');
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 60,
        title: Text(AppLocalizations.instance.text('Trip Planner')),
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
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
          child: Row(
            children: [
              Expanded(
                child: CommanSearchBar(
                    onTextChange: (val) {
                      if (!_listProvider.tripPlannerListLoad) {
                        _listProvider.tripList = [];
                        getTripList(context, type!, val);
                      }
                    },
                    IconName: PopMenuBar(
                      val: indexFliter,
                      iconsName: Icons.filter_list,
                      containerDecoration: 1,
                      onDoneFunction: (value) {
                        switch (value) {
                          case 1:
                            indexFliter = 1;
                            type = "ACTIVE";

                            _listProvider.tripList = [];
                            getTripList(context, 'ACTIVE', '');
                            _listProvider.setValuefliter("ACTIVE");
                            break;
                          case 2:
                            indexFliter = 2;
                            type = "CANCELLED";
                            _listProvider.tripList = [];
                            getTripList(context, 'CANCELLED', '');
                            _listProvider.setValuefliter("CANCELLED");
                            break;
                          case 3:
                            indexFliter = 3;
                            type = "COMPLETED";
                            _listProvider.tripList = [];
                            getTripList(context, 'COMPLETED', '');
                            _listProvider.setValuefliter("COMPLETED");
                            break;
                          case 4:
                            indexFliter = 4;
                            type = "UPCOMING";
                            _listProvider.tripList = [];
                            getTripList(context, 'UPCOMING', '');
                            _listProvider.setValuefliter("UPCOMING");
                            break;
                          case 5:
                            indexFliter = 5;
                            type = "UNASSINGED";
                            _listProvider.tripList = [];
                            getTripList(context, 'UNASSINGED', '');
                            _listProvider.setValuefliter("UNASSINGED");
                            break;
                          case 7:
                            indexFliter = 7;
                            type = "EXPIRED";
                            _listProvider.tripList = [];
                            getTripList(context, 'EXPIRED', '');
                            _listProvider.setValuefliter("EXPIRED");

                            break;
                          case 6:
                            indexFliter = 6;

                            SelectType(_listProvider, type!);
                            break;
                        }
                      },
                      userMenuItems: [
                        ['Active', 1],
                        ['Cancelled', 2],
                        ['Completed', 3],
                        ['Upcoming', 4],
                        ['Unassigned', 5],
                        ['Action Pending', 7],
                        ['Selected Type', 6],
                      ],
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 100,
                child: Consumer<DispatcherProvider>(
                  builder: (BuildContext context, value, Widget? child) =>
                      CommanDrop(
                    title: "Sort",
                    onChangedFunction: (String newValue) {
                      value.sort = newValue;
                      if (value.sort == "A-Z") {
                        value.tripList.sort((a, b) {
                          return a.source!.address!
                              .compareTo(b.source!.address.toString());
                        });
                      } else if (value.sort == "Z-A") {
                        value.tripList.sort((a, b) => b.source!.address!
                            .compareTo(a.source!.address.toString()));
                      }
                      value.notifyListeners();
                    },
                    selectValue: value.sort,
                    itemsList: value.sortList.map<DropdownMenuItem<String>>(
                      (value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(child: Text(value)),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black.withOpacity(.2)),
                        color: Colors.grey.shade300,
                        shape: BoxShape.circle),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Driver Exit Company')
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black.withOpacity(.2)),
                        color: Colors.pink.shade50,
                        shape: BoxShape.circle),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Substitute Driver Left')
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        DispatcherList(_listProvider, type!),
        _listProvider.pagination ? LinearProgressIndicator() : SizedBox()
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  getTripList(
    BuildContext context,
    String type,
    val,
  ) async {
    var getId = await getUserId();

    _listProvider.hitTripList(type, val);
    _listProvider.addScrollListener(context, type, val);
  }
}

_launchURL() async {
  String url = Base_url_Add_Product;
  print(url);
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not launch $url');
    throw 'Could not launch $url';
  }
}

var items = ["Arrive by", "Depart at"];

SelectType(DispatcherProvider listProvider, String type) {
  return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Color(0xFFEEEEEE),
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              title: Text('Select Type'),
              content: Column(
                children: [
                  Consumer<DispatcherProvider>(
                      builder: (context, notify, child) {
                    return SizedBox(
                      height: 40,
                      child: CommanDrop(
                        title: "",
                        onChangedFunction: (String newValue) {
                          notify.setSelectedDate(newValue);
                          // addTripProvider.setArrive(newValue.toString());
                        },
                        selectValue: notify.selectValue,
                        itemsList: items.map<DropdownMenuItem<String>>(
                          (final String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(child: Text(value)),
                            );
                          },
                        ).toList(),
                      ),
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    child: InputTextField(
                        child: TextFormField(
                      controller: listProvider.startDate,
                      readOnly: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Select Date',
                          suffixIcon: Icon(
                            Icons.calendar_month,
                            size: 18,
                          )),
                      onTap: () {
                        listProvider
                            .getDate(navigatorKey.currentState!.context);
                      },
                    )),
                  ),
                ],
              ),
              scrollable: true,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    splashColor: PrimaryColor,
                    highlightColor: Colors.white,
                    child: Text(AppLocalizations.instance.text('No'),
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16)),
                    onTap: () async {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    splashColor: PrimaryColor,
                    highlightColor: Colors.white,
                    child: Text(AppLocalizations.instance.text('Yes'),
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16)),
                    onTap: () async {
                      listProvider.hitFilter(type);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    splashColor: PrimaryColor,
                    highlightColor: Colors.white,
                    child: Text(AppLocalizations.instance.text('Reset'),
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16)),
                    onTap: () async {
                      listProvider.resetDate(type);
                    },
                  ),
                ),
                SizedBox()
              ],
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: navigatorKey.currentState!.context,
      pageBuilder: (context, animation1, animation2) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation1),
        );
      });
}
