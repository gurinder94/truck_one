import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../AppUtils/constants.dart';
import '../../Language_Screen/application_localizations.dart';
import '../../commanWidget/Custom_App_Bar_Widget.dart';
import '../../commanWidget/input_shape.dart';
import '../provider/add_Trip_Provider.dart';
import '../provider/choose_Source_Provider.dart';
import 'choose_destination_dart.dart';
import 'choose_source.dart';

class MyLocation extends StatelessWidget {
  late AddTripProvider _addTripProvider;
  GlobalKey<FormState> globalKey = GlobalKey();

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
                  height: 90,
                ),
                Row(
                  children: [
                    Container(
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
                /*     Row(
                  children: [
                    Icon(Icons.location_on, size: 30),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.4,
                      height: 40,
                      child: InputShape(
                        child: TextFormField(
                            readOnly: true,
                            controller: _addTripProvider.chooseDestination,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.instance
                                  .text('Choose  Destination'),
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
                                              child: ChooseDestination(
                                                  _addTripProvider
                                                      .chooseDestination,
                                                  _addTripProvider))));
                            }),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    noti.addAddressData.length > 0
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
                ),*/
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: noti.addAddressData.length,
                  itemBuilder: (context, i) => Visibility(
                      visible: noti.addAddressData.length > 0,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 30),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: 40,
                                child: InputShape(
                                  child: TextFormField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                          labelText: noti.addAddressData[i]["address"],
                                          hintText: AppLocalizations.instance
                                              .text('Choose Destination'),
                                          border: InputBorder.none,
                                          prefixIcon: Icon(Icons.search),
                                          suffixIcon: GestureDetector(
                                              onTap: () {
                                                if (noti.addAddressData.length >
                                                    0)
                                                  noti.addAddressData
                                                      .removeAt(i);

                                                noti.notifyListeners();
                                              },
                                              child: Icon(Icons.clear))),
                                      onTap: () {}),
                                ),
                              ),
                              /*  SizedBox(
                                width: 10,
                              ),
                              Container(
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
                                      child: Icon(Icons.add)))*/
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      )),
                ),
                Spacer(),
                noti.routeStart == true
                    ? CircularProgressIndicator()
                    : GestureDetector(
                        child: Container(
                          alignment: Alignment.topRight,
                          width: MediaQuery.of(context).size.width / 3,
                          height: 40,
                          child: Center(
                            child: Text(
                              AppLocalizations.instance.text('Submit'),
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
                            } else {
                              Navigator.of(context).pop({
                                _addTripProvider.chooseSource.text,
                                _addTripProvider.addAddressData
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
}
