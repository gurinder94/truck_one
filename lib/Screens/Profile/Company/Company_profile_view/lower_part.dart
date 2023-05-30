import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/user_detail_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/user_profile.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/Company_profile_view/Provider/company_profile_view_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

class LowerPart extends StatelessWidget {
  @override
  CompanyViewProvider companyViewProvider;

  LowerPart(this.companyViewProvider);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 270),
      padding: EdgeInsets.only(left: 15, top: 10, right: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          companyName(
              companyViewProvider.companyDetail!.companyName.toString()),
          companyAddress(
              companyViewProvider.companyDetail!.city.toString(),
              companyViewProvider.companyDetail!.stateName.toString(),
              companyViewProvider.companyDetail!.countryName.toString()),
          Divider(),
          companyAboutUs(
              companyViewProvider.companyDetail!.aboutCompany.toString()),
          SizedBox(
            height: 10,
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              AppLocalizations.instance.text('Contact'),
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text.rich(TextSpan(
                text: AppLocalizations.instance.text('E-mail'),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                children: <InlineSpan>[
                  TextSpan(
                    text: ' : ' +
                        companyViewProvider.companyDetail!.email.toString(),
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  )
                ])),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text.rich(TextSpan(
                text: AppLocalizations.instance.text('Phone Number'),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                children: <InlineSpan>[
                  TextSpan(
                    text: ' : ' +
                        '+1' +
                        ' ' +
                        companyViewProvider.companyDetail!.mobileNumber
                            .toString(),
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  )
                ])),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              AppLocalizations.instance.text('Company Information'),
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Text.rich(TextSpan(
                text: AppLocalizations.instance.text('Incorporation Date'),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                children: <InlineSpan>[
                  TextSpan(
                    text: ' : ' +
                        formatterDate(companyViewProvider
                            .companyDetail!.incorporationDate),
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  )
                ])),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Text.rich(TextSpan(
                text: AppLocalizations.instance.text('Company Name'),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                children: <InlineSpan>[
                  TextSpan(
                    text: ' : ' +
                        companyViewProvider.companyDetail!.companyName
                            .toString(),
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  )
                ])),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width / 2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: APP_BAR_BG,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 3,
                            offset: Offset(5, 5)),
                        BoxShadow(
                            color: Colors.white,
                            blurRadius: 3,
                            offset: Offset(-5, -5))
                      ]),
                  child: Text(
                    AppLocalizations.instance.text('See All Posts'),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
                onTap: () async {
                  var getid = await getUserId();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                            create: (context) => UserDetailProvider(),
                            child: UserProfile(
                              userId: getid,
                            ),
                          )));
                },
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: APP_BG,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      ),
    );
  }
}

companyName(String name) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Text(
      showCapitalize(name),
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

companyAddress(String address, String countryName, String? stateName) {
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: Text(
      "$address , $countryName and $stateName",
      style: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}

companyAboutUs(String aboutCompany) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        AppLocalizations.instance.text('About Us'),
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          aboutCompany,
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    ],
  );
}
