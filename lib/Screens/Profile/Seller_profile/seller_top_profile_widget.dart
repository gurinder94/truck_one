import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import 'Provider/profile_view_provider.dart';
import 'Seller_profile_screen.dart';

class SellerTopProfile extends StatelessWidget {
  @override
  String? name;
  String? getId;
  String roleName;

  SellerTopProfile(this.roleName);

  Widget build(BuildContext context) {
    // getName();
    var profileProvider = Provider.of<SellerProfileProvider>(context);
    profileProvider.getvalueSharedPreferences();
    profileProvider.getProfileImageSharedPreferences();

    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          profileProvider.getName == ''
              ? SizedBox(
                  width: 50, height: 40, child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 170,
                      child: Text(
                          showCapitalize(profileProvider.getName.toString()),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              color: Color(0xff101010),
                              fontWeight: FontWeight.bold,
                              fontSize: 25)),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "${AppLocalizations.instance.text('Logged in as')} ${roleName}",
                      style:
                          TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    GestureDetector(
                      child: Text(
                        AppLocalizations.instance.text('profileText'),
                        style:
                            TextStyle(color: Color(0xFF044a87), fontSize: 14),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (_) => SellerProfileProvider(),
                              child: SellerProfile(),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
          Container(
            padding: EdgeInsets.all(5),
            child: CircularPercentIndicator(
              radius: 30.0,
              lineWidth: 5.0,
              percent: profileProvider.precentindicate.toDouble(),
              animation: true,
              backgroundWidth: 8,
              backgroundColor: Colors.blue.shade400,
              center: new Text(
                profileProvider.ProgressBar.toString() + "%",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
              progressColor: PrimaryColor,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFEEEEEE),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFD9D8D8),
                    offset: Offset(5.0, 5.0),
                    blurRadius: 3,
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(.5),
                    offset: Offset(-5.0, -5.0),
                    blurRadius: 4,
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  getName() async {
    name = await getNameInfo();
  }
}

// return Padding(
// padding: const EdgeInsets.all(10),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// padding: EdgeInsets.all(3),
// clipBehavior: Clip.antiAlias,
// child: Container(
// clipBehavior: Clip.antiAlias,
// child: Image.network(
// IMG_URL+
// profileProvider.getProfileImage.toString(),
// fit: BoxFit.cover,
// height: 60,
// width: 60,
// errorBuilder: (context, error, stackTrace) {
// return Container(
// clipBehavior: Clip.none,
// child:Image.asset('assets/user_ic.png',
// fit: BoxFit.cover,
// height: 60,
// width: 60,) );
// },
// ),
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// color: Colors.white,
// ),
// ),
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// color: Color(0xFFEEEEEE),
// boxShadow: [
// BoxShadow(
// color: Color(0xFFD9D8D8),
// offset: Offset(5.0, 5.0),
// blurRadius: 3,
// ),
// BoxShadow(
// color: Colors.white.withOpacity(.5),
// offset: Offset(-5.0, -5.0),
// blurRadius: 4,
// ),
// ]),
// ),
// SizedBox(
// width:5,
// ),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// SizedBox(
// width: 120,
// child: Text(
// profileProvider.getName.toString(),
// maxLines: 1,
// overflow: TextOverflow.ellipsis,
// softWrap: false,
// style: TextStyle(
// color: Color(0xff101010),
// fontWeight: FontWeight.bold,
// fontSize: 25)),
// ),
// GestureDetector(
// child: Text(
// 'See your profile',
// style: TextStyle(
// color: Color(0xFF044a87),
// ),
// ),
// onTap: () {
//
//
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) =>
// ChangeNotifierProvider(
// create: (_) => SellerProfileProvider(),
// child: SellerProfile(),
// )));
//
// },
// ),
// ],
// ),
// Container(
// child: CircularPercentIndicator(
// radius: 60.0,
// lineWidth: 5.0,
// percent: profileProvider.precentindicate.toDouble(),
// animation: true,
// backgroundWidth: 8,
// backgroundColor: Colors.blue.shade400,
// center: new Text(profileProvider.ProgressBar.toString()+ "%",
// style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
// ),
// progressColor: PrimaryColor,
// ),
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// color: Color(0xFFEEEEEE),
// boxShadow: [
// BoxShadow(
// color: Color(0xFFD9D8D8),
// offset: Offset(5.0, 5.0),
// blurRadius: 3,
// ),
// BoxShadow(
// color: Colors.white.withOpacity(.5),
// offset: Offset(-5.0, -5.0),
// blurRadius: 4,
// ),
// ]),
// ),
// SizedBox(
// width: 5,
// ),
// Container(
// height: 50,
// width: 50,
// child: Image.asset(
// "assets/message_ic.png",
// color: Color(0xFF044a87),
// scale: 1.2,
// ),
// decoration: BoxDecoration(
// color: Color(0xFFEEEEEE),
// shape: BoxShape.circle,
// boxShadow: [
// BoxShadow(
// color: Color(0xFFD9D9D9),
// offset: Offset(5.0, 5.0),
// blurRadius: 7,
// ),
// BoxShadow(
// color: Colors.white.withOpacity(.5),
// offset: Offset(-5.0, -5.0),
// blurRadius: 10,
// ),
// ]),
// ),
// SizedBox(
// width:5 ,
// ),
// Container(
// height: 50,
// width: 50,
// child: Image.asset(
// "assets/language_ic.png",
// color: Color(0xFF044a87),
// scale: 1.2,
// ),
// decoration: BoxDecoration(
// color: Color(0xFFEEEEEE),
// shape: BoxShape.circle,
// boxShadow: [
// BoxShadow(
// color: Color(0xFFD9D9D9),
// offset: Offset(5.0, 5.0),
// blurRadius: 7,
// ),
// BoxShadow(
// color: Colors.white.withOpacity(.5),
// offset: Offset(-5.0, -5.0),
// blurRadius: 10,
// ),
// ])),
// ],
// ),
//);
