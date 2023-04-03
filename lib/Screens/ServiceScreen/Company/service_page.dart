import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/Debouncer.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/pop_menu_Widget.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../commanWidget/Custom_App_Bar_Widget.dart';
import '../../commanWidget/Search_bar.dart';
import '../../commanWidget/SizeConfig.dart';
import 'Component/service_list.dart';
import 'Provider/service_provider_list.dart';

class ServicePage extends StatelessWidget {
  bool backbutton;

  ServicePage(this.backbutton);

  late ServiceProvider _serviceProvider;

  Debouncer _debouncer = Debouncer();

  int typeFliter = 2;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _serviceProvider = context.read<ServiceProvider>();
    return CustomAppBarWidget(
        title: AppLocalizations.instance.text("Services"),
        leading: backbutton == false
            ? SizedBox()
            : IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
        // floatingActionWidget: FloatingActionButton(
        //   // isExtended: true,
        //   child: Icon(Icons.add),
        //   backgroundColor: PrimaryColor,
        //   onPressed: () {
        //     DialogUtils.showMyDialog(
        //       context,
        //       onDoneFunction: () async {
        //         _launchURL();
        //         Navigator.pop(context);
        //       },
        //       oncancelFunction: () => Navigator.pop(context),
        //       title: 'Add Service',
        //       alertTitle: "Add Service Message",
        //       btnText: "Done",
        //     );
        //   },
        // ),
        floatingActionWidget: SizedBox(),
        actions: SizedBox(),
        child: Column(
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
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: CommanSearchBar(
                  onTextChange: (val) {
                    _serviceProvider.searchList(val);
                  },
                  IconName: PopMenuBar(
                    iconsName: Icons.filter_list,
                    val: typeFliter,
                    containerDecoration: 1,
                    onDoneFunction: (value) {
                      switch (value) {
                        case 1:
                          typeFliter = 1;
                          _serviceProvider.resetList();
                          _serviceProvider.fliterList("true");
                          break;
                        case 2:
                          typeFliter = 2;
                          _serviceProvider.resetList();
                          _serviceProvider.fliterList("false");
                      }
                    },
                    userMenuItems: [
                      ['Archived', 1],
                      ['Unarchived', 2],
                    ],
                  ),
                )),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            ServiceListPage(),
          ],
        ));
  }
}
