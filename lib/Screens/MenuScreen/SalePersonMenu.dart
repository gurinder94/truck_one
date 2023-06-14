import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/AppUtils/data_items.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Screens/BottomMenu/Provider/bottom_provider.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/Seller_Chat_Screen/seller_chat_provider.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/salerperson_chat.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/seller_chat.dart';
import 'package:my_truck_dot_one/Screens/DeactivateAccountScreen/Provider/Deactivate_provider.dart';
import 'package:my_truck_dot_one/Screens/MenuScreen/company_setting_screen.dart';
import 'package:my_truck_dot_one/Screens/ContactUsScreen/contact_us_Screen.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/Provider/UserProfileProvider.dart';
import 'package:my_truck_dot_one/Screens/SellerScreen/seller_product_question_screen/Provider/seller_product_question%20_answer.dart';
import 'package:my_truck_dot_one/Screens/SellerScreen/seller_product_question_screen/seller_question_screen.dart';
import 'package:my_truck_dot_one/Screens/SellerScreen/seller_support_screen/Provider/support_information_provider.dart';
import 'package:my_truck_dot_one/Screens/SellerScreen/seller_support_screen/Seller_support_information.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ApiCall/api_Call.dart';
import '../../AppUtils/UserInfo.dart';
import '../ChatScreen/provider/chat_home_provider.dart';
import '../ContactUsScreen/provider/contact_us_provider.dart';
import '../Language_Screen/application_localizations.dart';
import '../LoginScreen/LoginScreen.dart';
import 'Component/UserTopProfile.dart';

class SalePersonMenu extends StatefulWidget {
  BottomProvider bottomProvider;
  String language;
  String roleName;

  SalePersonMenu(this.bottomProvider, this.language, this.roleName, {Key? key})
      : super(key: key);

  @override
  _SalePersonMenuState createState() => _SalePersonMenuState();
}

class _SalePersonMenuState extends State<SalePersonMenu> {
  late Size size;

  bool loading=false;
  ResponseModel? _responseModel;

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
          listOfOptions('LogOut', 'icons/logout.svg', 3),
        ])));
  }

  gridMenuList(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: size.width < 800 ? (300 / 100) : (300 / 50),
      crossAxisCount: 2,
      crossAxisSpacing: 7,
      mainAxisSpacing: 7,
      padding: EdgeInsets.all(5),
      shrinkWrap: true,
      children: List.generate(salePersonMenuItems.length, (index) {
        return menuItem(salePersonMenuItems[index], context);
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
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(5, 5)),
              BoxShadow(
                  color: Colors.white,
                  blurRadius: 2,
                  offset: Offset(-3, -3))

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
                style:
                TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),
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
                        style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black54),
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
                    builder: (context) =>  CompanySettingPage(widget.language)));
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


openMenuItems(String title, BuildContext context) {
  switch (title) {
    case "Support Information":
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  create: (_) => SupportInformationProvider(),
                  child: SellerSupportScreen())));
      break;
    case 'Chat':
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MultiProvider(providers: [
              ChangeNotifierProvider(create: (_) => SellerChatProvider()),
              ChangeNotifierProvider(create: (_) => ChatHomeProvider()),
            ], child: SalePerson())));
    break;
    case 'Q&A':
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  create: (_) => SellerProductQuestionProvider(),
                  child: SellerQuestionScreen())));
      break;
  }


}
