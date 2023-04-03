import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/ManageTeamModel/manage_team_model.dart';

import '../../Language_Screen/application_localizations.dart';

class ManageTeamItem extends StatelessWidget {
  Datum data;

  ManageTeamItem(this.data);

  @override
  Widget build(BuildContext context) {
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
              data.personName.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: AppLocalizations.instance.text('Email'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 2),
                        children:  <TextSpan>[
                          TextSpan(
                              text:'\n${data.email.toString()}',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text:AppLocalizations.instance.text('Phone Number'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 2),
                        children:  <TextSpan>[
                          TextSpan(
                              text: "\n${data.mobileNumber.toString()}",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text:AppLocalizations.instance.text('Access'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 2),
                        children:  <TextSpan>[
                          TextSpan(
                              text:'\n${data.accessLevel.toString()}',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: AppLocalizations.instance.text("Trip Status"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 2),
                        children:  <TextSpan>[
                          TextSpan(
                              text: '\n${data.runningStatus.toString()=="[ACTIVE]"?"Active":'Idle'}',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 4, offset: Offset(5, 5)),
              BoxShadow(
                  color: Colors.white, blurRadius: 4, offset: Offset(-5, -5))
            ]),
      ),
    );
  }
}
