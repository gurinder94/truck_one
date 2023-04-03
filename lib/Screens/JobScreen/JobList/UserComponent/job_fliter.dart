import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/JobList/UserComponent/search_fliter_list.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../AppUtils/constants.dart';
import '../../../commanWidget/comman_button_widget.dart';
import 'Component/education_list.dart';
import 'Component/industry_list.dart';
import 'Location_filter.dart';
import 'Provider/UserJobProvider.dart';

class JobFliter extends StatefulWidget {
  UserJobProvider jobListProvider;

  JobFliter(this.jobListProvider, {Key? key}) : super(key: key);

  @override
  State<JobFliter> createState() => _JobFliterState();
}

class _JobFliterState extends State<JobFliter> {
  List search = [AppLocalizations.instance.text("Search"), AppLocalizations.instance.text("Education"),AppLocalizations.instance.text("Industry"),AppLocalizations.instance.text("Location") ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height < 700
          ? MediaQuery.of(context).size.height * 0.85
          : MediaQuery.of(context).size.height * 0.75,
      decoration: new BoxDecoration(
        color: APP_BG,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                AppLocalizations.instance.text('Filter Jobs'),
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
            ),
          ),
          Divider(),
          SizedBox(
            height: 2,
          ),
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: ListView.builder(
                        itemCount: search.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            child: ListTile(
                              leading: Text(search[index]),
                            ),
                            onTap: () {
                              widget.jobListProvider.setMenuClick(index);
                            },
                          );
                        }),
                    decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            //                   <--- left side
                            color: Colors.black38.withOpacity(0.1),
                          ),
                        )),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height:MediaQuery.of(context).size.height < 700
                          ?  MediaQuery.of(context).size.height * 0.6
                          : MediaQuery.of(context).size.height * 0.5,

                      child: menuWidget(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: CommanButtonWidget(
                  title: AppLocalizations.instance.text("Clear"),
                  buttonColor: PrimaryColor,
                  titleColor: APP_BG,
                  onDoneFuction: () {
                    widget.jobListProvider.resetvalue();
                  },
                  loder: false,
                ),
              ),
              Expanded(
                child: CommanButtonWidget(
                  title: AppLocalizations.instance.text("Apply"),
                  buttonColor: PrimaryColor,
                  titleColor: APP_BG,
                  onDoneFuction: () {
                 print(        widget.jobListProvider.searchEditingController.text,);
                    widget.jobListProvider.resetJobList();
                    widget.jobListProvider.hitUserGetJobList(
                        context,
                        widget.jobListProvider.searchEditingController.text,
                        false,
                        1);


                    Navigator.pop(context);
                  },
                  loder: false,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  menuWidget(
    BuildContext context,
  ) {
    switch (Provider.of<UserJobProvider>(context, listen: true).menuClick) {
      case 0:
        return SearchFliter(widget.jobListProvider);

      case 1:
        return EducationFliter(widget.jobListProvider);

      case 2:
        return IndutryListFliter(widget.jobListProvider);
      case 3:
        return LocationFliter(widget.jobListProvider);
    }
  }
}
