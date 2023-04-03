import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';

import '../Provider/UserJobProvider.dart';

class IndutryListFliter extends StatefulWidget {
  UserJobProvider jobListProvider;
   IndutryListFliter(this.jobListProvider) ;

  @override
  _IndutryListFliterState createState() => _IndutryListFliterState(jobListProvider);
}

class _IndutryListFliterState extends State<IndutryListFliter> {
  UserJobProvider jobListProvider;

  _IndutryListFliterState(this.jobListProvider);

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
             AppLocalizations.instance.text("Industry"),
                style: TextStyle(color: Colors.black, fontSize: 18),
              )),
          SizedBox(
            height: 5,
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
                itemCount: jobListProvider.industryListModel!.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: GestureDetector(
                        child: Container(
                            width: 20,
                            child: Checkbox(
                                value: jobListProvider.industryListModel!
                                    .data![index].isValue,
                                onChanged: (val) {
                                  setState(() {
                                  if(jobListProvider.industryListModel!.data![index].isValue==true)
                                    {
                                      jobListProvider.industryListModel!.data![index].isValue=false;
                                     jobListProvider.industryList.remove(jobListProvider.industryListModel!.data![index].id);
                                    }
                                  else

                                    {jobListProvider.industryListModel!.data![index].isValue=true;


                                      jobListProvider.industryList.add(jobListProvider.industryListModel!.data![index].id);
                                    }
                                  print(jobListProvider.industryList);
                                  });
                                }
                            )
                        ),
                        onTap: () {  jobListProvider.setMenuClick(index);
                        },
                      ),

                      title: Text(
                          jobListProvider.industryListModel!.data![index]
                              .name.toString()));
                }),
          ),
        ],
      ),
    );
  }
}