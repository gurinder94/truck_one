import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/ViewJob/Provider/JobviewProvider.dart';

import '../../../Language_Screen/application_localizations.dart';

class AboutCompany extends StatelessWidget {
  @override
  JobViewProvider _jobViewProvider;
  var size;

  AboutCompany(this._jobViewProvider);

  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.0,
            ),
            Text(
              AppLocalizations.instance.text('Walk-in Details'),
              style: TextStyle(
                  color: PrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: size.height / 45,
            ),
            displayText(
                AppLocalizations.instance.text('Company Name'),
                AppLocalizations.instance.text('Company Website'),
                _jobViewProvider.jobModel.data![0].companyName.toString(),
                _jobViewProvider.jobModel.data![0].companyWebsite.toString()),
            SizedBox(
              height: 10,
            ),

            displayDate(
                AppLocalizations.instance.text('Start Date'),
                AppLocalizations.instance.text('End Date'),
                _jobViewProvider.jobModel.data![0].walkInDetails![0].startDate!,
                _jobViewProvider.jobModel.data![0].walkInDetails![0].endDate!),
            SizedBox(
              height: 10,
            ),
            displayText(
                AppLocalizations.instance.text('Venue'),
                AppLocalizations.instance.text('Contact Person'),
                _jobViewProvider.jobModel.data![0].walkInDetails![0].venue
                    .toString(),
                _jobViewProvider
                    .jobModel.data![0].walkInDetails![0].contactPerson
                    .toString()),
            SizedBox(
              height: 10,
            ),
            displayText(
              AppLocalizations.instance.text('Phone Number'),
              "",
              _jobViewProvider.jobModel.data![0].walkInDetails![0].number
                  .toString()
                  .toString(),
              '',
            ),
            // Row(
            //
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text("Company Name"),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Text("Websites"),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           // Text("Contact Person"),
            //         ],
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(left: 20),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(_jobViewProvider.jobModel.data![0].companyName.toString(),),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Text(_jobViewProvider.jobModel.data![0].companyWebsite
            //               .toString()==""?"N/A":_jobViewProvider.jobModel.data![0].companyWebsite
            //               .toString()),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           // Text(_jobViewProvider.jobModel.data![0].walkInDetails![0].number
            //           //     .toString()),
            //         ],
            //       ),
            //     ),
            //     SizedBox(
            //       height: 20,
            //     ),
            //   ],
            // ),
            Divider(
              color: Colors.black.withOpacity(0.2),
            ),
            Container(
              child: Text(
                AppLocalizations.instance.text(
                  "About Company",
                ),
                style: TextStyle(
                    color: Color(0xFF044a87),
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: size.height * 0.00,
            ),
            Html(
              data: _jobViewProvider.jobModel.data![0].companyDetails,
              style: {
                "body": Style(
                  fontSize: FontSize(13.0),
                  textAlign: TextAlign.justify,
                ),
              },
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

  displayText(String name, String name2, String value, String value2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$name',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '$name2',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16),
            ),
          ],
        )),
        SizedBox(
          width: 20,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$value',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                 fontSize: 14
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              value2=="N/A"?'N/A':'$value2',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                  fontSize: 14
              ),
            )
          ],
        )),
      ],
    );
  }

  displayDate(String name, String name2, DateTime value, DateTime value2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$name',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '$name2',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16),
            ),
          ],
        )),
        SizedBox(
          width: 20,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            value == null
                ? Text(
                    formatterDate("N/A"),
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : Text(
                    formatterDate(value),
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
            SizedBox(
              height: 10,
            ),
            value == null
                ? Text(
                    "N/A",
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : Text(
                    formatterDate(value2),
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
          ],
        )),
      ],
    );
  }
}
