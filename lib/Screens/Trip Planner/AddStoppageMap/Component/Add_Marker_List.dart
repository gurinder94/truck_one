import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/AppUtils/data_items.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddStoppageMap/Provider/route_add_marker_provider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_button_widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/input_shape.dart';
import 'package:provider/provider.dart';

class AddMarkerList extends StatefulWidget {
  var LatLng;
  String? tripId;
  RouteMarkerProvider _routeMarkerProvider;

  AddMarkerList(this.LatLng, this.tripId, this._routeMarkerProvider);

  @override
  State<AddMarkerList> createState() => _AddMarkerListState();
  
}

class _AddMarkerListState extends State<AddMarkerList> {
  int? no;

  var group1Value;
  TextEditingController addMarkerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xFFEEEEEE),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        height: 430,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Add Marker',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 180,
              child: ListView.builder(
                  itemCount: MarkerList.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 20,
                            child: RadioListTile(
                              value: index,
                              groupValue: group1Value,
                              onChanged: (value) {
                                group1Value = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Row(
                            children: [
                              Container(
                                  width: 30,
                                  height: 30,
                                  child: Image.asset(
                                    MarkerList[index],
                                    width: 30,
                                    height: 30,
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                markerName[index],
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                          Spacer()
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          group1Value = index;
                        });
                      },
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 9),
                  child: Text(
                    "Description",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                )),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 5, right: 12),
              child: InputShape(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: TextFormField(
                    controller: addMarkerDescription,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(20),
                    ],
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Selector<RouteMarkerProvider, bool>(
                selector: (_, provider) => provider.addMarkerLoder,
                builder: (context, loder, child) {
                  return Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: CommanButtonWidget(
                      title: "Add Marker",
                      buttonColor: PrimaryColor,
                      titleColor: APP_BG,
                      onDoneFuction: () {
                    if(addMarkerDescription.text.isEmpty)
                      showMessage("Description is required");
                    else if(group1Value==null)
                      showMessage("Marker is required");
                      else
                        {
                          widget._routeMarkerProvider.companyAddMarker(
                              widget.LatLng,
                              MarkerList[group1Value],
                              markerName[group1Value],
                              widget.tripId!,
                              ServiceList[group1Value],
                              context,
                              widget._routeMarkerProvider, addMarkerDescription);
                          Navigator.pop(context);
                        }
                      },
                      loder: loder,
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
