import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/user_detail_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/user_profile.dart';

import 'package:my_truck_dot_one/Screens/Profile/UserProfile/user_profile_view/provider/user_profile_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/pdf_Viewer_From_Url.dart';
import 'package:provider/provider.dart';

class LowerPart extends StatelessWidget {
  @override
  late UserProfileViewProvider proData;

  LowerPart(this.proData);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 270),
      padding: EdgeInsets.only(left: 15, top: 10, right: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          companyName(proData.userModel!.data!.firstName.toString(),
              proData.userModel!.data!.lastName.toString()),
          Divider(),
          companyAboutUs(proData.userModel!.data!.aboutUser.toString()),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.instance.text('Contact'),
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
                    padding: const EdgeInsets.all(5.0),
                    child: Text.rich(TextSpan(
                        text: AppLocalizations.instance.text('E-mail'),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800),
                        children: <InlineSpan>[
                          TextSpan(
                            text:
                                ':' + proData.userModel!.data!.email.toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                          )
                        ])),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Text.rich(TextSpan(
                        text: AppLocalizations.instance.text('Phone Number'),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800),
                        children: <InlineSpan>[
                          TextSpan(
                            text: ':' +
                                '+1' +
                                ' ' +
                                proData.userModel!.data!.mobileNumber
                                    .toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                          )
                        ])),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
          // work
          proData.checkRole == "ENDUSER"
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.instance.text('Work'),
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
                          padding: const EdgeInsets.all(5.0),
                          child: Text.rich(TextSpan(
                              text: AppLocalizations.instance
                                  .text('Company Name'),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w800),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: ':' +
                                      proData.userModel!.data!.companyName
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                )
                              ])),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text.rich(TextSpan(
                              text: AppLocalizations.instance.text('WorkPlace'),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w800),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: ':' +
                                      proData.userModel!.data!.workPlace
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                )
                              ])),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),
          SkillCompany(context, proData.qualificationList, 'Qualifications'),
          Divider(),
          SkillCompany(context, proData.languageList, "Languages"),

          Divider(),

          SkillCompany(context, proData.skillList, "Skills"),

          Divider(),
          experienceCompany(
            context,
            proData.userModel!.data!.experience
                    .toString()
                    .replaceAll('null', '') ??
                "",
            "Experience",
            proData.userModel!.data!.monthsExperience
                    .toString()
                    .replaceAll('null', '') ??
                "",
          ),
          proData.checkRole == "DRIVER" ? Divider() : SizedBox(),
          proData.checkRole == "DRIVER"
              ? Companyy(context, "Documents", proData)
              : SizedBox(),

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
                    AppLocalizations.instance.text("See All Posts"),
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

companyName(String name, String last) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Text(
      showCapitalize(name) + ' ' + showCapitalize(last),
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

companyAboutUs(String aboutCompany) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Column(
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
    ),
  );
}

SkillCompany(
  BuildContext context,
  List<String> qualificationList,
  String heading,
) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.instance.text(heading),
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        qualificationList.length == 0
            ? Text('N/A')
            : Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: List<Widget>.generate(qualificationList.length,
                    (int index) {
                  return Chip(
                      label: Text(
                    qualificationList[index],
                    style: TextStyle(fontSize: 14),
                  ));
                }),
              ),

        ///Chip
      ],
    ),
  );
}

Companyy(
  BuildContext context,
  String heading,
  UserProfileViewProvider proData,
) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            heading,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: List<Widget>.generate(proData.documentDriverList.length,
              (int index) {
            return GestureDetector(
              child: Chip(
                  deleteIcon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onDeleted: () {
                    proData.hitRemoveDocument(
                        proData.documentDriverList[index].id.toString(),
                        proData.documentDriverList[index].fileName.toString(),
                        proData,
                        index);
                  },
                  label:
                      Text(proData.documentDriverList[index].name.toString())),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFViewerFromUrl(
                            proData.documentDriverList[index].name,
                            proData.documentDriverList[index].fileName)));
              },
            );
          }),
        ), //Chip
      ],
    ),
  );
}

experienceCompany(
  BuildContext context,
  String value,
  String heading,
  String month,
) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.instance.text("Experience"),
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(2),
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Chip(
                label: Text(
                  month == '0' ? "$value year " : "$value year , $month month",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            )
          ],
        ), //Chip
      ],
    ),
  );
}
