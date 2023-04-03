import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/user_detail_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';

class ProfileAbout extends StatelessWidget {
  UserDetailProvider provider;

  ProfileAbout(this.provider);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppLocalizations.instance.text("About"),
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(provider.model.data!.aboutCompany.toString(),textAlign:TextAlign.justify,style: TextStyle(fontSize: 14)),
      ],
    );
  }
}
