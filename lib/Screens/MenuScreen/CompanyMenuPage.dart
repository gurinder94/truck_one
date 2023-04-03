import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/AppUtils/data_items.dart';
import 'package:my_truck_dot_one/Screens/BottomMenu/Provider/bottom_provider.dart';
import 'package:my_truck_dot_one/Screens/DeactivateAccountScreen/Provider/Deactivate_provider.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/e-commerce_category_Screen/Provider/category_provider.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/e-commerce_category_Screen/home_page_ecommerce.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/wishlist_screen/Provider/wishList_Provider.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/wishlist_screen/wishList_screen.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/EventListScreen/EventList.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/UserEventScreen/EventListScreen/Provider/UserEventTabBarProvider.dart';
import 'package:my_truck_dot_one/Screens/Fleet_Manager_Screen/Provider/fleet_manager_provider.dart';
import 'package:my_truck_dot_one/Screens/Fleet_Manager_Screen/CompanyFleetManager/company_fleet_manager_screen.dart';
import 'package:my_truck_dot_one/Screens/Fleet_Manager_Screen/view_fleet_Screen/Provider/View_fleet_Manger_Provider.dart';
import 'package:my_truck_dot_one/Screens/MenuScreen/company_setting_screen.dart';
import 'package:my_truck_dot_one/Screens/ContactUsScreen/contact_us_Screen.dart';
import 'package:my_truck_dot_one/Screens/Network/network_page/network_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/network_page/network_page.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/provider/ProfileProvider.dart';
import 'package:my_truck_dot_one/Screens/ServiceScreen/Company/Provider/service_provider_list.dart';
import 'package:my_truck_dot_one/Screens/ServiceScreen/Company/service_page.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:my_truck_dot_one/Screens/team_manage_Screen%20/company_team_manage/company_team_mange_component/team_manage_screen.dart';
import 'package:provider/provider.dart';
import '../ChatScreen/chat_home_Page.dart';
import '../ChatScreen/provider/chat_home_provider.dart';
import '../ContactUsScreen/provider/contact_us_provider.dart';
import '../Language_Screen/application_localizations.dart';
import '../team_manage_Screen /company_team_manage/Provider/team_manger_provider.dart';
import 'Component/TopProfileWidget.dart';

class CompanyMenuPage extends StatefulWidget {
  BottomProvider bottomProvider;
  String language;
  String roleName;

  CompanyMenuPage(
    this.bottomProvider,
    this.language,
    this.roleName, {
    Key? key,
  });

  @override
  _CompanyMenuPage createState() => _CompanyMenuPage();
}

class _CompanyMenuPage extends State<CompanyMenuPage> {
  late Size size;

  get checkBoxValue => true;

  void initState() {}

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
              child: Column(children: [
            SizedBox(
              height: 40,
            ),
            ChangeNotifierProvider(
              create: (_) => ProfileProvider(),
              child: TopProfileWidget(widget.roleName.toString()),
            ),
            SizedBox(
              height: 10,
            ),
            gridMenuList(context),
            SizedBox(
              height: 10,
            ),
            listOfOptions('Help & Support', 'icons/help.svg', 1),
            SizedBox(
              height: 10,
            ),
            listOfOptions('Setting & Privacy', 'icons/settings.svg', 2),
            SizedBox(
              height: 10,
            ),
            listOfOptions('LogOut', 'icons/logout.svg', 3),
            SizedBox(
              height: 30,
            ),
            appVersionShow()
          ]))),
    );
  }

  gridMenuList(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: size.width < 800 ? (300 / 85) : (300 / 50),
      crossAxisCount: 2,
      crossAxisSpacing: 7,
      mainAxisSpacing: 7,
      padding: EdgeInsets.all(5),
      shrinkWrap: true,
      children: List.generate(companyMenuItems.length, (index) {
        return menuItem(companyMenuItems[index], context, index);
      }),
    );
  }

  menuItem(List<String> companyMenuItems, BuildContext context, int index) {
    return GestureDetector(
      onTap: () => openMenuItems(index, context),
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5, top: 7, bottom: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 5, offset: Offset(5, 5)),
              BoxShadow(
                  color: Colors.white, blurRadius: 2, offset: Offset(-3, -3))
            ]),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            SvgPicture.asset(companyMenuItems[0],
                width: 25, height: 25, color: IconColor),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                AppLocalizations.instance.text(companyMenuItems[1]),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.black54),
              ),
            )
          ],
        ),
      ),
    );
  }

  listOfOptions(
    String title,
    String path,
    int i,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: GestureDetector(
        child: Container(
            margin: EdgeInsets.only(left: 5, right: 5, top: 7, bottom: 5),
            padding: EdgeInsets.all(10),
            child: Column(children: [
              Row(
                children: [
                  SvgPicture.asset(path,
                      width: 25, height: 25, color: IconColor),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                    AppLocalizations.instance.text(title),
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black54),
                  )),
                  Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ]),
            decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(5, 5)),
                  BoxShadow(
                      color: Colors.white,
                      blurRadius: 2,
                      offset: Offset(-3, -3))
                ])),
        onTap: () async {
          if (i == 3) {
            DialogUtils.showMyDialog(
              context,
              onDoneFunction: () async {
                widget.bottomProvider.hitlogOut(context);
              },
              oncancelFunction: () => Navigator.pop(context),
              title: 'Logout',
              alertTitle: "Logout Message",
              btnText: "Done",
            );
          }
          if (i == 2) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                        create: (_) => DeactivateProvider(),
                        child: CompanySettingPage(widget.language))));
          }

          if (i == 1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                        create: (_) => ContactProvider(),
                        child: ContactPage())));
          }
        },
      ),
    );
  }

  openMenuItems(int title, BuildContext context) {
    switch (title) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MultiProvider(providers: [
                      ChangeNotifierProvider(
                          create: (_) => UserEventTabBarProvider()),
                    ], child: EventList())));
        break;
      case 5:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (_) => NetworkProvider(), child: NetworkPage(0))));
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (_) => ServiceProvider(),
                    child: ServicePage(true))));
        break;
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (_) => CategoryProvider(),
                    child: HomePageEcommerce())));
        break;
      case 6:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MultiProvider(providers: [
                      ChangeNotifierProvider(
                          create: (_) => FleetManagerProvider()),
                      ChangeNotifierProvider(
                          create: (_) => ViewFleetManagerProvider()),
                    ], child: CompanyFleetManagerPage())));

        break;
      case 7:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                      create: (_) => ManagerTeamProvider(),
                      child: CompanyTeamManageScreen(0, true),
                    )));

        break;
      case 3:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (_) => WishListProvider(),
                    child: WishListScreen())));
        break;
      case 4:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (_) => ChatHomeProvider(),
                    child: ChatHomePage(0))));
        break;
      default:
    }
  }

  appVersionShow() {
    return Text(
      "App Version: ${AppversionName.toString()}",
      style: TextStyle(color: Colors.black54, fontSize: 14),
    );
  }
}
