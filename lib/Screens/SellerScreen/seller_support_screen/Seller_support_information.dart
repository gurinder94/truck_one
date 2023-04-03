import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customapp.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Provider/support_information_provider.dart';

class SellerSupportScreen extends StatelessWidget {

late SupportInformationProvider  supportInformationProvider;
// "Support Information": "ਸਹਾਇਤਾ ਜਾਣਕਾਰੀ",
// "Support first line": "ਤੁਸੀਂ ਸਾਨੂੰ 'ਤੇ ਲਿਖ ਸਕਦੇ ਹੋ",
// "Support second line": "ਐਡਮਿਨ ਲਈ ਮੇਲ ਭੇਜੋ।",
// "Support third line": "ਜੇਕਰ ਤੁਹਾਡੇ ਕੋਲ ਇਸ ਪਲੇਟਫਾਰਮ
  @override
  Widget build(BuildContext context) {
    supportInformationProvider =
        context.read<SupportInformationProvider>();
    return CustomAppBar(
      visual: false,
      title: AppLocalizations.instance.text('Support Information'),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
         // _launchEmail();
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),

                child: RichText(
                  text:  TextSpan(
                    text:AppLocalizations.instance.text('Support first line'),
                    style: TextStyle(color:Colors.black,
                    ),
                    children: <TextSpan>[
                       TextSpan(
                           text:AppLocalizations.instance.text('Support second line'),
                          style: TextStyle(color:PrimaryColor,fontWeight: FontWeight.bold,
                          ),
                           recognizer:new TapGestureRecognizer()
                             ..onTap = ()=>_launchEmail()),
                       TextSpan(

                           text:AppLocalizations.instance.text('Support third line'),
                           style: TextStyle(color:Colors.black,) ),

                    ],
                  ),
                )

              ,
              decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(5, 5)),
                    BoxShadow(
                        color: Colors.white,
                        blurRadius: 4,
                        offset: Offset(-5, -5))
                  ]),
            ),

          ],
        ),
      ),
    );
  }
String email="Support@mytruck.one";
_launchEmail() async {
  if (await canLaunch("mailto:$email")) {
    await launch("mailto:$email");
  } else {
    throw 'Could not launch';
  }
}


}
