import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Gps_Screen/provider/add_Trip_Provider.dart';
import 'package:provider/provider.dart';

import '../../Language_Screen/application_localizations.dart';
import '../../commanWidget/Custom_App_Bar_Widget.dart';

class AddTrailerDetail extends StatefulWidget {
  @override
  State<AddTrailerDetail> createState() => _AddTrailerDetailState();
}

class _AddTrailerDetailState extends State<AddTrailerDetail> {
  @override
  var valueModel;
  late AddTripProvider _addTripProvider;

  initState() {
    super.initState();
    _addTripProvider = context.read<AddTripProvider>();

    _addTripProvider.trailerList.length == 0
        ? _addTripProvider.hitGetTrailer(context)
        : valueModel = _addTripProvider.trailerIndexValue;
  }

  Widget build(BuildContext context) {
    return CustomAppBarWidget(
        floatingActionWidget: SizedBox(),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: AppLocalizations.instance.text('Add Trailer'),
        actions: GestureDetector(
            child: Row(
              children: [
                // GestureDetector(
                //   child: Text("Save"),
                //   onTap: () async {
                //
                //     Navigator.pop(context);
                //   },
                // ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            onTap: () async {}),
        child: Consumer<AddTripProvider>(builder: (_, proData, __) {
          if (proData.getLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (proData.truckListModel == null || proData.trailerList.length == 0)
            return Center(
                child: Text(AppLocalizations.instance.text("No Record Found")));
          else
            return ListView.builder(
                itemCount: proData.trailerList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: Container(
                        width: 20,
                        child: RadioListTile<String>(
                          value: index.toString(),
                          groupValue:
                              proData.trailerList[index].id == proData.trailerId
                                  ? valueModel = index.toString()
                                  : valueModel,
                          onChanged: (val) => proData.model.routes == null
                              ? setState(() {
                                  valueModel = val;
                                  _addTripProvider.setValueTrailer(
                                      proData
                                          .trailerList[int.parse(valueModel)],
                                      int.parse(valueModel));
                                  Navigator.pop(context);
                                })
                              : setState(() {
                                  valueModel = val;
                                  valueModel = val;
                                  _addTripProvider.setValueTrailer(
                                      proData
                                          .trailerList[int.parse(valueModel)],
                                      int.parse(valueModel));
                                  _addTripProvider.setResetRoute();
                                  Navigator.pop(context);
                                }),
                        ),
                      ),
                      title: Text(proData.trailerList[index].name));
                });
        }));
  }
}
