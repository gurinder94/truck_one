import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/CountryModel.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/Compoment/drop_down_box.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/provider/ProfileProvider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CompanyStateDrop extends StatelessWidget {
  ProfileProvider? _profileProvider;

  @override
  Widget build(BuildContext context) {
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    return Consumer<ProfileProvider>(builder: (context, notify, __) {
      print(_profileProvider!.state);

      return notify.countryModel == null
          ? CircularProgressIndicator()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropDownBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: DropdownButton<Datum>(
                      value: notify.dropdownValue,
                      isExpanded: true,
                      hint: Text('Select Country *',style: TextStyle(fontSize:16),),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                      ),
                      iconSize: 24,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(),
                      onChanged: (Datum? newValue) {
                        notify.setCountry(newValue!);
                      },
                      items: notify.countryModel!.data!.map((Datum value) {
                        return new DropdownMenuItem<Datum>(
                          value: value,
                          child: new Text(
                            value.countryName == null
                                ? ''
                                : value.countryName.toString(),
                            style: TextStyle(fontSize: 13),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                _profileProvider!.state == null
                    ? InputTextField(
                        child: TextFormField(
                          // controller: _profileProvider!.companyName=,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Select State *',
                            hintStyle: TextStyle(fontSize: 17),
                            contentPadding: EdgeInsets.all(10),
                          ),

                          // validator: (value) => companyNameValidation(value),
                        ),
                      )
                    : DropDownBox(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: DropdownButton<String>(
                            value: notify.state,
                            isExpanded: true,
                            hint: Text('Select State'),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey,
                            ),
                            iconSize: 24,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(),
                            onChanged: (String? newValue) {
                              var stateId=indexState(newValue!,notify);
                              notify.setState(newValue,stateId);
                            },
                            items: notify.states!.map((StateArr value) {
                              return new DropdownMenuItem<String>(
                                value: value.stateName,
                                child: new Text(
                                  value.stateName == null
                                      ? ''
                                      : value.stateName.toString(),
                                  style: TextStyle(fontSize: 13),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
              ],
            );
    });
  }
  indexState(String value, ProfileProvider notify) {
    final index = notify.states!.indexWhere((element) => element.stateName == value);
    return notify.states![index].id;


  }
}
