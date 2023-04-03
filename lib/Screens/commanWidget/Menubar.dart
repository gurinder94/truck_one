import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/JobList/UserComponent/Provider/UserJobProvider.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/JobList/UserComponent/UserJobSaveList.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/JobList/UserComponent/user_Applied_job_list.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

class Menubar extends StatelessWidget {
  String? getId;
  late UserJobProvider UserjobProvider;

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    UserjobProvider = Provider.of<UserJobProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 180,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              width: 100,
              height: 4,
              color: Color(0xFF1A62A9),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Center(
                  child: Text(
                    AppLocalizations.instance.text("My Jobs"),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 20),
                  ),
                )
              ],
            ),


            SizedBox(
              height: size.height * 0.02,
            ),
            GestureDetector(
              child: Row(
                children: [
                  Icon(
                    Icons.save,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Text(  AppLocalizations.instance.text("Favorite Job")),
                ],
              ),
              onTap: () {
                getSaveJobList( context);

                // SaveJobList
                // getSaveJobList(context);
              },
            ),
            Divider(
              color: Colors.grey,
            ),
            GestureDetector(
              child: Row(
                children: [
                 Image.asset("icons/appliedJob.png",width:25,height: 25,),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Text(AppLocalizations.instance.text("Applied Job")),
                ],
              ),
              onTap: () {
                getAppliedJobList(context);
              },
            ),
            Divider(
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  getSaveJobList(BuildContext context) async {
    getId = await getUserId();


    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => SaveJobList())).then((_) {
      // This block runs when you have come back to the 1st Page from 2nd.
      UserjobProvider.jobList=[];
      UserjobProvider.hitUserGetJobList(context,'',false,1);

    });
        }
  getAppliedJobList(BuildContext context)
  async {
    getId = await getUserId();


    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => AppliedJobList()));
  }
}
