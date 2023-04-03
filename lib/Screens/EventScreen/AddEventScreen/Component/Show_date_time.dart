import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/AddEventScreen/Component/time_zone_Drop.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/AddEventScreen/Provider/show_date_time_Provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_button_widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customapp.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DateTime extends StatefulWidget {
  Function getDate;
  Function getTime;
  Function getTimeZone;

  DateTime(
    this.getDate,
    this.getTime,
    this.getTimeZone,
  );

  @override
  _DateTimeState createState() => _DateTimeState(getDate, getTime, getTimeZone);
}

class _DateTimeState extends State<DateTime> {
  Function getDate;
  Function getTime;
  Function getTimeZone;

  _DateTimeState(this.getDate, this.getTime, this.getTimeZone);

  late ShowTimeProvider _showTimeProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showTimeProvider = Provider.of<ShowTimeProvider>(context, listen: false);
    _showTimeProvider.valueItemSelected == null
        ? _showTimeProvider.getTimeZome()
        : SizedBox();
  }

  @override
  List? userdata;
  late Map data;
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: CustomAppBar(
        visual: false,
        title: AppLocalizations.instance.text("Show Date and Time"),
        child: Form(
          key: _formKey,
          child: Container(
            height: double.infinity,
            color: Color(0xFFEEEEEE),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 130,
                  ),

                  Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: InputTextField(
                              child: TextFormField(
                            readOnly: true,
                            controller: _showTimeProvider.selectStartdate,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(' ')
                            ],
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  AppLocalizations.instance.text("Start Date"),
                              contentPadding: EdgeInsets.only(left: 20),
                              hintStyle: TextStyle(fontSize: 17),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter start date';
                              }
                              return null;
                            },
                            onTap: () {
                              _showTimeProvider.setStartDate(context);
                            },
                          )),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: InputTextField(
                              child: TextFormField(
                            readOnly: true,
                            controller: _showTimeProvider.selectEnddate,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(' ')
                            ],
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  AppLocalizations.instance.text("End Date"),
                              contentPadding: EdgeInsets.only(left: 20),
                              hintStyle: TextStyle(fontSize: 17),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter end date  ';
                              }
                              return null;
                            },
                            onTap: () {
                              _showTimeProvider.setEndDate(context);
                            },
                          )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: InputTextField(
                              child: TextFormField(
                            readOnly: true,
                            controller: _showTimeProvider.selecteStartTime,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(' ')
                            ],
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  AppLocalizations.instance.text("Start Time"),
                              contentPadding: EdgeInsets.only(left: 20),
                              hintStyle: TextStyle(fontSize: 17),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter start time ';
                              }
                              return null;
                            },
                            onTap: () {
                              _showTimeProvider.startTime(context);
                            },
                          )),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: InputTextField(
                              child: TextFormField(
                            readOnly: true,
                            controller: _showTimeProvider.selectEndTime,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(' ')
                            ],
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  AppLocalizations.instance.text("End Time"),
                              contentPadding: EdgeInsets.only(left: 20),
                              hintStyle: TextStyle(fontSize: 17),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter end time ';
                              }
                              return null;
                            },
                            onTap: () {
                              _showTimeProvider.endTime(context);
                            },
                          )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  // Padding(
                  //     padding: const EdgeInsets.only(left: 20, right: 20),
                  //     child: InputTextField(
                  //       child: DropdownButton(
                  //           value: selectedname,
                  //           hint: Center(child: Text("Select Time zone")),
                  //           items: userdata!.map(
                  //             (userdate) {
                  //               return DropdownMenuItem(
                  //                 child: Text(userdate['name']),
                  //                 value: userdate['_id'].toString(),
                  //               );
                  //             },
                  //           ).toList(),
                  //           isExpanded: true,
                  //           underline: SizedBox(
                  //             height: 10,
                  //           ),
                  //           onChanged: (value) {
                  //             setState(
                  //               () {
                  //                 selectedname = value as String?;
                  //                 print(selectedname);
                  //               },
                  //             );
                  //           }),
                  //     )),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TimeZoneDrop(),
                  ),
                  SizedBox(height: 20),
                  // GestureDetector(
                  //   // onTap: () => _loginProvider.hitLoginApi(context),
                  //   onTap: () {
                  //
                  //     if (_formKey.currentState!.validate()&& _showTimeProvider.selectedTimezoneId!=null) {
                  //       getDate(_showTimeProvider.selectStartdate.text,
                  //           _showTimeProvider.selectEnddate.text);
                  //       getTime(_showTimeProvider.selecteStartTime.text,
                  //           _showTimeProvider.selectEndTime.text);
                  //
                  //       getTimeZone(_showTimeProvider.selectedTimezoneId);
                  //       Navigator.pop(context);
                  //     }                          },
                  //   child: Container(
                  //     width: double.infinity,
                  //     height: 50,
                  //     margin: EdgeInsets.only(
                  //         left: 20, right: 20, top: 10, bottom: 5),
                  //     decoration: BoxDecoration(
                  //         color: Color(0xFF1A62A9),
                  //         borderRadius:
                  //             BorderRadius.all(Radius.circular(20)),
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Color(0xFFD9D8D8),
                  //             offset: Offset(5.0, 5.0),
                  //             blurRadius: 7,
                  //           ),
                  //           BoxShadow(
                  //             color: Colors.white.withOpacity(.4),
                  //             offset: Offset(-5.0, -5.0),
                  //             blurRadius: 10,
                  //           ),
                  //         ]),
                  //     child: Center(
                  //         child: Text(
                  //       "Save",
                  //       style: TextStyle(
                  //         color: Color(0xFFEEEEEE),
                  //         fontSize: 22,
                  //       ),
                  //     )),
                  //   ),
                  // ),

                  CommanButtonWidget(
                      title: AppLocalizations.instance.text("Save"),
                      titleColor: Colors.white,
                      buttonColor: PrimaryColor,
                      onDoneFuction: () {
                        _showTimeProvider.changeDateTimeZone();
                        if (_formKey.currentState!.validate() &&
                            _showTimeProvider.selectedTimezoneId != null) {
                          if (_showTimeProvider.startDate.compareTo(_showTimeProvider.endDate) >
                              0) {

                            showMessage("End date time should be greater than start date time");
                          } else {
                            getDate(_showTimeProvider.selectStartdate.text,
                                _showTimeProvider.selectEnddate.text);
                            getTime(_showTimeProvider.selecteStartTime.text,
                                _showTimeProvider.selectEndTime.text);

                            getTimeZone(_showTimeProvider.selectedTimezoneId);
                            Navigator.pop(context);
                          }
                        }
                      },
                      loder: false)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  fetchPost() async {
    var url = SERVER_URL + "/api/v1/timezone/list";
    final response = await http.post(Uri.parse(
      url,
    ));
    data = json.decode(response.body);
    print(data);
    setState(() {
      userdata = data["data"];
    });
  }
}
