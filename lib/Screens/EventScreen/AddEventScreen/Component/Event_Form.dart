import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/AddEventScreen/Provider/AddEventProvider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/AddEventScreen/Component/Show_date_time.dart';
import 'package:provider/provider.dart';
import '../../../../AppUtils/comman_validation.dart';
import '../../../Language_Screen/application_localizations.dart';
import '../../../commanWidget/comman_button_widget.dart';
import '../Provider/show_date_time_Provider.dart';

import 'address_list.dart';

class EventForm extends StatefulWidget {
  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  @override
  bool valuefirst = false;

  late AddEventProvider _addEventProvider;
  late String Visibility = "Public";
  late String Currreny = "USD";
  late ShowTimeProvider _showTimeProvider;
  late double Longitude;
  late double Latitude;
  String? s = "";

  void initState() {
    _addEventProvider = Provider.of<AddEventProvider>(context, listen: false);
    _addEventProvider.visibilityController.text = Visibility;
  }

  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            InputTextField(
                child: TextFormField(
                    controller: _addEventProvider.nameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:AppLocalizations.instance.text("Event Name"),
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FaIcon(FontAwesomeIcons.calendarCheck,size: 22,),
                      ),
                      hintStyle: TextStyle(fontSize: 17),
                    ),
                    validator: (value) => eventNameValidation(value))),
            SizedBox(
              height: 20,
            ),
            InputTextField(
                child: TextFormField(
              controller: _addEventProvider.startdateController,
              readOnly: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              inputFormatters: [FilteringTextInputFormatter.deny(' ')],
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText:AppLocalizations.instance.text("Date and Time"),
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FaIcon(FontAwesomeIcons.calendar,size: 22,),
                ),
                hintStyle: TextStyle(fontSize: 17),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter date & time  ';
                }

              },
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DateTime(
                            _addEventProvider.getDate,
                            _addEventProvider.getTime,
                            _addEventProvider.getTimeZone)));
              },
            )),
            SizedBox(
              height: 10,
            ),
            InputTextField(
              child: TextFormField(
                  controller: _addEventProvider.descriptionController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  minLines: 1,
                  maxLines: 10,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(2000),
                  ],
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:AppLocalizations.instance.text("Description"),
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.description,size: 22,),
                    ),
                    hintStyle: TextStyle(fontSize: 17),
                  ),
                  validator: (value) => descriptionValidation(value)),
            ),

            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputTextField(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          // prefixIcon: Icon(Icons.person),
                        ),
                        isExpanded: true,
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          // ignore: unnecessary_null_comparison
                          child: Text(Currreny),
                        ),
                        items:
                            <String>['USD', 'CAD', 'MXN'].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            Currreny = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: InputTextField(
                    child: TextFormField(
                        controller: _addEventProvider.eventFeeController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                          FilteringTextInputFormatter.deny(' ')
                        ],
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:AppLocalizations.instance.text("Event Fee"),
                          hintStyle: TextStyle(fontSize: 17),
                          icon: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: FaIcon(FontAwesomeIcons.dollarSign,size: 19,),
                          ),
                        ),
                        validator: (value) => eventFeeValidation(value)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            InputTextField(
                child: TextFormField(
                    controller: _addEventProvider.speakersController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:AppLocalizations.instance.text("Speaker"),
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.speaker,size: 22,),
                      ),
                      hintStyle: TextStyle(fontSize: 17),
                    ),
                    validator: (value) => eventspeakerValidation(value))),
            SizedBox(
              height: 20,
            ),
            InputTextField(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  prefixIcon: Icon(Icons.person),
                ),
                isExpanded: true,
                hint: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  // ignore: unnecessary_null_comparison
                  child: Text(Visibility),
                ),
                items: <String>['Public', 'Private'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    Visibility = value!;
                    _addEventProvider.visibilityController.text = Visibility;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Checkbox(
                    value: this.valuefirst,
                    onChanged: (bool? value) {
                      setState(() {
                        this.valuefirst = value!;
                        _addEventProvider.getLocation(valuefirst);
                      });
                    }),
                Text(AppLocalizations.instance.text("This is a virtual event")),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            valuefirst == false
                ? Column(
                    children: [
                      InputTextField(
                          child: TextFormField(
                        controller: _addEventProvider.addressController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        // textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:AppLocalizations.instance.text("Address"),
                          icon: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: FaIcon(FontAwesomeIcons.addressCard,size: 18,),
                          ),
                          hintStyle: TextStyle(fontSize: 17),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter address';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            _addEventProvider.autoCompleteSearch(value);
                          } else {
                            if (_addEventProvider.predictions.length == 0 &&
                                mounted) {
                              setState(() {
                                print(
                                    "jgi${_addEventProvider.predictions.length}");
                              });
                            }
                          }
                        },
                      )),
                      Selector<AddEventProvider, int>(
                          selector: (_, provider) =>
                              provider.predictions.length,
                          builder: (context, paginationLoading, child) {
                            return paginationLoading == 0
                                ? SizedBox()
                                : AddressList();
                          }),
                      SizedBox(
                        height: 10,
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      InputTextField(
                          child: TextFormField(
                        controller: _addEventProvider.venueController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: AppLocalizations.instance.text("Venue"),
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: FaIcon(
                              FontAwesomeIcons.map,size: 18,
                            ),
                          ),
                          hintStyle: TextStyle(fontSize: 17),
                        ),
                        validator: (value) => eventvenuValidation(value),
                      )),
                    ],
                  )
                : Container(),
            valuefirst == true
                ? InputTextField(
                    child: TextFormField(
                    controller: _addEventProvider.broadcastController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:AppLocalizations.instance.text("Broadcast Link"),
                      contentPadding: EdgeInsets.only(left: 15),
                      hintStyle: TextStyle(fontSize: 17),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter broadcast';
                      }
                      return null;
                    },
                  ))
                : Container(),
            SizedBox(
              height: 20,
            ),
            // InputTextField(child: Container(
            //     width: double.infinity,
            //     height: 200,
            //
            //     child: AddEventDescription())),
            Selector<AddEventProvider, bool>(
                selector: (_, provider) => provider.loading,
                builder: (context, loder, child) {
                  return CommanButtonWidget(
                    title: AppLocalizations.instance.text("Create"),
                    buttonColor: PrimaryColor,
                    titleColor: APP_BG,
                    onDoneFuction: () {

                      if (_formKey.currentState!.validate()) {
                        _addEventProvider.hitAddEvent(context, Currreny);
                      }
                    },
                    loder: loder, 
                  );
                }),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

}
