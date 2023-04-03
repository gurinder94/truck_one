import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Custom_App_Bar_Widget.dart';
import 'package:provider/provider.dart';

import '../provider/add_Trip_Provider.dart';

class AddHazmatLoad extends StatefulWidget {
  @override
  State<AddHazmatLoad> createState() => _AddHazmatLoadState();
}

class _AddHazmatLoadState extends State<AddHazmatLoad> {
  var valueModel;
  var loadType = [
    {"type": "Explosives", "class": "USHazmatClass1"},
    {"type": "Compressed gas", "class": "USHazmatClass2"},
    {"type": "Flammable liquids", "class": "USHazmatClass3"},
    {"type": "Flammable solids", "class": "USHazmatClass4"},
    {"type": "Oxidizers", "class": "USHazmatClass5"},
    {"type": "Poisons", "class": "USHazmatClass6"},
    {"type": "Radioactive", "class": "USHazmatClass7"},
    {"type": "Corrosives", "class": "USHazmatClass8"},
    {"type": "Miscellaneous", "class": "USHazmatClass9"},
  ];
  late AddTripProvider _addTripProvider;
  initState() {
    super.initState();
    _addTripProvider = context.read<AddTripProvider>();
_addTripProvider.HazmatLoadValue==null?null:valueModel=_addTripProvider.HazmatIndex;
  }
  Widget build(BuildContext context) {

    return CustomAppBarWidget(
        leading: IconButton(onPressed: ()
        {
          Navigator.pop(context);
        }, icon:Icon(Icons.arrow_back)),
        title: AppLocalizations.instance.text('Add Hazmat Load'),
        actions: GestureDetector(
            child: Row(
              children: [
                // GestureDetector(
                //   child: Text("Save"),
                //   onTap: () async {},
                // ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            onTap: () async {}),
        child: ListView.builder(
            itemCount: loadType.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  leading: Container(
                      width: 20,
                      child: RadioListTile<String>(
                        value: index.toString(),
                        groupValue: valueModel,
                        onChanged: (val) =>  _addTripProvider.model.routes==null?setState(() {
                          valueModel = val;
                          _addTripProvider.setHazmatLoad(loadType[index]['class'].toString(),loadType[index]['type'].toString(),index.toString());
                          Navigator.pop(context);
                        }):setState(() {
                  valueModel = val;

                  _addTripProvider.setHazmatLoad(loadType[index]['class'].toString(),loadType[index]['type'].toString(),index.toString());
                  _addTripProvider.setResetRoute();
                  Navigator.pop(context);
                  }),
                      )),
                  title: Text("${loadType[index]['type']}"));
            }),
        floatingActionWidget: SizedBox());
  }
}
