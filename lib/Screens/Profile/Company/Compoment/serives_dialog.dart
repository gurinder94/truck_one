import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/ServiceModel.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/provider/ProfileProvider.dart';

class MultiServicesDialog extends StatefulWidget {
  ServiceModel? serviceModel;
  ProfileProvider? profileProvider;

  MultiServicesDialog(this.serviceModel, this.profileProvider);

  @override
  _MultiServicesDialogState createState() =>
      _MultiServicesDialogState(serviceModel, profileProvider);
}

class _MultiServicesDialogState extends State<MultiServicesDialog> {
  Map<dynamic, bool>? multi;
  ServiceModel? serviceModel;
  ProfileProvider? profileProvider;
  Map<String, dynamic>? serviceId;
  List mutiplevalue = [];
  List MutipleId = [];
  var sId;
  var selectename;

  _MultiServicesDialogState(this.serviceModel, this.profileProvider);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 300,
        width: 200,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Services',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                    itemCount: serviceModel!.data!.length,
                    itemBuilder: (context, index) {
                      var key = serviceModel!.data![index].serviceName;
                      return Row(
                        children: [
                          Text(
                            serviceModel!.data![index].serviceName.toString(),
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          Checkbox(
                              value:   serviceModel!.data![index].check,
                              onChanged: (val) {
                                serviceModel!.data![index].check = val!;
                                setState(() {});
                              })
                        ],
                      );
                    }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Text(
                      'Ok',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      var languages = [];
                      profileProvider!.productMap=[];
                      profileProvider!.ServiceId={};
                      List.generate(
                          serviceModel!.data!.length,
                              (index) => {
                            if ( serviceModel!.data![index].check == true)
                      {
                          languages.add( serviceModel!.data![index].serviceName.
                          toString()),
                      profileProvider!. ServiceId['serviceId'] = serviceModel!.data![index].id.toString(),
                      profileProvider!.productMap.add( profileProvider!. ServiceId),

                      }});
                     profileProvider!.serviceName.text = languages
                          .toString()
                          .replaceAll('[', '')
                          .replaceAll(']', '');

                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Text(
                      'Cancel',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}
