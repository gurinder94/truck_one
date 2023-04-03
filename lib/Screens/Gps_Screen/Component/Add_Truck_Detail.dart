import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TruckListModel.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Custom_App_Bar_Widget.dart';

import 'package:provider/provider.dart';

import '../../../AppUtils/constants.dart';
import '../../Language_Screen/application_localizations.dart';
import '../provider/add_Trip_Provider.dart';

class AddTruckDetails extends StatefulWidget {
  const AddTruckDetails({Key? key}) : super(key: key);

  @override
  State<AddTruckDetails> createState() => _AddTruckDetailsState();
}

class _AddTruckDetailsState extends State<AddTruckDetails> {
  @override
  late AddTripProvider _addTripProvider;
  var valueModel;
  late TruckModel truckList;

  initState() {
    super.initState();
    _addTripProvider = context.read<AddTripProvider>();

    _addTripProvider.truckList.length == 0
        ? _addTripProvider.hitGetTruck(context)
        : valueModel = _addTripProvider.truckIndexValue;
  }

  Widget build(BuildContext context) {
    return CustomAppBarWidget(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: AppLocalizations.instance.text('Add Truck'),
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
        child: Consumer<AddTripProvider>(builder: (_, proData, __) {
          if (proData.getLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (proData.truckListModel == null || proData.truckList.length == 0)
            return Center(
                child: Text(AppLocalizations.instance.text("No Record Found")));
          else
            return ListView.builder(
                itemCount: proData.truckList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: ListTile(
                        leading: Container(
                          width: 20,
                          child: RadioListTile<String>(
                            value: index.toString(),
                            groupValue:proData.truckList[index].id==proData.truckId?valueModel=index.toString(): valueModel,
                            onChanged: (val) => proData.model.routes==null?setState(() {
                              valueModel = val;
                              _addTripProvider.setValueTruck(
                                  proData.truckList[index],
                                  int.parse(valueModel));
                              Navigator.pop(context);
                            }):setState(() {
                              valueModel = val;
                              _addTripProvider.setValueTruck(
                                  proData.truckList[index],
                                  int.parse(valueModel));
                              _addTripProvider.setResetRoute();
                              Navigator.pop(context);
                            }),
                          ),
                        ),
                        title: Text(proData.truckList[index].name)),
                    onTap: ()
                    {

                    },
                  );
                });
        }));
  }
}
