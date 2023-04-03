import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/Company_profile_view/Provider/company_profile_view_provider.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/Company_profile_view/company_profile_view.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/provider/ProfileProvider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customLoder.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../commanWidget/custom_image_network_profile.dart';

class TopProfileWidget extends StatelessWidget {
  @override
  String? name;
  String roleName;

  TopProfileWidget(this.roleName);

  Widget build(BuildContext context) {
    var profileProvider = context.watch<ProfileProvider>();
    profileProvider.getvalueSharedPreferences();
    profileProvider.getProfileImageSharedPreferences();

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              profileProvider.getProfileImage == " "

                  ? SizedBox(width: 50, height: 40, child: CustomLoder())
                  :
              CustomImageProfile(
                  image: profileProvider.getProfileImage==null ? ' ' :
                  IMG_URL + profileProvider.getProfileImage.toString(),
                  width: 60,
                  boxFit: BoxFit.fitWidth,
                  height: 66),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 170.0,
                    child: profileProvider.getName == ''
                        ? CircularProgressIndicator()
                        : Text(
                      profileProvider.getName == ""
                          ? ''
                          : capitalize(
                          profileProvider.getName.toString()),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text("${AppLocalizations.instance.text(
                      'Logged in as')} ${':'} ${roleName}",
                    style: TextStyle(fontSize: 12
                        , fontStyle: FontStyle.italic),),
                  SizedBox(
                    height: 2,
                  ),
                  GestureDetector(
                    child: Text(
                      AppLocalizations.instance.text('profileText'),
                      style: TextStyle(
                          color: Color(0xFF044a87),
                          fontSize: 15
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChangeNotifierProvider(
                                      create: (_) => CompanyViewProvider(),
                                      child: CompanyViewDetail())));
                    },
                  ),
                  SizedBox(
                    height: 2,
                  ),

                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(6),
            child: CircularPercentIndicator(
              radius: 30.0,
              lineWidth: 5.0,
              percent: profileProvider.precentindicate!.toDouble(),
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

 _getImage(dynamic article) {
    NetworkImage _image;
    try {
      _image = NetworkImage(article);
    } catch (e) {
      debugPrint(e.toString()); // to see what the error was
      _image = NetworkImage("some default URI");
    }
  }
}