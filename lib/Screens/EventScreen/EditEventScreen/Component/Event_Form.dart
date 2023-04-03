import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_place/google_place.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/EditEventScreen/Component/ArchivedDrop.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/EditEventScreen/Component/Show_date_time.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/EditEventScreen/Provider/EditProvider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:provider/provider.dart';
import '../../../../AppUtils/comman_validation.dart';
import '../../../commanWidget/comman_button_widget.dart';


class EventEditForm extends StatefulWidget {
  EditEventProvider editEventProvider;
  EventEditForm(this.editEventProvider);

  @override
  _EventEditForm createState() => _EventEditForm();
}

class _EventEditForm extends State<EventEditForm> {



  List<AutocompletePrediction> predictions = [];
   double? Longitude;
   double ?Latitude;

  @override


  void initState() {
    super.initState();


    handleSearch(widget.editEventProvider.addressController.text);



  }

  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(
            height: 20,
          ),
          InputTextField(
              child: TextFormField(
                  controller:   widget.editEventProvider.nameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Event Name",
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FaIcon(FontAwesomeIcons.calendarCheck),
                    ),
                    hintStyle: TextStyle(fontSize: 17),
                  ),
                  validator: (value) => eventNameValidation(value))),

          SizedBox(
            height: 20,
          ),
          InputTextField(
              child: TextFormField(
                controller: widget.editEventProvider.startdateController,
                readOnly: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Date and Time",
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FaIcon(FontAwesomeIcons.calendar),
                  ),
                  hintStyle: TextStyle(fontSize: 17),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter date & time  ';
                  }
                  return null;
                },
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DateTimeEdit(
                              widget.editEventProvider.getDate,
                              widget.editEventProvider.getTime,
                              widget.editEventProvider.getTimeZone,
                              widget.editEventProvider
                          )));
                },
              )),

          SizedBox(
            height: 20,
          ),
          InputTextField(
            child: TextFormField(
                minLines: 1,
                maxLines: 5,

                keyboardType: TextInputType.multiline,
                controller: widget.editEventProvider.descriptionController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(2000),
                ],
                textInputAction: TextInputAction.next,

                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Description",
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.description),
                  ),
                  hintStyle: TextStyle(fontSize: 17),
                ),
                validator: (value) => descriptionValidation(value)),
          ),

          SizedBox(
            height: 20,
          ),
          InputTextField(
            child: TextFormField(
                controller: widget.editEventProvider.speakersController,
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
                  hintText: "Speaker",
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.description),
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
                        child: Text(widget.editEventProvider.Currreny.toString()),
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
                          widget.editEventProvider.Currreny = value!;
                        });
                      },
                    ),
                  ),
                ),
               ),

              Expanded(
                child: InputTextField(
                  child: TextFormField(
                      controller: widget.editEventProvider.eventFeeController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        FilteringTextInputFormatter.deny(' ')
                      ],
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Event Fee",
                        hintStyle: TextStyle(fontSize: 17),
                        icon: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: FaIcon(FontAwesomeIcons.dollarSign),
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
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                prefixIcon: Icon(Icons.person),
              ),
              isExpanded: true,
              hint: Padding(
                padding: const EdgeInsets.only(left: 15),
                // ignore: unnecessary_null_comparison
                child: Text(widget.editEventProvider.visibility.toString()),
              ),
              items: <String>['Public', 'Private'].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (value) {
                widget.editEventProvider.setVisibility(value!);

              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Checkbox(
                  value: widget.editEventProvider.checkbox,
                  onChanged: (bool? value) {
                    widget.editEventProvider.setcheckbox(value);


                      widget.editEventProvider.getLocation(value);

                  }),
              Text("This  is an online event ")
            ],
          ),
          SizedBox(
            height: 10,
          ),
          widget.editEventProvider.checkbox== false
              ? Column(
                  children: [
                    InputTextField(
                        child: TextFormField(
                          controller: widget.editEventProvider.addressController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [

                            FilteringTextInputFormatter.deny(' ')
                          ],
                          // textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Address",
                            icon: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: FaIcon(FontAwesomeIcons.addressCard),
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
                            if (value.length == 0) {
                              // return 0;
                            }
                            if (value.isNotEmpty) {
                              setState(() {
                                autoCompleteSearch(value);
                              });
                            } else {
                              if (predictions.length > 0 && mounted) {
                                setState(() {
                                  predictions = [];
                                });
                              }
                            }
                          },
                        )),

                    SizedBox(
                      height: 10,
                    ),
                    predictions.isEmpty
                        ? Container()
                        : Container(
                            width: double.infinity,
                            height: 200,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: predictions.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    child: Icon(
                                      Icons.pin_drop,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Text(predictions[index].description!),
                                  onTap: () {
                                    setState(() {
                                      widget.editEventProvider
                                              .addressController.text =
                                          predictions[index].description!;
                                      handleSearch(widget.editEventProvider
                                          .addressController.text);
                                      debugPrint(predictions[index].placeId);
                                      predictions = [];
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    InputTextField(
                        child: TextFormField(
                          controller: widget.editEventProvider.venueController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [

                            FilteringTextInputFormatter.deny(' ')
                          ],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Venue",

                            icon: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: FaIcon(
                                FontAwesomeIcons.map,
                              ),
                            ),
                            hintStyle: TextStyle(fontSize: 17,),
                          ),
                          validator: (value) => eventvenuValidation(value),
                        )),

                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              :  SizedBox(
            height: 10,
          ),

          widget.editEventProvider.checkbox== true? InputTextField(
              child: TextFormField(
                controller: widget.editEventProvider.broadcastController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [

                  FilteringTextInputFormatter.deny(' ')
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Broadcast Link",
                  contentPadding: EdgeInsets.only(left: 15),
                  hintStyle: TextStyle(fontSize: 17),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter broadcast';
                  }
                  return null;
                },
              ))  :SizedBox(
            height: 10,
          ),
          widget.editEventProvider.checkbox == true?   SizedBox(
            height: 20,
          ):SizedBox(),
           InputTextField(child: ArchivedDrop()),
SizedBox(height: 5,),
          Selector<EditEventProvider, bool>(
              selector: (_, provider) => provider.loading,
              builder: (context, loder, child) {
                return     CommanButtonWidget(
                  title: "Update",
                  buttonColor: PrimaryColor,
                  titleColor: APP_BG,
                  onDoneFuction: () {
                    widget.editEventProvider
                        .hitEventUpdate(context, widget.editEventProvider.eventModel.id);
                  },
                  loder: loder,
                );
              }),

          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Future<void> autoCompleteSearch(String value) async {
    var googlePlace = GooglePlace("AIzaSyC0y2S4-iE2rHkYdyAsglz_qirv0UtpF1s");
    var risult = await googlePlace.autocomplete.get(value);
    print(risult!.predictions![0].description);
    if (risult.predictions != null) {
      setState(() {
        predictions = risult.predictions!;
      });
    }
  }

  Future handleSearch(var query) async {
    if (query.length > 8) {
      try {
        List locations = await locationFromAddress(query);
        locations.forEach((location) async {
          List<Placemark> placeMarks = await placemarkFromCoordinates(
              location.latitude, location.longitude);
          /*  placeMarks.forEach((placeMark) {
              addPlace();
            });*/
          setState(() {
            Longitude = location.longitude;
            Latitude = location.latitude;

            widget.editEventProvider.getAddress(Longitude, Latitude);
          });
        });
      } on Exception catch (e) {
        print(e);
      }
    }
  }
}
