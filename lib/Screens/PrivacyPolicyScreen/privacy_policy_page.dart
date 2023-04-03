import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:my_truck_dot_one/Screens/PrivacyPolicyScreen/privacy_policy_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Custom_App_Bar_Widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/SizeConfig.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyPage extends StatelessWidget {
  late PrivacyPolicyProvider _policyProvider;
  String type;

  PrivacyPolicyPage({required this.type});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _policyProvider = context.read<PrivacyPolicyProvider>();

    _policyProvider.hitPrivacyPolicy(type);
    return CustomAppBarWidget(
        title: type == "TERMSUSE"
            ?AppLocalizations.instance.text('Term of Use')
            : type == "POLICY"
                ? AppLocalizations.instance.text('Privacy Policy')
                : AppLocalizations.instance.text('Term of Condition'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        floatingActionWidget: SizedBox(),
        actions: SizedBox(),
        child: Consumer<PrivacyPolicyProvider>(builder: (_, proData, __) {
          if (proData.loader) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (proData.privacyPolicyModel!.data == null)
            return Center(
                child: Text(AppLocalizations.instance.text('No Record Found')));
          else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizeConfig.screenHeight! < 1010
                      ? SizedBox(
                          height: Platform.isIOS
                              ? SizeConfig.safeBlockVertical! * 16
                              : SizeConfig.safeBlockVertical! *
                                  12, //10 for example
                        )
                      : SizedBox(
                          height: Platform.isIOS
                              ? SizeConfig.safeBlockVertical! * 9
                              : SizeConfig.safeBlockVertical! *
                                  9, //10 for example
                        ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Html(
                        data: proData.privacyPolicyModel!.data!.description
                            .toString(),
                        style: {
                          "body": Style(
                              fontSize: FontSize(14.0),
                              textAlign: TextAlign.justify),
                        }),
                  ),
                ],
              ),
            );
          }
        }));
  }
}
