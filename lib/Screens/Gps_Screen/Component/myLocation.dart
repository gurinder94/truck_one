import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../../AppUtils/constants.dart';
import '../../Language_Screen/application_localizations.dart';
import '../../commanWidget/Custom_App_Bar_Widget.dart';
import '../../commanWidget/input_shape.dart';
import '../provider/add_Trip_Provider.dart';
import '../provider/choose_Source_Provider.dart';
import 'choose_destination_dart.dart';
import 'choose_source.dart';

class MyLocation extends StatefulWidget {
  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  late AddTripProvider _addTripProvider;

  GlobalKey<FormState> globalKey = GlobalKey();

  StreamSubscription<Position>? positionStream;

  @override
  Widget build(BuildContext context) {
    _addTripProvider = context.read<AddTripProvider>();

    return CustomAppBarWidget(
      leading: GestureDetector(
        child: Icon(Icons.arrow_back),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      title: 'Add Location',
      actions: GestureDetector(
          child: Row(
            children: [
              SizedBox(
                width: 20,
              )
            ],
          ),
          onTap: () async {}),
      floatingActionWidget: SizedBox(),
      child: Consumer<AddTripProvider>(
        builder: (BuildContext context, noti, Widget? child) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_addTripProvider.model.routes == null)
                          getLocation(_addTripProvider);
                        else {
                          _addTripProvider.setResetRoute();
                          getLocation(_addTripProvider);
                        }
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        child: Container(
                          child: Icon(Icons.my_location_outlined,
                              color: Colors.blue, size: 20),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.2),
                            shape: BoxShape.circle),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.4,
                      height: 40,
                      child: InputShape(
                        child: TextFormField(
                          controller: _addTripProvider.chooseSource,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'Choose Starting point ',
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider(
                                            create: (_) =>
                                                ChooseSourceProvider(),
                                            child: ChooseSource(
                                                _addTripProvider.chooseSource,
                                                _addTripProvider))));
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    noti.addAddressData.length > 2
                        ? SizedBox()
                        : Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 5,
                                      offset: Offset(5, 5)),
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 1,
                                      offset: Offset(-1, -1)),
                                ]),
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider(
                                                  create: (_) =>
                                                      ChooseSourceProvider(),
                                                  child: ChooseNextDestination(
                                                      _addTripProvider
                                                          .choose1Destination,
                                                      _addTripProvider))));
                                },
                                child: Icon(Icons.add)))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                noti.addAddressData != null && noti.addAddressData.length > 0
                    ? Expanded(
                        child: ReorderableListView(
                          padding: EdgeInsets.zero,
                          children: List<Widget>.generate(
                              noti.addAddressData.length,
                              (index) => locationItemView(
                                  noti: noti,
                                  item: noti.addAddressData[index],
                                  context: context,
                                  i: index)).toList(),
                          onReorder: (int start, int current) {
                            // dragging from top to bottom
                            if (start < current) {
                              int end = current - 1;
                              Map<String, dynamic> startItem =
                                  noti.addAddressData[start];
                              int i = 0;
                              int local = start;
                              do {
                                noti.addAddressData[local] =
                                    noti.addAddressData[++local];
                                i++;
                              } while (i < end - start);
                              noti.addAddressData[end] = startItem;
                            }
                            // dragging from bottom to top
                            else if (start > current) {
                              Map<String, dynamic> startItem =
                                  noti.addAddressData[start];
                              for (int i = start; i > current; i--) {
                                noti.addAddressData[i] =
                                    noti.addAddressData[i - 1];
                              }
                              noti.addAddressData[current] = startItem;
                            }

                            noti.notifyListeners();
                          },
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 12,
                ),
                noti.routeStart == true
                    ? CircularProgressIndicator()
                    : GestureDetector(
                        child: Container(
                          alignment: Alignment.topRight,
                          width: MediaQuery.of(context).size.width / 3,
                          height: 40,
                          child: Center(
                            child: Text(
                              AppLocalizations.instance.text('Search'),
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: PrimaryColor,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onTap: () {
                          if (globalKey.currentState!.validate()) {
                            if (_addTripProvider.chooseSource.text == "") {
                              showMessage("Please choose start point");
                            } else if (_addTripProvider.addAddressData.length ==
                                0) {
                              showMessage("Please choose destination");
                            } else {
                              _addTripProvider.addAddressData
                                  .forEach((element) {
                                print("element>>> ${element}");
                              });
                              Navigator.of(context).pop({
                                "start_point":
                                    _addTripProvider.chooseSource.text,
                                "location_list": _addTripProvider.addAddressData
                              });
                            }
                          }
                        },
                      ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  locationItemView(
      {required AddTripProvider noti,
      required BuildContext context,
      required item,
      required int i}) {
    return ListTile(
      key: Key('$i'),
      trailing: GestureDetector(
          onTap: () {
            if (noti.addAddressData.length > 0) noti.addAddressData.removeAt(i);
            noti.notifyListeners();
          },
          child: SizedBox(
            height: 50,
            width: 28,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3), shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Icon(Icons.clear),
            ),
          )),
      title: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(Icons.location_on, size: 28),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: InputShape(
                  child: IgnorePointer(
                    child: TextFormField(
                        readOnly: true,
                        // enabled: false,
                        showCursor: false,
                        decoration: InputDecoration(
                          labelText: noti.addAddressData[i]["address"],
                          hintText: AppLocalizations.instance
                              .text('Choose Destination Data'),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          prefixIcon: Icon(Icons.search),
                        ),
                        onTap: () {}),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Future<void> getLocation(AddTripProvider addTripProvider) async {
    _addTripProvider.chooseSource.text = "Your location";
    positionStream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
      ),
    ).listen((Position position) {
      addTripProvider.setAddress(position.longitude, position.latitude);
    });
    setState(() {});
  }
}
