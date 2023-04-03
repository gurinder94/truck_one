import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/JobList/UserComponent/Provider/UserJobProvider.dart';

import '../../../../Language_Screen/application_localizations.dart';

class EducationFliter extends StatefulWidget {
  UserJobProvider jobListProvider;
  EducationFliter(this.jobListProvider,);

  @override
  _EducationFliterState createState() => _EducationFliterState(jobListProvider);
}

class _EducationFliterState extends State<EducationFliter> {
  UserJobProvider jobListProvider;
  _EducationFliterState(this.jobListProvider);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 2,
          ),
          Center(
              child: Text(
                AppLocalizations.instance.text("Education"),
                style: TextStyle(color: Colors.black, fontSize: 18),
              )),
          SizedBox(
            height: 5,
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
                itemCount: jobListProvider.qualificationModel!.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: Container(
                          width: 20,
                          child: Checkbox(
                              value:jobListProvider.qualificationModel!.data![index].isvalue,
                              onChanged: (val) {
                                setState(() {
                                  if (jobListProvider.qualificationModel!
                                      .data![index].isvalue == true) {
                                    jobListProvider.qualificationModel!
                                        .data![index].isvalue = false;
                                    jobListProvider.qualificationList.remove(
                                        jobListProvider.qualificationModel!
                                            .data![index].id);
                                  }
                                  else {
                                    jobListProvider.qualificationModel!
                                        .data![index].isvalue = true;
                                    jobListProvider.qualificationList.add(
                                        jobListProvider.qualificationModel!
                                            .data![index].id);

                                    print(jobListProvider.qualificationList);
                                  }
                                });
                              }
                          ),
                      ),

                      title: Text(jobListProvider.qualificationModel!.data![index].qualification.toString()));


                }),
          ),
        ],
      ),
    );
  }
}
