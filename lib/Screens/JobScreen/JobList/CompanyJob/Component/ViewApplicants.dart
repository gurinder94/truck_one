import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/JobList/CompanyJob/Provider/JobListProvider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customapp.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/input_shape.dart';
import 'package:provider/provider.dart';
import '../../../../commanWidget/comman_drop.dart';
import 'ApplicantsItem.dart';

class ViewApplicants extends StatelessWidget {
  late JobListProvider _jobListProvider;
  String? jobId;

  ViewApplicants(this.jobId);

  @override
  Widget build(BuildContext context) {
    _jobListProvider = Provider.of<JobListProvider>(context, listen: false);
    getApplicants(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        body: CustomAppBar(
            visual: false,
            title: AppLocalizations.instance.text("View Applicants"),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                          child: InputShape(
                        child: TextFormField(
                          onTap: () {
                            startDate(context);
                          },
                          controller: _jobListProvider.dateController,
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText: 'Select Date',
                              suffixIcon: Icon(Icons.calendar_today),
                              border: InputBorder.none),
                        ),
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Consumer<JobListProvider>(
                          builder:
                              (BuildContext context, value, Widget? child) =>
                                  CommanDrop(
                            title: "Sort",
                            onChangedFunction: (String newValue) {
                              value.sort = newValue;
                              if (value.sort == "A-Z") {
                                value.applicant!.data!.sort((a, b) {
                                  return a.userData!.personName!.compareTo(
                                      b.userData!.personName!.toString());
                                });
                              } else if (value.sort == "Z-A") {
                                value.applicant!.data!.sort((a, b) =>
                                    b.userData!.personName!.compareTo(
                                        a.userData!.personName!.toString()));
                              }
                              value.notifyListeners();
                            },
                            selectValue: value.sort,
                            itemsList:
                                value.sortList.map<DropdownMenuItem<String>>(
                              (value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Center(child: Text(value)),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFE5E5E5),
                                  Color(0xFFECEAEA),
                                  Color(0xFFECEAEA),
                                ],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFD5D5D5),
                                  offset: Offset(5.0, 5.0),
                                  blurRadius: 1,
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-5.0, -5.0),
                                  blurRadius: 3,
                                ),
                              ]),
                          child: GestureDetector(
                              onTap: () {
                                _jobListProvider.resetFields();
                                getApplicants(context);
                              },
                              child: Icon(Icons.restart_alt)))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: InputShape(
                            child: DropdownButtonFormField(
                          isExpanded: true,
                          value: _jobListProvider.selectItems,
                          items: _jobListProvider.title.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            _jobListProvider.selectItems = value.toString();
                            getApplicants(context);
                            _jobListProvider.notifyListeners();
                          },
                          decoration: const InputDecoration(
                            hintText: "Select Status",
                            counterText: "",
                            contentPadding: EdgeInsets.only(left: 10),
                            enabled: true,
                            border: InputBorder.none,
                          ),
                          validator: (value) =>
                              value == null ? 'Please select title' : null,
                        )),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: InputShape(
                            child: DropdownButtonFormField(
                          isExpanded: true,
                          value: _jobListProvider.selectRead,
                          items: _jobListProvider.read.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            _jobListProvider.selectRead = value.toString();
                            getApplicants(context);
                            _jobListProvider.notifyListeners();
                          },
                          decoration: const InputDecoration(
                            counterText: "",
                            contentPadding: EdgeInsets.only(left: 10),
                            enabled: true,
                            border: InputBorder.none,
                          ),
                          validator: (value) =>
                              value == null ? 'Please select title' : null,
                        )),
                      )
                    ],
                  ),
                ),
                ApplicantsItem(jobId)
              ],
            )));
  }

  Future<void> getApplicants(BuildContext context) async {
    var getId = await getUserId();
    _jobListProvider.hitViewApplicants(context, getId, jobId);
  }

  startDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        selectableDayPredicate: (DateTime val) =>
            val.weekday == 7 ? false : true,
        firstDate: DateTime(1800),
        lastDate: DateTime(2101),
        builder: (context, child) => Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Colors.blue.shade900,
                  onPrimary: Colors.white,
                  onSurface: Colors.black,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    primary: Colors.blue.shade900, // button text color
                  ),
                ),
              ),
              child: child!,
            ));
    if (picked != null) {
      DateTime day = DateTime(picked.year, picked.month, picked.day);
      _jobListProvider.dateController.text =
          DateFormat("yyyy-MM-dd").format(day);
      getApplicants(context);
    }
  }
}
