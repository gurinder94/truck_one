import 'dart:io';
import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_truck_dot_one/AppUtils/Debouncer.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Fleet_Manager_Screen/view_fleet_Screen/Provider/View_fleet_Manger_Provider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Language_Screen/application_localizations.dart';
import '../../commanWidget/Search_bar.dart';
import '../../commanWidget/SizeConfig.dart';
import '../Fleet_manager_List/Fleet_manager_list.dart';
import '../Provider/fleet_manager_provider.dart';
import '../add_fleet_mamager_screen/add_fleet_manager_provider.dart';
import '../add_fleet_mamager_screen/add_trailer_page.dart';
import '../add_fleet_mamager_screen/add_truck_page.dart';
import '../fliter_screen/fliter_fleet_manager.dart';

class CompanyFleetManagerPage extends StatelessWidget {
  late FleetManagerProvider _fleetManagerProvider;

  late ViewFleetManagerProvider _viewFleetManagerProvider;



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _fleetManagerProvider = context.read<FleetManagerProvider>();
    _viewFleetManagerProvider = context.read<ViewFleetManagerProvider>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 55,
        title: Text(AppLocalizations.instance.text('Fleet Manager')),
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
                      ? SizeConfig.safeBlockVertical! * 16
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
      floatingActionButton: Selector<FleetManagerProvider, bool>(
          selector: (_, provider) => provider.visable,
          builder: (context, plan, child) {
            return plan
                ? AnimatedFloatingActionButton(
                    //Fab list
                    fabButtons: <Widget>[
                      float3(context),
                      float2(context),
                      // float3(context)
                    ],

                    colorStartAnimation: APP_BAR_BG,
                    colorEndAnimation: APP_BAR_BG,
                    animatedIconData: AnimatedIcons.menu_close,
                  )
                : SizedBox();
          }),
    );
  }

  Widget float2(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (_) => AddFleetManagerProvider(),
                    child: AddTrailerPage()),
              )).then((value) {
            _fleetManagerProvider.refresh();
            _fleetManagerProvider.hitFLeetList(
              context,
            );
          });
        },
        tooltip: 'Trailer',
        heroTag: 'two',
        child: FaIcon(FontAwesomeIcons.trailer),
      ),
    );
  }

  Widget float3(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (_) => AddFleetManagerProvider(),
                    child: AddTruckManager()),
              )).then((value) {
            _fleetManagerProvider.refresh();
            _fleetManagerProvider.hitFLeetList(
              context,
            );
          });
        },
        tooltip: 'Truck',
        heroTag: 'one',
        child: Icon(Icons.fire_truck_rounded),
      ),
    );
  }
}
