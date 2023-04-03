import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/JobList/UserComponent/Provider/UserJobProvider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';

import '../../../Language_Screen/application_localizations.dart';

class SearchFliter extends StatelessWidget {
  UserJobProvider jobListProvider;
   SearchFliter(this.jobListProvider);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2,),

          Center(child: Text(AppLocalizations.instance.text("Filter by keyword"),style: TextStyle(color: Colors.black,fontSize: 18),)),
          SizedBox(height: 5,),
          Divider(),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InputTextField(
                child: TextFormField(
                  controller:jobListProvider.searchEditingController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: AppLocalizations.instance.text('Search'),
                    hintStyle: TextStyle(fontSize: 17),
                    // prefixIcon: Icon(
                    //   Icons.sear,
                    // ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
