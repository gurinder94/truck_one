import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/CompanyProfile.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/provider/ProfileProvider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';
import 'package:provider/provider.dart';

import 'Provider/company_profile_view_provider.dart';
import 'lower_part.dart';

class HeadPart extends StatelessWidget {
  CompanyViewProvider companyViewProvider;

  HeadPart(this.companyViewProvider);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: 300,
            child: CustomImage(
                image: companyViewProvider.companyDetail!.bannerImage == null
                    ? ''
                    : profile_banner_url +
                        companyViewProvider.companyDetail!.bannerImage
                            .toString(),
                width: double.infinity,
                boxFit: BoxFit.cover,
                height: 300)),
        Padding(
          padding: EdgeInsets.only(top: 20),


          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
            padding: EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(

                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  Text(
                    AppLocalizations.instance.text('Profile'),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  PopupMenuButton(
                    onSelected: (value) {
                      switch (value) {
                        case 1:
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider(create: (_) => ProfileProvider(),child: CompanyProfile(true))));
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text(AppLocalizations.instance.text('Edit')),
                        value: 1,
                      ),
                    ],
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.transparent,
                    Color(0x4B525050),
                    Colors.transparent,
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),),
        ),
        LowerPart(companyViewProvider),
        Positioned(
          left: 0,
          right: 0,
          top: 210,
          child: Container(
            width: 100,
            height: 100,
            padding: EdgeInsets.all(3),
            clipBehavior: Clip.antiAlias,
            alignment: Alignment.bottomCenter,
            child: Container(
              clipBehavior: Clip.antiAlias,
              alignment: Alignment.bottomCenter,
              child: CustomImageProfile(
                  image: companyViewProvider.companyDetail!.companyLogo == null
                      ? ''
                      : IMG_URL +
                          companyViewProvider.companyDetail!.companyLogo
                              .toString(),
                  width: 100,
                  boxFit: BoxFit.contain,
                  height: 100),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
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
                    blurRadius: 4,
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}
