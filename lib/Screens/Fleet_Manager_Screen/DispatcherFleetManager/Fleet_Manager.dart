import 'dart:async';
import 'dart:io';

import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/Debouncer.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Fleet_Manager_Screen/view_fleet_Screen/Provider/View_fleet_Manger_Provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';

import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../commanWidget/Search_bar.dart';
import '../../commanWidget/SizeConfig.dart';

import '../../commanWidget/comman_bottom_sheet.dart';
import '../Fleet_manager_List/Fleet_manager_list.dart';
import '../Provider/fleet_manager_provider.dart';
import '../fliter_screen/fliter_fleet_manager.dart';

class FleetManagerScreen extends StatefulWidget {
  @override
  State<FleetManagerScreen> createState() => _FleetManagerScreenState();
}

class _FleetManagerScreenState extends State<FleetManagerScreen> {
  late FleetManagerProvider _fleetManagerProvider;

  late ViewFleetManagerProvider _viewFleetManagerProvider;

  Timer? _debounce;

  String searchText = '';

  Debouncer _debouncer = Debouncer();

  @override
  void initState() {
    // TODO: implement initState

    _fleetManagerProvider = context.read<FleetManagerProvider>();

    _viewFleetManagerProvider = context.read<ViewFleetManagerProvider>();
    _fleetManagerProvider.refresh();
    _fleetManagerProvider.hitFLeetList(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xFFEEEEEE),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 55,
          title: Text(AppLocalizations.instance.text("Fleet Manager")),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                color: APP_BAR_BG,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
          ),
        ),
        body: Column(
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

                          _fleetManagerProvider.searchFliter(val);

                    },
                    IconName: GestureDetector(
                      child: Icon(
                        Icons.filter_list,
                        color: Colors.black,
                      ),
                      onTap: () {
                        CommanBottomSheet.ShowBottomSheet(context,
                            child: Fliter(_fleetManagerProvider));
                      },
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: FleetManagerList(
                    _viewFleetManagerProvider, _fleetManagerProvider)),
          ],
        ),

    );
  }
}

getFleetMangerList(
    BuildContext context, FleetManagerProvider fleetManagerProvider) async {
  fleetManagerProvider.resetValue();
  Future.delayed(Duration(milliseconds: 500), () {
    fleetManagerProvider.hitFLeetList(
      context,
    );
  });
}
