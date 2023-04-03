import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/JobList/CompanyJob/Component/PDFViewerFromUrl.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/JobList/CompanyJob/Provider/JobListProvider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_rich_text.dart';

import 'package:provider/provider.dart';

import '../../../../Language_Screen/application_localizations.dart';

class ApplicantsItem extends StatelessWidget {
  const ApplicantsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Expanded(
      child: Consumer<JobListProvider>(builder: (_, proData, __) {

        if (proData.jobViewApplicants) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (proData.applicant == null || proData.applicant!.data!.length == 0)
          return Center(child: Text(AppLocalizations.instance.text("No Record Found"),));
        else
          return ListView.builder(
              itemCount: proData.applicant!.data!.length,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                var user = proData.applicant!.data![index].userData!;
                var resume = proData.applicant!.data![index].resume == null
                    ? ''
                    : proData.applicant!.data![index].resume;
                var description =
                    proData.applicant!.data![index].description == null
                        ? ''
                        : proData.applicant!.data![index].description;
                return Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            user.personName.toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: CommonRichText(
                            richText1: AppLocalizations.instance.text("Email"),
                            style1: TextStyle(
                                fontWeight: FontWeight.bold,
                                height: 1.4,
                                color: Colors.black),
                            richText2: '\n${user.email.toString()}',
                            style2: TextStyle(fontWeight: FontWeight.normal),
                          )),
                          Expanded(
                              flex: 1,
                              child: CommonRichText(
                                richText1:  AppLocalizations.instance.text("Phone Number"),
                                style1: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    height: 1.4,
                                    color: Colors.black),
                                richText2: '\n${user.mobileNumber.toString().toString()}',
                                style2:
                                    TextStyle(fontWeight: FontWeight.normal),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('${AppLocalizations.instance.text("Resume/Description")+'\n'}',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                          color: Colors.black),),
                      resume == ""
                          ? GestureDetector(
                              child: Icon(Icons.visibility),
                              onTap: () {
                                showpop(context, description);
                              },
                            )
                          : GestureDetector(
                              child: Icon(Icons.upload_file),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                        builder: (_) => PDFViewerFromUrl(
                                              url: Resume_Pdf_URl + resume!,
                                          title: " Resume",
                                            )));
                              })
                    ],
                  ),
                  decoration: const BoxDecoration(
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
                );
              });
      }),
    );
  }

  showpop(BuildContext context, String? description) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Description"),
        content: SingleChildScrollView(
          child: Html(
            data: description,
            style: {
              "body": Style(
                fontSize: FontSize(14.0),
              ),
            },
          ),
        ),
        actions: <Widget>[
        InkWell(
        splashColor: PrimaryColor,
        highlightColor: Colors.white,
        child:Text("okay"),
        onTap: () {
          Navigator.of(ctx).pop();


        },



      )

        ],
      ),
    );
  }
}
// Container(
// width: size.width,
// height: 60,
// padding: EdgeInsets.all(10),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(user.personName.toString()),
// Text(user.mobileNumber.toString()),
// Flexible(child: Text(user.email.toString())),
// Flexible(
// child: Padding(
// padding: const EdgeInsets.only(right: 20),
// child: resume == ""
// ? GestureDetector(
// child: Icon(Icons.close),
// onTap: () {
// showpop(context, description);
// },
// )
// : GestureDetector(
// child: Icon(Icons.upload_file),
// onTap: () {
// Navigator.push(
// context,
// MaterialPageRoute<dynamic>(
// builder: (_) => PDFViewerFromUrl(
// url: Resume_Pdf_URl + resume!,
// ),
// ),
// );
// },
// )),
// )
// ],
// ),
// decoration:
// BoxDecoration(color: Color(0xFFEEEEEE), boxShadow: [
// BoxShadow(
// color: Color(0xFFD9D8D8),
// offset: Offset(5.0, 5.0),
// blurRadius: 7,
// ),
// BoxShadow(
// color: Colors.white.withOpacity(.4),
// offset: Offset(-5.0, -5.0),
// blurRadius: 10,
// ),
// ]),
// );
