import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/ViewJob/Provider/JobviewProvider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';

class Requirements extends StatelessWidget {
   JobViewProvider _jobViewProvider;
  var size;
String ?roleName;

  Requirements(this._jobViewProvider);
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            heading("Experience Required"),
            JobHighLights(
                '${_jobViewProvider.jobModel.data![0].minimumExperience}${' Yrs'}-${_jobViewProvider.jobModel.data![0].maximumExperience} Months'),
            Divider(
              color: Colors.black.withOpacity(0.2),
            ),
            heading("Openings"),
            JobHighLights('${_jobViewProvider.jobModel.data![0].vacancy} '),
            Divider(
              color: Colors.black.withOpacity(0.2),
            ),
            heading("Job Location"),
            JobHighLights(_jobViewProvider.jobModel.data![0].fullAddress
                .toString()),
            Divider(
              color: Colors.black.withOpacity(0.2),
            ),


            _jobViewProvider.jobModel.data![0].salaryType==null?SizedBox():    heading("Salary Type"),
            SizedBox(
              height: size.height * 0.0,

            ),_jobViewProvider.jobModel.data![0].salaryType==null?SizedBox():           Padding(
        padding: const EdgeInsets.only(
            left: 20, right: 10, top: 8, bottom: 10),
        child: Text(_jobViewProvider.jobModel.data![0].salaryType.toString()),
            ),
            _jobViewProvider.jobModel.data![0].salaryRang![0].max==null?SizedBox():    heading("Salary"),
            _jobViewProvider.jobModel.data![0].salaryRang![0].max==null?SizedBox():           Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 10, top: 8, bottom: 10),
              child: Row(
                children: [
                  Text(
              _jobViewProvider.jobModel.data![0].salaryRang![0].currency.toString()+' '+ '${_jobViewProvider.jobModel.data![0].salaryRang![0].min.toString()}'),
                  Text("-"),
                  Text(_jobViewProvider.jobModel.data![0].salaryRang![0].max
                      .toString()),
                ],
              ),
            ),
            _jobViewProvider.jobModel.data![0].salaryRang!.length==0?SizedBox():          Divider(
              color: Colors.black.withOpacity(0.2),
            ),
            heading("Key Skills"),
            SizedBox(
              height: size.height * 0.0,
            ),
            Industry(
                _jobViewProvider.jobModel.data![0].skillData.toString()    .substring(
                          1,
                          _jobViewProvider.jobModel.data![0].skillData.toString()

                                  .length -
                              1),),

            Divider(
              color: Colors.black.withOpacity(0.2),
            ),
            heading("Industry Type"),
            SizedBox(
              height: size.height * 0.0,
            ),
            Industry(
                _jobViewProvider.jobModel.data![0].industryData!.name.toString()),
            Divider(
              color: Colors.black.withOpacity(0.2),
            ),

            heading("Functional Area"),
            SizedBox(
              height: size.height * 0.0,
            ),
            Industry(_jobViewProvider.jobModel.data![0].functionalArea!.name
                .toString()),
            Divider(
              color: Colors.black.withOpacity(0.2),
            ),

            // heading("Role"),
            // SizedBox(
            //   height: size.height * 0.0,
            // ),
            // Industry(
            //   _jobViewProvider.jobModel.data![0].functionalArea!.roles
            //       .toString()
            //       .substring(
            //           1,
            //           _jobViewProvider.jobModel.data![0].functionalArea!.roles
            //                   .toString()
            //                   .length -
            //               1),
            // ),
            // Divider(
            //   color: Colors.black.withOpacity(0.2),
            // ),
            heading("Employment Type"),
            SizedBox(
              height: size.height * 0.0,
            ),
            Industry(_jobViewProvider.jobModel.data![0].employmentType.toString()),
            Divider(
              color: Colors.black.withOpacity(0.3),
            ),
            heading("Qualifications"),
            SizedBox(
              height: size.height * 0.0,
            ),

               Industry(_jobViewProvider.qualificationList.toString()=='[]'?"N/A":_jobViewProvider.qualificationList.toString().substring(
                   1,
                   _jobViewProvider.qualificationList.toString()

                       .length -
                       1), ),
            Divider(
              color: Colors.black.withOpacity(0.3),
            ),
            heading("Job Description"),
            SizedBox(
              height: size.height * 0.0,
            ),
            JobDescription(
                _jobViewProvider.jobModel.data![0].description.toString()),
            _jobViewProvider.jobModel.data![0].salaryRang![0].max==null?SizedBox():      Divider(
              color: Colors.black.withOpacity(0.2),
            ),

          ],
        ),
      ),
      decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFD9D8D8),
              offset: Offset(5.0, 5.0),
              blurRadius: 2,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(.4),
              offset: Offset(-5.0, -5.0),
              blurRadius: 10,
            ),
          ]),
    );


  }

  Requirement(String title) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration:
              BoxDecoration(color: Color(0xFF044a87), shape: BoxShape.circle),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(child: Text(title.toString())),
      ],
    );
  }

  Industry(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10, top: 8, bottom: 10),
      child: Text(
        title.toString(),
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}

JobHighLights(String title) {
  return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10, top: 8, bottom: 10),
      child: Text(
        title.toString(),
        style: TextStyle(
          fontSize: 14,
        ),
      ));
}

JobDescription(String description) {
  return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 10,
      ),
      child: Html(data: description, style: {
        "body": Style(
          fontSize: FontSize(14.0),
          textAlign: TextAlign.justify
        ),
      }));
}

heading(String title) {
  return Row(
    children: [
      Container(
        width: 10,
        height: 7,
        decoration:
            BoxDecoration(color: Color(0xFF044a87), shape: BoxShape.circle),
      ),
      SizedBox(
        width: 10,
      ),
      Flexible(
          child: Text(
        AppLocalizations.instance.text(title.toString()),
        style: TextStyle(
            color: Color(0xFF044a87),
            fontSize: 16,
            fontWeight: FontWeight.w700),
      )),
    ],
  );
}
