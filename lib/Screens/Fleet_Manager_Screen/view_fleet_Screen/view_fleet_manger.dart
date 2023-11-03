import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customapp.dart';
import 'package:provider/provider.dart';
import '../../Language_Screen/application_localizations.dart';
import 'Provider/View_fleet_Manger_Provider.dart';

class FleetDetail extends StatelessWidget {
  late ViewFleetManagerProvider _viewFleetManagerProvider;
  String id;

  FleetDetail(this.id);

  @override
  Widget build(BuildContext context) {
    _viewFleetManagerProvider = context.read<ViewFleetManagerProvider>();
    _viewFleetManagerProvider.hitFLeetDetails(
      context,
      id,
    );

    return CustomAppBar(
        title: AppLocalizations.instance.text('Detail Information'),
        visual: false,
        child: SingleChildScrollView(child:
            Consumer<ViewFleetManagerProvider>(builder: (_, proData, __) {
          return proData.fleetLoading == true
              ? Column(
                  children: [
                    SizedBox(
                      height: 300,
                    ),
                    Center(child: CircularProgressIndicator()),
                  ],
                )
              : proData.fleetManagerDetailModel.data!.vechicleType == "TRUCK"
                  ? Column(
                      children: [
                        Container(
                            height: 400,
                            width: double.infinity,
                            child: CustomImage(
                              image: Base_Url_Fleet_truck +
                                  proData.fleetManagerDetailModel.data!.image
                                      .toString(),
                              height: 400,
                              width: double.infinity,
                              boxFit: BoxFit.fill,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                displayText(
                                    AppLocalizations.instance.text('Nick Name'),
                                    proData.fleetManagerDetailModel.data!.name
                                        .toString(),
                                    'VIN',
                                    proData.fleetManagerDetailModel.data!.number
                                        .toString()),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                displayText(
                                  AppLocalizations.instance
                                      .text('Model Number'),
                                  proData
                                      .fleetManagerDetailModel.data!.modelNumber
                                      .toString(),
                                  'Other Brand',
                                  proData.fleetManagerDetailModel.data!
                                              .otherbrand
                                              .toString() ==
                                          "null"
                                      ? ""
                                      : proData.fleetManagerDetailModel.data!
                                          .otherbrand
                                          .toString(),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                displayText(
                                  AppLocalizations.instance.text('Weight'),
                                  proData.fleetManagerDetailModel.data!.weight
                                          .toString() +
                                      ' lbs',
                                  AppLocalizations.instance.text('Height'),
                                  proData.fleetManagerDetailModel.data!.height
                                          .toString() +
                                      ' in',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                displayText(
                                    AppLocalizations.instance.text('Width'),
                                    proData.fleetManagerDetailModel.data!.width
                                            .toString() +
                                        ' in',
                                    AppLocalizations.instance.text('Power'),
                                    proData.fleetManagerDetailModel.data!.power
                                            .toString() +
                                        ' hp'),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                displayText(
                                    AppLocalizations.instance
                                        .text('Engine Number'),
                                    proData.fleetManagerDetailModel.data!.engine
                                        .toString(),
                                    AppLocalizations.instance.text('Brand'),
                                    proData.fleetManagerDetailModel.data!.brand!
                                                    .name
                                                    .toString() ==
                                                "null" &&
                                            proData.fleetManagerDetailModel
                                                    .data!.otherbrand
                                                    .toString() ==
                                                "null"
                                        ? ""
                                        : proData.fleetManagerDetailModel.data!
                                                    .brand!.name
                                                    .toString() ==
                                                "null"
                                            ? "Others"
                                            : proData.fleetManagerDetailModel
                                                .data!.brand!.name
                                                .toString()),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                displayText(
                                    AppLocalizations.instance
                                        .text('Fuel Capacity'),
                                    proData.fleetManagerDetailModel.data!
                                            .fuelCapacity
                                            .toString() +
                                        ' gl',
                                    AppLocalizations.instance
                                        .text('Number of Tyres'),
                                    proData.fleetManagerDetailModel.data!
                                                .numOfTyres
                                                .toString() ==
                                            "0"
                                        ? "Other"
                                        : proData.fleetManagerDetailModel.data!
                                            .numOfTyres
                                            .toString()),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                displayText(
                                  AppLocalizations.instance.text('WheelBase'),
                                  proData.fleetManagerDetailModel.data!
                                          .wheelbase
                                          .toString() +
                                      ' in',
                                  AppLocalizations.instance.text('Fuel Type'),
                                  proData.fleetManagerDetailModel.data!.fuelType
                                      .toString(),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                Text(
                                  'Other Number Of Tyres',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  proData
                                      .fleetManagerDetailModel.data!.OtherTyre
                                      .toString(),
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                )
                              ]),
                          decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFD9D8D8),
                                  offset: Offset(5.0, 5.0),
                                  blurRadius: 7,
                                ),
                                BoxShadow(
                                  color: Colors.white.withOpacity(.5),
                                  offset: Offset(-5.0, -5.0),
                                  blurRadius: 7,
                                ),
                              ]),
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                          height: 400,
                          width: double.infinity,
                          child: Image.network(
                              Base_Url_Fleet_truck +
                                  _viewFleetManagerProvider
                                      .fleetManagerDetailModel.data!.image
                                      .toString(),
                              fit: BoxFit.fill,
                              loadingBuilder: (context, child, progress) {
                                return progress == null
                                    ? child
                                    : CircularProgressIndicator.adaptive();
                              },
                              errorBuilder: (a, b, c) => Image.asset(
                                    'assets/default.png',
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                  )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                displayText(
                                    AppLocalizations.instance.text('Nick Name'),
                                    _viewFleetManagerProvider
                                        .fleetManagerDetailModel.data!.name
                                        .toString(),
                                    AppLocalizations.instance.text('VIN'),
                                    _viewFleetManagerProvider
                                        .fleetManagerDetailModel
                                        .data!
                                        .trailerVinNumber
                                        .toString()),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                displayText(
                                    'Length',
                                    _viewFleetManagerProvider
                                        .fleetManagerDetailModel.data!.length
                                        .toString(),
                                    AppLocalizations.instance
                                        .text('Trailer Type'),
                                    _viewFleetManagerProvider
                                        .fleetManagerDetailModel
                                        .data!
                                        .trailerType
                                        .toString()),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                displayText(
                                  AppLocalizations.instance.text('Height'),
                                  _viewFleetManagerProvider
                                          .fleetManagerDetailModel.data!.height
                                          .toString() +
                                      ' in ',
                                  AppLocalizations.instance.text('Width'),
                                  _viewFleetManagerProvider
                                          .fleetManagerDetailModel.data!.width
                                          .toString() +
                                      ' in ',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                displayText(
                                    AppLocalizations.instance.text('Weight'),
                                    _viewFleetManagerProvider
                                            .fleetManagerDetailModel
                                            .data!
                                            .weight
                                            .toString() +
                                        ' lbs ',
                                    AppLocalizations.instance
                                        .text('Load Capacity'),
                                    _viewFleetManagerProvider
                                            .fleetManagerDetailModel
                                            .data!
                                            .loadCapacity
                                            .toString() +
                                        ' lbs '),
                                SizedBox(),
                                SizedBox(
                                  height: 30,
                                )
                              ]),
                          decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFD9D8D8),
                                  offset: Offset(5.0, 5.0),
                                  blurRadius: 7,
                                ),
                                BoxShadow(
                                  color: Colors.white.withOpacity(.5),
                                  offset: Offset(-5.0, -5.0),
                                  blurRadius: 7,
                                ),
                              ]),
                        )
                      ],
                    );
        })));
  }

  displayText(String name, String value, String name2, String value2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$name',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '$value',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        )),
        SizedBox(
          width: 20,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$name2',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '$value2',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        )),
      ],
    );
  }
}
