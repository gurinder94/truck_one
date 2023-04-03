import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_rich_text.dart';
import 'package:provider/provider.dart';

import '../Provider/seller_manage_team_Provider.dart';

class SellerMangerTeamList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<SellerManageTeamProvider>(builder: (_, proData, __) {
        if (proData.loading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (proData.sellerManageTeamList.length == 0)
          return Center(child: Text(AppLocalizations.instance.text('No Record Found')));
        else
          return ListView.builder(
              itemCount: proData.sellerManageTeamList.length,
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
                          proData.sellerManageTeamList[index].personName
                              .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonRichText(
                              richText1:AppLocalizations.instance.text('Email'),
                              style1: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  height: 1.4,
                                  color: Colors.black),
                              richText2:'\n'+ proData
                                  .sellerManageTeamList[index].email
                                  .toString(),
                              style2:
                                  TextStyle(fontWeight: FontWeight.normal),
                            ),
                            CommonRichText(
                              richText1:AppLocalizations.instance.text('Phone Number'),
                              style1: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  height: 1.4,
                                  color: Colors.black),
                              richText2:'\n'+ proData
                                  .sellerManageTeamList[index].mobileNumber
                                  .toString(),
                              style2:
                                  TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CommonRichText(
                          richText1: AppLocalizations.instance.text('Status'),
                          style1: TextStyle(
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                              color: Colors.black),
                          richText2:'\n'+ proData
                              .sellerManageTeamList[index].isAccepted
                              .toString(),
                          style2: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
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
                );
              });
      }),
    );
  }
}
