import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/AddEventScreen/Provider/show_date_time_Provider.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/EditEventScreen/Provider/EditProvider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';

import 'package:my_truck_dot_one/Screens/commanWidget/customapp.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'Edit_Time_zone.dart';

class DateTimeEdit extends StatefulWidget {
  Function getDate;
  Function getTime;
  Function getTimeZone;
  EditEventProvider  eventViewProvider;

  DateTimeEdit(
      this.getDate,
      this.getTime,
      this.getTimeZone, this.eventViewProvider,
      );

  @override
  _DateTimeEdit createState() => _DateTimeEdit(getDate, getTime, getTimeZone);
}

class _DateTimeEdit extends State<DateTimeEdit> {
  Function getDate;
  Function getTime;
  Function getTimeZone;

  _DateTimeEdit(this.getDate, this.getTime, this.getTimeZone);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _showTimeProvider = Provider.of<ShowTimeProvider>(context, listen: false);

_showTimeProvider. TimeZomeApi(widget.eventViewProvider.eventModel);




  }

  @override
  late ShowTimeProvider _showTimeProvider;
  String? selectedname;
  List? userdata;
  late Map data;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: CustomAppBar(
        visual: false,
        title: 'Show Date and Time',
        child:Selector<ShowTimeProvider, bool>(
    selector: (_, provider) => provider.loading,
    builder: (context, loder, child) {
      return


        Container(
          height: double.infinity,
          color: Color(0xFFEEEEEE),
          child: SingleChildScrollView(
            child:loder==true?Column(
              children: [
                SizedBox(height: 100,),
                Center(child: CircularProgressIndicator()),
              ],
            ): Column(
              children: [
                SizedBox(height: 130,),
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding:
                        const EdgeInsets.only(left: 20, right: 20),
                        child: InputTextField(
                            child: TextFormField(
                              controller: _showTimeProvider.selectStartdate,
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              inputFormatters: [

                                FilteringTextInputFormatter.deny(' ')
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Start Date",
                                contentPadding: EdgeInsets.only(left: 20),
                                hintStyle: TextStyle(fontSize: 17),
                              ),
                              onTap: () {
                                _showTimeProvider.setStartDate(context);
                              },
                            )),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding:
                        const EdgeInsets.only(left: 20, right: 20),
                        child: InputTextField(
                            child: TextFormField(
                              controller: _showTimeProvider.selectEnddate,
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              inputFormatters: [

                                FilteringTextInputFormatter.deny(' ')
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "End Date",
                                contentPadding: EdgeInsets.only(left: 20),
                                hintStyle: TextStyle(fontSize: 17),
                              ),
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
                        padding:
                        const EdgeInsets.only(left: 20, right: 20),
                        child: InputTextField(
                            child: TextFormField(
                              controller: _showTimeProvider.selecteStartTime,
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              inputFormatters: [

                                FilteringTextInputFormatter.deny(' ')
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Start Time",
                                contentPadding: EdgeInsets.only(left: 20),
                                hintStyle: TextStyle(fontSize: 17),
                              ),
                              onTap: () {
                                _showTimeProvider.startTime(context);
                              },
                            )),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding:
                        const EdgeInsets.only(left: 20, right: 20),
                        child: InputTextField(
                            child: TextFormField(
                              controller: _showTimeProvider.selectEndTime,
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              inputFormatters: [

                                FilteringTextInputFormatter.deny(' ')
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "End Time",
                                contentPadding: EdgeInsets.only(left: 20),
                                hintStyle: TextStyle(fontSize: 17),
                              ),
                              onTap: () {
                                _showTimeProvider.endTime(context);
                              },
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child:  EditTimeZone()),
                SizedBox(height: 20),
                GestureDetector(
                  // onTap: () => _loginProvider.hitLoginApi(context),
                  onTap: () {
                    if (_showTimeProvider.startDate
                        .compareTo(_showTimeProvider.endDate) >
                        0) {

                      showMessage("End date time should be greater than start date time");
                    }
                    else
                 {
                   getDate(_showTimeProvider.selectStartdate.text,
                       _showTimeProvider.selectEnddate.text);
                   getTime(_showTimeProvider.selectEndTime.text,
                       _showTimeProvider.selectEndTime.text);

                   getTimeZone(selectedname);
                   Navigator.pop(context);
                 }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 5),
                    decoration: BoxDecoration(
                        color: Color(0xFF1A62A9),
                        borderRadius:
                        BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFD9D8D8),
                            offset: Offset(5.0, 5.0),
                            blurRadius: 7,
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(.4),
                            offset: Offset(-5.0, -5.0),
                            blurRadius: 10,
                          ),
                        ]),
                    child: Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: Color(0xFFEEEEEE),
                            fontSize: 22,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        );
    }

    )
      ),
    );
  }

  fetchPost() async {
    var url = SERVER_URL+"/api/v1/timezone/list";

    final response = await http.post(Uri.parse(url));
    data = json.decode(response.body);
    print(data);
    setState(() {
      userdata = data["data"];
    });
   for(int i=0; i<data.length; i++)
     {
       if(widget.eventViewProvider.eventModel.timezoneId==data[i]['_id'])
       {
         print(data["data"]['_id']);
       }
     }
  }
}
