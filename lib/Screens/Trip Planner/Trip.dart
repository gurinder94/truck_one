import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TripPlannerListModel.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customapp.dart';
import 'package:provider/provider.dart';
import 'Component/TripPlannerItem.dart';

import 'Provider/TripPlannerProvider.dart';

class TripPlanner extends StatelessWidget {
  var size;
  late TripPlannerListProvider _listProvider;

  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    _listProvider =
        Provider.of<TripPlannerListProvider>(context, listen: false);

    size = MediaQuery.of(context).size;
    getEventList(context,'');
    return Scaffold(
        body: CustomAppBar(
            title: "Trip Planner",
            visual: false,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    Expanded(child: Consumer<TripPlannerListProvider>(
                        builder: (_, proData, __) {
                      if (proData.tripPlannerListLoad) {
                        return Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      if (proData.tripPlannerList == null ||
                          proData.tripPlannerList!.data!.length == 0)
                        return Center(child: Text('No Record Found'));
                      else
                        return ListView.builder(
                          itemCount: proData.tripPlannerList!.data!.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {

                            if (index == 0) {
                              return Column(
                                children: <Widget>[
                                  headerList(context),
                                  headerContext(context, proData, index)
                                ],
                              );
                            } else {
                              return headerContext(context, proData, index);
                            }
                          },
                        );
                    }))
                  ],
                ),
              ),
            )),


        );
  }

  getEventList(BuildContext context, String  type) async {
    var getId = await getUserId();
    print(getId);
    _listProvider.hitGetTripPannerList(context);
  }

  headerList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.all(5.0),
                width: size.width * 0.25,
                child: Center(
                  child: Text(
                    "Location",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(4.0),
                width: size.width * 0.25,
                child: Center(
                    child: Text("Destination",
                        style: TextStyle(color: Colors.white))),
              ),
              Container(
                padding: EdgeInsets.all(4.0),
                width: size.width * 0.20,
                child: Center(
                    child:
                        Text('Weight', style: TextStyle(color: Colors.white))),
              ),
              Container(
                  padding: EdgeInsets.all(4.0),
                  width: size.width * 0.20,
                  child: Center(
                      child: Text("Action",
                          style: TextStyle(color: Colors.white)))),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: PrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  headerContext(
      BuildContext context, TripPlannerListProvider proData, int index) {
    return ChangeNotifierProvider<TripPlannerModel>.value(
        value: proData.tripPlannerList!.data![index], child: TripItem());
  }
}
