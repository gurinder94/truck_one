import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_place/google_place.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Button.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:provider/provider.dart';

import 'Compoment/DropAlternateRoutes.dart';
import 'Compoment/DropArrive.dart';
import 'Provider/AddPlannerProvider.dart';

class AddTripPlanner extends StatefulWidget {
  const AddTripPlanner({Key? key}) : super(key: key);

  @override
  _AddTripPlannerState createState() => _AddTripPlannerState();
}

class _AddTripPlannerState extends State<AddTripPlanner> {
  List<AutocompletePrediction> predictions = [];
  List<AutocompletePrediction> predictionsDestination = [];

  late AddTripPlannerProvider addTripPlannerProvider;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    addTripPlannerProvider =
        Provider.of<AddTripPlannerProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild");
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
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
                  controller: addTripPlannerProvider.sourceAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Origin Location Source',
                    contentPadding: EdgeInsets.all(15),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter origin location';

                      setState(() {
                        predictions.isEmpty;
                      });
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      autoCompleteSearch(value);
                      setState(() {});
                    } else {
                      if (predictions.length > 0 && mounted) {
                        setState(() {
                          predictions = [];
                        });
                      }
                    }
                  }),
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
                              addTripPlannerProvider.sourceAddress.text =
                                  predictions[index].description!;
                              debugPrint(predictions[index].placeId);
                              handleSearch(
                                  addTripPlannerProvider.sourceAddress.text);
                              predictions = [];
                            });
                          },
                        );
                      },
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            InputTextField(
              child: TextFormField(
                  controller: addTripPlannerProvider.desinationAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Origin Location Destination',
                    contentPadding: EdgeInsets.all(15),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter location destination';

                      setState(() {
                        predictions.isEmpty;
                      });
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      autoCompleteSecondSearch(value);
                      setState(() {});
                    } else {
                      if (predictionsDestination.length > 0 && mounted) {
                        setState(() {
                          predictionsDestination = [];
                        });
                      }
                    }
                  }),
            ),
            predictionsDestination.isEmpty
                ? Container()
                : Container(
                    width: double.infinity,
                    height: 200,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: predictionsDestination.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: Icon(
                              Icons.pin_drop,
                              color: Colors.white,
                            ),
                          ),
                          title:
                              Text(predictionsDestination[index].description!),
                          onTap: () {
                            setState(() {
                              addTripPlannerProvider.desinationAddress.text =
                                  predictionsDestination[index].description!;
                              debugPrint(predictionsDestination[index].placeId);
                              handleDestination(addTripPlannerProvider
                                  .desinationAddress.text);
                              predictionsDestination = [];
                            });
                          },
                        );
                      },
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            InputTextField(
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: addTripPlannerProvider.selecteStartDate,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Choose Start Date Source ',
                    contentPadding: EdgeInsets.all(15),
                    prefixIcon: Icon(Icons.calendar_today)),
                onTap: () {
                  addTripPlannerProvider.setStartDate(context);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter start date';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InputTextField(
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: addTripPlannerProvider.selecteStartTime,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Choose Time  ',
                    contentPadding: EdgeInsets.all(15),
                    prefixIcon: Icon(Icons.calendar_today)),
                onTap: () {
                  addTripPlannerProvider.startTime(context);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter time';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DropArrive(),
            SizedBox(
              height: 20,
            ),
            DropAlternateRoutes(),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [],
            ),
            GestureDetector(
              child: Button(
                text: "Submit",
                Textcolor: Colors.white,
                colorcode: PrimaryColor,
              ),
              onTap: () {
                if (addTripPlannerProvider.ValueSelectDriver == null) {
                  showMessage("Please select driver's name");
                } else if (addTripPlannerProvider.valueTruckName == null) {
                  showMessage("Please select truck's name");
                } else if (addTripPlannerProvider.valueTrailerName == null) {
                  showMessage("Please select trailer's name");
                } else {
                  if (_formKey.currentState!.validate()) {
                    addTripPlannerProvider.hitCreateTripPlanner(context);
                  }
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  autoCompleteSearch(String value) async {
    var googlePlace = GooglePlace("AIzaSyC0y2S4-iE2rHkYdyAsglz_qirv0UtpF1s");
    var risult = await googlePlace.autocomplete.get(value);
    print(risult!.predictions![0].description);
    if (risult.predictions != null) {
      setState(() {
        predictions = risult.predictions!;
      });
    }
  }

  autoCompleteSecondSearch(String value) async {
    var googlePlace = GooglePlace("AIzaSyC0y2S4-iE2rHkYdyAsglz_qirv0UtpF1s");
    var risult = await googlePlace.autocomplete.get(value);
    print(risult!.predictions![0].description);
    if (risult.predictions != null) {
      setState(() {
        predictionsDestination = risult.predictions!;
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
            // addTripPlannerProvider.getSourceAddress(
            //     location.latitude, location.longitude);
            addTripPlannerProvider.sourceLatitude = location.latitude;
            addTripPlannerProvider.sourceLongitude = location.longitude;
          });
        });
      } on Exception catch (e) {
        print(e);
      }
    }
  }

  handleDestination(var query) async {
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
            addTripPlannerProvider.destinationLatitude = location.latitude;
            addTripPlannerProvider.destinationLongitude = location.longitude;

            // addTripPlannerProvider.getDestinationAddress(
            //     location.latitude, location.longitude);
          });
        });
      } on Exception catch (e) {
        print(e);
      }
    }
  }
}
