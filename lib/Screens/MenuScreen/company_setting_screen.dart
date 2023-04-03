import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/AppUtils/data_items.dart';
import 'package:my_truck_dot_one/Screens/ActivityLogScreen/ActivityLog.dart';
import 'package:my_truck_dot_one/Screens/ChangePasswordScreen/change_password.dart';
import 'package:my_truck_dot_one/Screens/PrivacyPolicyScreen/privacy_policy_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';
import '../ActivityLogScreen/Provider/Activity_log_provider.dart';
import '../ChangePasswordScreen/Provider/change_password_provider.dart';

import '../DeactivateAccountScreen/Provider/Deactivate_provider.dart';
import '../LanguageScreen/Language_page.dart';
import '../PrivacyPolicyScreen/privacy_policy_page.dart';
import '../commanWidget/Comman_Alert_box.dart';
import '../commanWidget/Custom_App_Bar_Widget.dart';

class CompanySettingPage extends StatelessWidget {
  String language;

  CompanySettingPage(this.language);

  late DeactivateProvider _deactivateProvider;

  @override
  Widget build(BuildContext context) {
    _deactivateProvider = context.read<DeactivateProvider>();
    return CustomAppBarWidget(
        title: AppLocalizations.instance.text("Setting & Privacy"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        floatingActionWidget: SizedBox(),
        actions: SizedBox(),
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: settingEnglish.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      return listOfOptions(
                          settingEnglish[index][0],
                          settingEnglish[index][1],
                          index,
                          context,
                          language,
                          _deactivateProvider);
                    }))
          ],
        ));
  }
}

listOfOptions(
  String path,
  String title,
  int i,
  BuildContext context,
  String language,
  DeactivateProvider deactivateProvider,
) {
  return Padding(
    padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
    child: GestureDetector(
      child: Container(
          margin: EdgeInsets.only(left: 5, right: 5, top: 7, bottom: 5),
          padding: EdgeInsets.all(10),
          child: Column(children: [
            Row(
              children: [
                SvgPicture.asset(path, width: 25, height: 25, color: IconColor),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Text(
                  AppLocalizations.instance.text(
                    title,
                  ),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.4)),
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
                    color: Colors.black12, blurRadius: 5, offset: Offset(5, 5)),
                BoxShadow(
                    color: Colors.white, blurRadius: 2, offset: Offset(-3, -3))
              ])),
      onTap: () async {
        switch (i) {
          case 0:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                        create: (_) => ChangePasswordProvider(),
                        child: ChangePassword())));
            break;
          case 1:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                        create: (_) => ActivityLogProvider(),
                        child: Activity())));
            break;

          case 2:
            showDialog(
                context: context,
                barrierColor: Colors.black.withOpacity(0.5),
                barrierDismissible: true,
                builder: (context) => LanguagePage(language));
            break;
          case 3:
            DialogUtils.showMyDialog(
              context,
              onDoneFunction: () async {
                Navigator.pop(context);
                deactivateProvider.hitcDeactivateAccount();
              },
              oncancelFunction: () => Navigator.pop(context),
              title: 'Delete account',
              alertTitle: "Delete account message",
              btnText: "Done",
            );
            break;
          case 4:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                        create: (_) => PrivacyPolicyProvider(),
                        child: PrivacyPolicyPage(
                          type: "POLICY",
                        ))));

            break;
        }
      },
    ),
  );
}
