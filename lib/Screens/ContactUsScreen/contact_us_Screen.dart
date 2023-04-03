import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/ContactUsScreen/provider/contact_us_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';

import 'package:provider/src/provider.dart';

import 'component/contact_us_form.dart';


class ContactPage extends StatelessWidget {
  @override
  late ContactProvider _contactProvider;
  Widget build(BuildContext context) {
    _contactProvider = context.read<ContactProvider>();
    return Scaffold(
        backgroundColor: APP_BG,
        appBar: AppBar(
          backgroundColor: APP_BAR_BG,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          title: Text(AppLocalizations.instance.text("Contact Information")),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(1),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Text(AppLocalizations.instance.text("Just Write Us Here"),style: TextStyle(color: PrimaryColor,fontSize:20,fontWeight: FontWeight.w800),),
                SizedBox(height: 10,),
                Center(child: Text(AppLocalizations.instance.text("Interested for custom plan or any question"),style: TextStyle(fontSize:18))),
                SizedBox(height: 10,),
                ContactForm(),
              ],
            ),
          ),
        ));
  }
}
