import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Fleet_Manager_Screen/DispatcherFleetManager/Fleet_Manager.dart';
import 'package:my_truck_dot_one/Screens/Fleet_Manager_Screen/Provider/fleet_manager_provider.dart';
import 'package:my_truck_dot_one/Screens/Fleet_Manager_Screen/view_fleet_Screen/Provider/View_fleet_Manger_Provider.dart';
import 'package:my_truck_dot_one/Screens/Home/company_home_page.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/JobList/CompanyJob/JobList.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/JobList/UserComponent/UserJobList.dart';
import 'package:my_truck_dot_one/Screens/MenuScreen/CompanyMenuPage.dart';
import 'package:my_truck_dot_one/Screens/MenuScreen/DispatcherMenuPage.dart';
import 'package:my_truck_dot_one/Screens/MenuScreen/DriverMenuPage.dart';
import 'package:my_truck_dot_one/Screens/MenuScreen/HrMenuPage.dart';
import 'package:my_truck_dot_one/Screens/MenuScreen/SalePersonMenu.dart';
import 'package:my_truck_dot_one/Screens/MenuScreen/SellerMenuPage.dart';
import 'package:my_truck_dot_one/Screens/MenuScreen/UserMenuPage.dart';
import 'package:my_truck_dot_one/Screens/NotificationScreen/notification_list.dart';
import 'package:my_truck_dot_one/Screens/SellerScreen/seller_manage_product_screen/manage_product_screen.dart';
import 'package:my_truck_dot_one/Screens/SellerScreen/seller_rating_screen/Provider/seller_rating_provider.dart';
import 'package:my_truck_dot_one/Screens/SellerScreen/seller_rating_screen/Seller_Rating_Screen.dart';
import 'package:my_truck_dot_one/Screens/Seller_Dashboard_Screen/seller_home_screen.dart';
import 'package:my_truck_dot_one/Screens/ServiceScreen/User/Provider/user_service_provider.dart';
import 'package:my_truck_dot_one/Screens/ServiceScreen/User/service_page.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/Dispatcher_Screen/Dispatche_main_Screen.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/UserTripPlannerScreen/UserTripPlannerList.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:my_truck_dot_one/Screens/team_manage_Screen%20/company_team_manage/Provider/team_manger_provider.dart';
import 'package:my_truck_dot_one/Screens/team_manage_Screen%20/company_team_manage/company_team_mange_component/team_manage_screen.dart';
import 'package:my_truck_dot_one/Screens/team_manage_Screen%20/seller_manage_team/seller_manage_team_component/seller_manage_Screen.dart';
import 'package:my_truck_dot_one/Screens/team_manage_Screen%20/Dispatcher_team_manage/team_manage_screen.dart';
import 'package:provider/provider.dart';
import '../../AppUtils/UserInfo.dart';
import '../Home/Provider/home_page_list_provider.dart';
import '../SellerScreen/provider/seller_dash_bord_provider.dart';
import '../team_manage_Screen /Provider/manage_team_provider.dart';
import 'Component/BottomNavigationComponent.dart';
import 'Provider/bottom_provider.dart';

class BottomMenu extends StatefulWidget {
  final type;
  final tabber;

  BottomMenu(
    this.type,
    this.tabber, {
    Key? key,
  });

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  late BottomProvider _bottomProvider;
  late HomePageListProvider _homePageListProvider;

  @override
  void initState() {
    print("dasjhasdjkhdajkh${widget.type}");
    // TODO: implement initState
    _bottomProvider = context.read<BottomProvider>();
    _bottomProvider.menuClick = widget.tabber;
    _homePageListProvider = context.read<HomePageListProvider>();
    _homePageListProvider.totalCount = 0;

    _bottomProvider.getChatSocket(context);
    _bottomProvider.getlocalLanguage();
    // _homePageListProvider.hitNotificationCount(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xFFEEEEEE),
          body: Container(
            child: Column(
              children: [
                Selector<BottomProvider, int>(
                    selector: (_, provider) => provider.menuClick,
                    builder: (context, menuClick, child) {
                      return Expanded(
                        child: Container(
                          color: Color(0xFFEEEEEE),
                          child: menuWidget(context,
                              _bottomProvider.language.toString(), menuClick),
                        ),
                      );
                    }),
                Selector<HomePageListProvider, int>(
                    selector: (_, provider) => provider.totalCount,
                    builder: (context, totalNotification, child) {
                      return Container(
                          height: 75,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                          ),
                          child: condationBottomMenu(totalNotification));
                    }),
              ],
            ),
          )),
    );
  }

  Future<bool> showExitPopup() async {
    return await DialogUtils.showMyDialog(
          context,
          onDoneFunction: () async {
            exit(0);
          },
          oncancelFunction: () => Navigator.of(context).pop(false),
          title: 'Exit App',
          alertTitle: "Exit App Message",
          btnText: "Yes",
        ) ??
        false;
  }

  menuWidget(BuildContext context, String language, int menuClick) {
    _homePageListProvider.getAccountDetail();
    if (widget.type == "User") {
      print(widget.type);
      switch (menuClick) {
        case 4:
          return UserMenuPage(_bottomProvider, language, "User");
        case 0:
          return MyHomePage();
        case 1:
          return NotificationList();
        case 2:
          return UserJobList();
        case 3:
          return ChangeNotifierProvider(
              create: (_) => UserServiceProvider(),
              child: UserServicePage(false));
      }

    } else if (widget.type == "Company") {
      switch (menuClick) {
        case 4:
          return CompanyMenuPage(_bottomProvider, language, "Company");
        case 0:
          return MyHomePage();
        case 1:
          return NotificationList();
        case 2:
          return JobList();
        case 3:
          return DispatcherScreen("company");
      }
    } else if (widget.type == "Dispatcher") {
      switch (menuClick) {
        case 4:
          return DispatcherMenuPage(_bottomProvider, language, "Dispatcher");
        case 0:
          return DispatcherScreen("Dispatcher");
        case 1:
          return NotificationList();
        case 2:
          return MultiProvider(providers: [
            ChangeNotifierProvider(create: (_) => FleetManagerProvider()),
            ChangeNotifierProvider(create: (_) => ViewFleetManagerProvider()),
          ], child: FleetManagerScreen());

        case 3:
          return ChangeNotifierProvider(
            create: (_) => ManageTeamProvider(),
            child: TeamManageScreen(),
          );
      }
    } else if (widget.type == "Seller") {
      switch (menuClick) {
        case 4:
          return SellerMenuPage(_bottomProvider, language, "Seller");
        case 0:
          return ChangeNotifierProvider(
              create: (_) => SellerDashBordProvider(), child: SellerHomePage());
        case 1:
          return NotificationList();
        case 2:
          return ChangeNotifierProvider(
              create: (_) => SellerRatingProvider(), child: SelleRating());

        case 3:
          return SellerManageScreen();
      }
    } else if (widget.type == "Hr") {
      switch (menuClick) {
        case 4:
          return HrMenuPage(_bottomProvider, language, "Hr");
        case 0:
          return MyHomePage();
        case 1:
          return NotificationList();
        case 2:
          return JobList();
        case 3:
          return ChangeNotifierProvider(
              create: (_) => ManagerTeamProvider(),
              child: CompanyTeamManageScreen(0, false));
      }
    } else if (widget.type == "Driver") {
      switch (menuClick) {
        case 4:
          return DriverMenuPage(_bottomProvider, language, "Driver");
        case 0:
          return MyHomePage();
        case 2:
          return UserJobList();
        case 1:
          return NotificationList();

        case 3:
          return UserTripPlanner();
      }
    } else if (widget.type == "Saleperson") {
      switch (menuClick) {
        case 4:
          return SalePersonMenu(_bottomProvider, language, "SalePerson");
        case 0:
          return ChangeNotifierProvider(
              create: (_) => SellerDashBordProvider(), child: SellerHomePage());
        case 2:
          return ManageProductScreen(true);
        case 1:
          return NotificationList();
        case 3:
          return ChangeNotifierProvider(
              create: (_) => SellerRatingProvider(), child: SelleRating());
      }
    }
  }

  condationBottomMenu(int totalNotification) {
    switch (widget.type) {
      case "Dispatcher":
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavigationComponent(
                0, 'Home', "Company_menu_image/tripPlanner.svg"),
            Stack(
              alignment: Alignment.topRight,
              children: [
                BottomNavigationComponent(
                    1, 'Notifications', "Company_menu_image/notifications.svg"),
                totalNotification == 0
                    ? SizedBox()
                    : Container(
                        width: 25,
                        height: 25,
                        margin: EdgeInsets.only(top: 1),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffc32c37),
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Center(
                              child: Text(
                                totalNotification > 99
                                    ? "99+"
                                    : totalNotification.toString(),
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            BottomNavigationComponent(
                2, 'Jobs', "Company_menu_image/fleetManager.svg"),
            BottomNavigationComponent(
                3, 'Navigation', "Company_menu_image/manageTeam.svg"),
            BottomNavigationComponent(4, 'Menu', "Company_menu_image/Menu.svg"),
          ],
        );

      case "Company":
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavigationComponent(0, 'Home', "Company_menu_image/home.svg"),
            Stack(
              alignment: Alignment.topRight,
              children: [
                BottomNavigationComponent(
                    1, 'Notifications', "Company_menu_image/notifications.svg"),
                totalNotification == 0
                    ? SizedBox()
                    : Container(
                        width: 25,
                        height: 25,
                        margin: EdgeInsets.only(top: 1),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffc32c37),
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Center(
                              child: Text(
                                totalNotification > 99
                                    ? "99+"
                                    : totalNotification.toString(),
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            BottomNavigationComponent(2, 'Jobs', "Company_menu_image/job.svg"),
            BottomNavigationComponent(
                3, 'Navigation', "Company_menu_image/tripPlanner.svg"),
            BottomNavigationComponent(4, 'Menu', "Company_menu_image/Menu.svg"),
          ],
        );

      case "User":
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavigationComponent(0, 'Home', "Company_menu_image/home.svg"),
            Stack(
              alignment: Alignment.topRight,
              children: [
                BottomNavigationComponent(
                    1, 'Notifications', "Company_menu_image/notifications.svg"),
                totalNotification == 0
                    ? SizedBox()
                    : Container(
                        width: 25,
                        height: 25,
                        margin: EdgeInsets.only(top: 1),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffc32c37),
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Center(
                              child: Text(
                                totalNotification > 99
                                    ? "99+"
                                    : totalNotification.toString(),
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            BottomNavigationComponent(2, 'Jobs', "Company_menu_image/job.svg"),
            BottomNavigationComponent(
                3, 'Navigation', "Company_menu_image/findService.svg"),
            BottomNavigationComponent(4, 'Menu', "Company_menu_image/Menu.svg"),
          ],
        );

      case "Seller":
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavigationComponent(
                0, 'Home', "Seller_menu_image/dashboard.svg"),
            Stack(
              alignment: Alignment.topRight,
              children: [
                BottomNavigationComponent(
                    1, 'Notifications', "Company_menu_image/notifications.svg"),
                totalNotification == 0
                    ? SizedBox()
                    : Container(
                        width: 25,
                        height: 25,
                        margin: EdgeInsets.only(top: 1),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffc32c37),
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Center(
                              child: Text(
                                totalNotification > 99
                                    ? "99+"
                                    : totalNotification.toString(),
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            BottomNavigationComponent(
                2, 'Jobs', "Seller_menu_image/myratings.svg"),
            BottomNavigationComponent(
                3, 'Navigation', "Company_menu_image/manageTeam.svg"),
            BottomNavigationComponent(4, 'Menu', "Company_menu_image/Menu.svg"),
          ],
        );
      case "Hr":
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavigationComponent(0, 'Home', "Company_menu_image/home.svg"),
            Stack(
              alignment: Alignment.topRight,
              children: [
                BottomNavigationComponent(
                    1, 'Notifications', "Company_menu_image/notifications.svg"),
                totalNotification == 0
                    ? SizedBox()
                    : Container(
                        width: 25,
                        height: 25,
                        margin: EdgeInsets.only(top: 1),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffc32c37),
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Center(
                              child: Text(
                                totalNotification > 99
                                    ? "99+"
                                    : totalNotification.toString(),
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            BottomNavigationComponent(2, 'Jobs', "Company_menu_image/job.svg"),
            BottomNavigationComponent(
                3, 'Navigation', "Company_menu_image/manageTeam.svg"),
            BottomNavigationComponent(4, 'Menu', "Company_menu_image/Menu.svg"),
          ],
        );

      case "Driver":
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavigationComponent(0, 'Home', "Company_menu_image/home.svg"),
            Stack(
              alignment: Alignment.topRight,
              children: [
                BottomNavigationComponent(
                    1, 'Notifications', "Company_menu_image/notifications.svg"),
                totalNotification == 0
                    ? SizedBox()
                    : Container(
                        width: 25,
                        height: 25,
                        margin: EdgeInsets.only(top: 1),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffc32c37),
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Center(
                              child: Text(
                                totalNotification > 99
                                    ? "99+"
                                    : totalNotification.toString(),
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            BottomNavigationComponent(2, 'Jobs', "Company_menu_image/job.svg"),
            BottomNavigationComponent(
                3, 'Navigation', "Company_menu_image/tripPlanner.svg"),
            BottomNavigationComponent(4, 'Menu', "Company_menu_image/Menu.svg"),
          ],
        );
      case "Saleperson":
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavigationComponent(0, 'Home', "Company_menu_image/home.svg"),
            Stack(
              alignment: Alignment.topRight,
              children: [
                BottomNavigationComponent(
                    1, 'Notifications', "Company_menu_image/notifications.svg"),
                totalNotification == 0
                    ? SizedBox()
                    : Container(
                        width: 25,
                        height: 25,
                        margin: EdgeInsets.only(top: 1),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffc32c37),
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Center(
                              child: Text(
                                totalNotification > 99
                                    ? "99+"
                                    : totalNotification.toString(),
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            BottomNavigationComponent(2, '${'Q&A' + "'" + 's'}',
                "Seller_menu_image/manageProduct.svg"),
            BottomNavigationComponent(
                3, 'MyRating', "Seller_menu_image/myratings.svg"),
            BottomNavigationComponent(4, 'Menu', "Company_menu_image/Menu.svg"),
          ],
        );
    }
  }
}
