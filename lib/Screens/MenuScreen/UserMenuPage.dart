import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/AppUtils/data_items.dart';
import 'package:my_truck_dot_one/Screens/BottomMenu/Provider/bottom_provider.dart';
import 'package:my_truck_dot_one/Screens/DeactivateAccountScreen/Provider/Deactivate_provider.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/e-commerce_category_Screen/Provider/category_provider.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/e-commerce_category_Screen/home_page_ecommerce.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/wishlist_screen/Provider/wishList_Provider.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/wishlist_screen/wishList_screen.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/UserEventScreen/EventListScreen/EventList.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/UserEventScreen/EventListScreen/Provider/UserEventListProvider.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/UserEventScreen/EventListScreen/Provider/UserEventTabBarProvider.dart';
import 'package:my_truck_dot_one/Screens/Fleet_Manager_Screen/Provider/fleet_manager_provider.dart';
import 'package:my_truck_dot_one/Screens/Fleet_Manager_Screen/view_fleet_Screen/Provider/View_fleet_Manger_Provider.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/JobList/CompanyJob/JobList.dart';
import 'package:my_truck_dot_one/Screens/ContactUsScreen/contact_us_Screen.dart';
import 'package:my_truck_dot_one/Screens/Network/network_page/network_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/network_page/network_page.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/Provider/UserProfileProvider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../AppUtils/UserInfo.dart';
import '../ChatScreen/chat_home_Page.dart';
import '../ChatScreen/provider/chat_home_provider.dart';
import '../ContactUsScreen/provider/contact_us_provider.dart';
import '../Fleet_Manager_Screen/CompanyFleetManager/company_fleet_manager_screen.dart';
import '../Gps_Screen/GpsScreen.dart';
import '../MyPlanScreen/my_plan_provider.dart';
import '../MyPlanScreen/my_plan_screen.dart';
import '../PricingScreen/Pricing_Screen.dart';
import '../PricingScreen/Provider/Pricing_provider.dart';
import '../Language_Screen/application_localizations.dart';
import 'Component/UserTopProfile.dart';
import 'company_setting_screen.dart';

class UserMenuPage extends StatefulWidget {
  BottomProvider bottomProvider;
  String language;
  String roleName;

  UserMenuPage(
    this.bottomProvider,
    this.language,
    this.roleName, {
    Key? key,
  });

  @override
  _UserMenuPageState createState() => _UserMenuPageState();
}

class _UserMenuPageState extends State<UserMenuPage> {
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // TODO: implement build
    return Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 40,
          ),
          ChangeNotifierProvider(
            create: (_) => UserProfileProvider(),
            child: UserTopProfileWidget(widget.roleName.toString()),
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
        ])));
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
      children: List.generate(userMenuItems.length, (index) {
        return menuItem(userMenuItems[index], context);
      }),
    );
  }

  menuItem(List<String> userMenuItems, BuildContext context) {
    return GestureDetector(
      onTap: () => openMenuItems(userMenuItems[1], context),
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
            SvgPicture.asset(
              userMenuItems[0],
              height: 25,
              width: 25,
              color: userMenuItems[2] == "1"
                  ? IconColor
                  : IconColor.withOpacity(0.2),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                AppLocalizations.instance.text(userMenuItems[1]),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: userMenuItems[2] == "1"
                      ? IconColor
                      : IconColor.withOpacity(0.2),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  listOfOptions(String title, String path, int i) {
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

  openMenuItems(String title, BuildContext context) async {
    var GpsPlanuser = await getGpsPlanData();
    switch (title) {
      case 'Events':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MultiProvider(providers: [
                      ChangeNotifierProvider(
                          create: (_) => UserEventTabBarProvider()),
                      ChangeNotifierProvider(
                        create: (_) => UserEventListProvider(),
                      ),
                    ], child: UserEventList())));
        break;
      case 'Jobs':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => JobList()));
        break;

      case 'My Network':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (_) => NetworkProvider(), child: NetworkPage(0))));

        break;
      case 'Trip Planner':
        DialogUtils.AlertBox(
          context,
          buttonTitle: "Ok",
          onDoneFunction: () async {
            Navigator.pop(context);
          },
          oncancelFunction: () {
            Navigator.pop(context);
          },
          title: AppLocalizations.instance.text('Trip Planner!'),
          alertTitle: AppLocalizations.instance.text('userEnd'),
          btnText: "Done",
        );
        break;

      case 'Services':
        DialogUtils.AlertBox(
          context,
          buttonTitle: "Ok",
          onDoneFunction: () async {
            Navigator.pop(context);
          },
          oncancelFunction: () {
            Navigator.pop(context);
          },
          title: 'Services!',
          alertTitle: AppLocalizations.instance.text('userEnd'),
          btnText: "Done",
        );

        break;
      case 'Manage Team':
        DialogUtils.AlertBox(
          context,
          buttonTitle: "Ok",
          onDoneFunction: () async {
            Navigator.pop(context);
          },
          oncancelFunction: () {
            Navigator.pop(context);
          },
          title: AppLocalizations.instance.text('Manage Team !'),
          alertTitle: AppLocalizations.instance.text('userEnd'),
          btnText: "Done",
        );
        break;

      case 'E-Commerce':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (_) => CategoryProvider(),
                    child: HomePageEcommerce())));

        break;
      case 'WishList':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (_) => WishListProvider(),
                    child: WishListScreen())));
        break;
      case 'Chat':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (_) => ChatHomeProvider(),
                    child: ChatHomePage(0))));
        break;
      case 'Fleet Manager':
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
      case 'GPS Navigation':
        GpsPlanuser == true
            ? Navigator.push(
                context, MaterialPageRoute(builder: (context) => GpsScreen()))
            : DialogUtils.showMyDialog(
                context,
                onDoneFunction: () async {
                  Navigator.pop(context);
                },
                oncancelFunction: () => Navigator.pop(context),
                title: 'Buy Plan!',
                alertTitle: 'Pricing Price',
                btnText: "Done",
              );
        break;
      case 'Buy Now':
        return DialogUtils.showMySuccessful(context,
            child: AlertDialog(
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              title: Column(
                children: [
                  Text(
                    "Purchase",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                      "We would like you to enable in app purchase from your device setting."
                      "\nGo to Settings>Screen Time > Content & Privacy Restriction > Enable."
                      "Now click on iTunes & App Store Purchases > In-app Purchase> Allow.",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal)),
                ],
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    splashColor: PrimaryColor,
                    highlightColor: Colors.white,
                    child: Text(
                      "Ok",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    onTap: () async {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PricingScreen()));
                    },
                  ),
                ),
              ],
            ));

        break;
      // case 'My Plan':
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => ChangeNotifierProvider(
      //               create: (_) => MyPlanProvider(), child: MyPlanScreen())));
    }
  }

  appVersionShow() {
    return Text(
      "App Version: ${AppversionName.toString()}",
      style: TextStyle(color: Colors.black54, fontSize: 14),
    );
  }
}

_launchURL() async {
  String url = "https://mytruck.one/home-page";
  print(url);
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not launch $url');
    throw 'Could not launch $url';
  }
}
