import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

import '../../commanWidget/Custom_App_Bar_Widget.dart';
import '../../commanWidget/input_shape.dart';
import '../provider/add_Trip_Provider.dart';
import '../provider/choose_Source_Provider.dart';
import 'arrive_drop.dart';

class BasicTripDetail extends StatelessWidget {
  late AddTripProvider _addTripProvider;

  @override
  Widget build(BuildContext context) {
    _addTripProvider = context.read<AddTripProvider>();

    return CustomAppBarWidget(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: AppLocalizations.instance.text('Basic Trip Detail'),
        actions: GestureDetector(
            child: Row(
              children: [
                GestureDetector(
                    child: Text(AppLocalizations.instance.text('Save')),
                    onTap: () {
                      if (_addTripProvider.model.routes == null)
                        Navigator.pop(context);
                      else {
                        _addTripProvider.setResetRoute();
                        Navigator.pop(context);
                      }
                    }),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            onTap: () async {}),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 90,
              ),
              Text(
                AppLocalizations.instance.text('Gross Weight (lbs)'),
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              InputShape(
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(5),
                    FilteringTextInputFormatter.deny(' ')
                  ],
                  controller: _addTripProvider.grossWeight,
                  onChanged: (val) {},
                  decoration: InputDecoration(
                    hintText: AppLocalizations.instance
                        .text('Enter gross weight (lbs)'),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.instance.text('Date'),
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              InputShape(
                child: TextFormField(
                    readOnly: true,
                    controller: _addTripProvider.startDate,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.instance.text('Select Date'),
                      border: InputBorder.none,
                    ),
                    onTap: () {
                      _addTripProvider.setStartDate(context);
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.instance.text('Time'),
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              InputShape(
                child: TextFormField(
                  controller: _addTripProvider.endTime,
                  readOnly: true,
                  onChanged: (val) {},
                  decoration: InputDecoration(
                    hintText: AppLocalizations.instance.text('Select Time'),
                    border: InputBorder.none,
                  ),
                  onTap: () {
                    _addTripProvider.startTime(context);
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ChangeNotifierProvider(
                  create: (_) => ChooseSourceProvider(),
                  child: TripDrop(_addTripProvider))
            ],
          ),
        ),
        floatingActionWidget: SizedBox());
  }
}
