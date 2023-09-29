import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Home/Component/pagination_widget.dart';
import 'package:my_truck_dot_one/Screens/ServiceScreen/User/compoment/user_service_item.dart';
import 'package:my_truck_dot_one/Screens/ServiceScreen/View_Service_Page/provider/view_service_provider.dart';
import 'package:my_truck_dot_one/Screens/ServiceScreen/View_Service_Page/view_service.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/pop_menu_Widget.dart';
import 'package:my_truck_dot_one/commonUI/loading_shimmer.dart';
import 'package:provider/provider.dart';
import '../../commanWidget/Custom_App_Bar_Widget.dart';
import '../../commanWidget/Search_bar.dart';
import '../../commanWidget/SizeConfig.dart';
import 'Provider/user_service_provider.dart';

class UserServicePage extends StatelessWidget {
  @override
  bool backbutton;

  UserServicePage(this.backbutton);

  late UserServiceProvider _serviceProvider;

  String searchText = '';

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _serviceProvider = context.read<UserServiceProvider>();

    return CustomAppBarWidget(
        title: AppLocalizations.instance.text('Services'),
        leading: backbutton == false
            ? SizedBox()
            : IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
        floatingActionWidget: SizedBox(),
        actions: SizedBox(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CommanSearchBar(
                    onTextChange: (val) {
                      _serviceProvider.serviceListSearch(val);
                    },
                    IconName: Selector<UserServiceProvider, bool>(
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
                                  },
                                )
                              : Container(
                                  child: PopMenuBar(
                                      val: 1,
                                      iconsName: Icons.more_vert,
                                      userMenuItems: [
                                        ['50 Miles', 1],
                                        ['100 Miles', 2],
                                        ['150 Miles', 3],
                                        ['200 Miles', 4]
                                      ],
                                      containerDecoration: 1,
                                      onDoneFunction: (value) {
                                        switch (value) {
                                          case 1:
                                            _serviceProvider.ResetList();

                                            _serviceProvider.distanceSearch(50);

                                            break;
                                          case 2:
                                            _serviceProvider.ResetList();

                                            _serviceProvider.distanceSearch(100);

                                            break;
                                          case 3:
                                            _serviceProvider.ResetList();

                                            _serviceProvider.distanceSearch(150);

                                            break;
                                          case 4:
                                            _serviceProvider.ResetList();

                                            _serviceProvider.distanceSearch(200);

                                            break;
                                        }
                                      }),
                                );
                        }),
                  )),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),

            Consumer<UserServiceProvider>(builder: (context, noti, child) {
              print('Loading>>> ${noti.loading}');
              if (noti.loading) {

                return Expanded(child: serviceListListLoading());
              }
              if (noti.serviceList.length == 0 && noti.loading==false)
                return Column(
                  children: [

                    SizedBox(
                      height: 200,
                    ),
                    Center(
                        child: Text(
                      AppLocalizations.instance.text('No Record Found'),
                    )),
                  ],
                );
              else {
                return Expanded(
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: noti.serviceList.length,
                              padding: EdgeInsets.zero,
                              controller: _serviceProvider.scrollController,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  child: UserServiceItem(
                                      noti, index, noti.serviceList),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChangeNotifierProvider(
                                                  create: (_) =>
                                                      ViewServiceProvider(),
                                                  child: ViewServiceScreen(noti
                                                      .serviceList[index].id
                                                      .toString()),
                                                )));
                                  },
                                );
                              })),
                      SizedBox(
                          height: 25,
                          child: PaginationWidget(noti.PaginationLoader))
                    ],
                  ),
                );
              }
            }),
          ],
        ));
  }
}
