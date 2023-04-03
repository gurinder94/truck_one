import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/JobList/UserComponent/Provider/UserJobProvider.dart';
import 'package:provider/provider.dart';

import '../../../Language_Screen/application_localizations.dart';
import '../../../commanWidget/commanField_widget.dart';
import 'Address_list.dart';

class LocationFliter extends StatelessWidget {
  UserJobProvider jobListProvider;

  LocationFliter(this.jobListProvider);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2,
          ),
          Center(
              child: Text(
                AppLocalizations.instance.text("Location"),
            style: TextStyle(color: Colors.black, fontSize: 18),
          )),
          SizedBox(
            height: 5,
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InputTextField(
                child: TextFormField(
              controller: jobListProvider.addressController,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: AppLocalizations.instance.text('Address'),
                // icon: Padding(
                //   padding: EdgeInsets.all(10.0),
                //   child: FaIcon(FontAwesomeIcons.addressCard),
                // ),
                hintStyle: TextStyle(fontSize: 17),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  jobListProvider.autoCompleteSearch(value);
                }
                else
                  {
jobListProvider.resetAddressList();
                  }
              },
            )),
          ),
          Selector<UserJobProvider, dynamic>(
              selector: (_, provider) => provider.predictions,
              builder: (context, paginationLoading, child) {
                return paginationLoading==[]?SizedBox():   JobAddressList();
              }),

        ],
      ),
    );
  }
}
