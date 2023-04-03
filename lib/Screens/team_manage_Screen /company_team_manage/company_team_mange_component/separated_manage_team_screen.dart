import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_rich_text.dart';
import 'package:provider/provider.dart';

import '../../../Language_Screen/application_localizations.dart';
import '../Provider/team_manger_provider.dart';

class SeparatedEmployees extends StatelessWidget {
  ManagerTeamProvider managerTeamProvider;
   SeparatedEmployees(this.managerTeamProvider, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Consumer<ManagerTeamProvider>(builder: (_, proData, __) {
        if (proData.loading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (proData.UserLeftCompanyList.length == 0)
          return Center(child: Text(AppLocalizations.instance.text('No Record Found')));
        else
          return ListView.builder(
            controller: proData.separationscrollController,
              itemCount: proData.UserLeftCompanyList.length,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          capitalize(  proData.UserLeftCompanyList[index].firstName.toString()+' '+proData.UserLeftCompanyList[index].lastName.toString()),

                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: CommonRichText(
                                  richText1: AppLocalizations.instance.text('Email'),
                                  style1: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      height: 1.4,
                                      color: Colors.black),
                                  richText2:  '\n${proData.UserLeftCompanyList[index].email.toString()}',
                                  style2: TextStyle(
                                      fontWeight: FontWeight.normal),
                                )),

                            Expanded(
                                child: CommonRichText(
                                  richText1: AppLocalizations.instance.text('Separation Date'),
                                  style1: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      height: 1.4,
                                      color: Colors.black),
                                  richText2:  proData.UserLeftCompanyList[index].createdAt ==
                                      null
                                      ? '\n'
                                      :'\n${formatterDate(proData.UserLeftCompanyList[index].createdAt)}',



                                  style2: TextStyle(
                                      fontWeight: FontWeight.normal),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CommonRichText(
                          richText1: AppLocalizations.instance.text('Reason'),
                          style1: TextStyle(
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                              color: Colors.black),
                          richText2:'\n${ proData.UserLeftCompanyList[index].reason.toString()}',
                          style2:
                          TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
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
                );
              });
      }
      ),
    );
  }
  getCovert(String value) {
    DateTime dt = DateTime.parse(value); // 2020-01-02 03:04:05.000

    String formattedDate = DateFormat('yyyy-MM-dd').format(dt);

    return formattedDate;
  }
}
