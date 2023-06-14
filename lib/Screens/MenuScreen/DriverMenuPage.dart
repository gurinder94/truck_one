import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/AppUtils/data_items.dart';
import 'package:my_truck_dot_one/Screens/BottomMenu/Provider/bottom_provider.dart';
import 'package:my_truck_dot_one/Screens/BottomMenu/bottom_menu.dart';
import 'package:my_truck_dot_one/Screens/DeactivateAccountScreen/Provider/Deactivate_provider.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/e-commerce_category_Screen/Provider/category_provider.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/e-commerce_category_Screen/home_page_ecommerce.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/wishlist_screen/Provider/wishList_Provider.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/wishlist_screen/wishList_screen.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/UserEventScreen/EventListScreen/EventList.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/UserEventScreen/EventListScreen/Provider/UserEventListProvider.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/UserEventScreen/EventListScreen/Provider/UserEventTabBarProvider.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/JobList/CompanyJob/JobList.dart';
import 'package:my_truck_dot_one/Screens/ContactUsScreen/contact_us_Screen.dart';
import 'package:my_truck_dot_one/Screens/Network/network_page/network_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/network_page/network_page.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/Provider/UserProfileProvider.dart';
import 'package:my_truck_dot_one/Screens/ServiceScreen/User/Provider/user_service_provider.dart';
import 'package:my_truck_dot_one/Screens/ServiceScreen/User/service_page.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ApiCall/api_Call.dart';
import '../../AppUtils/UserInfo.dart';
import '../../Model/NetworkModel/normal_response.dart';
import '../ChatScreen/chat_home_Page.dart';
import '../ChatScreen/provider/chat_home_provider.dart';
import '../ContactUsScreen/provider/contact_us_provider.dart';
import '../Language_Screen/application_localizations.dart';
import '../LoginScreen/LoginScreen.dart';
import 'Component/UserTopProfile.dart';
import 'company_setting_screen.dart';

class DriverMenuPage extends StatefulWidget {
  BottomProvider bottomProvider;
  String language;
  String roleName;

  DriverMenuPage(this.bottomProvider, this.language, this.roleName, {Key? key})
      : super(key: key);

  @override
  _DriverMenuPageState createState() => _DriverMenuPageState();
}

class _DriverMenuPageState extends State<DriverMenuPage> {
  late Size size;
  late ResponseModel _responseModel;
  bool loading = false;

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
            child: UserTopProfileWidget(widget.roleName),
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
          listOfOptions('Delete My Account', 'Company_menu_image/deleteAccount.svg', 3),
          SizedBox(
            height: 10,
          ),
          listOfOptions('LogOut', 'icons/logout.svg', 4),
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
      children: List.generate(DriverMenuItems.length, (index) {
        return menuItem(DriverMenuItems[index], context);
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
              color: IconColor,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                AppLocalizations.instance.text(userMenuItems[1]),
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
          if (i == 4) {
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
          if (i == 3) {
            DialogUtils.showMyDialog(
              context,
              onDoneFunction: () async {
                Navigator.pop(context);
                hitcDeactivateAccount();
              },
              oncancelFunction: () => Navigator.pop(context),
              title: 'Delete account',
              alertTitle: "Delete account message",
              btnText: "Done",
            );
          }
          if (i == 2) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CompanySettingPage(widget.language)));
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

  openMenuItems(String title, BuildContext context) {
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
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BottomMenu('Company', 3)),
            (Route<dynamic> route) => false);
        break;

      case 'Services':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (_) => UserServiceProvider(),
                    child: UserServicePage(true))));
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
    }
  }

  appVersionShow() {
    return Text(
      "App Version: ${AppversionName.toString()}",
      style: TextStyle(color: Colors.black54, fontSize: 14),
    );
  }

  hitcDeactivateAccount() async {
    var userId = await getUserId();
    Map<String, dynamic> map = {"id": userId};
    loading = true;
    setState(() {});

    try {
      print(map);
      _responseModel = await hitDeactivateAccountApi(map);

      showMessage('Account Delete Sucessfully');

      Navigator.of(navigatorKey.currentState!.context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false);
      final pref = await SharedPreferences.getInstance();
      await pref.clear();

      loading = false;
      setState(() {});
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(
        message,
      );
      loading = false;
      setState(() {});
    }
    loading = false;
    setState(() {});
  }
}
