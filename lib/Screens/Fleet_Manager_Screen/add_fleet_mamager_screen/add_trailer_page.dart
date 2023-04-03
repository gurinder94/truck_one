import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/AppUtils/data_items.dart';
import 'package:my_truck_dot_one/Screens/Fleet_Manager_Screen/add_fleet_mamager_screen/add_fleet_manager_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_button_widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_drop.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network.dart';
import 'package:provider/provider.dart';


class AddTrailerPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 55,
        title: Text( AppLocalizations.instance
            .text("Add Trailer")),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: APP_BAR_BG,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
        ),
      ),
      body: SingleChildScrollView(
        child:
            Consumer<AddFleetManagerProvider>(builder: (context, noti, child) {
          return noti.loading
              ? CircularProgressIndicator()
              : Container(
                  padding: EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                                height: 200,
                                width: double.infinity,
                                child:noti.imageloder==true?Center(child: CircularProgressIndicator()): CustomImage(
                                  image: noti.image == null ? "" : noti.image,
                                  height: 200,
                                  width: double.infinity,
                                  boxFit: BoxFit.cover,
                                )),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: PrimaryColor),
                                ),
                                onTap: () {
                                  noti.getFromGallery(context, "TRAILERIMAGE");
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputTextField(
                          child: TextFormField(
                            controller: noti.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(15),
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:AppLocalizations.instance
                                  .text("Enter Your Nick Name") ,
                              hintStyle: TextStyle(fontSize: 17),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please enter nick name';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InputTextField(
                          child: TextFormField(
                            controller: noti.weight,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(6),
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppLocalizations.instance
                                  .text("Enter Your Weight(lbs)") ,
                              hintStyle: TextStyle(fontSize: 17),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please enter weight(lbs)';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InputTextField(
                          child: TextFormField(
                            controller: noti.height,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:AppLocalizations.instance
                                  .text("Enter Your Height(in)") ,
                              hintStyle: TextStyle(fontSize: 17),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please enter height(in)';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InputTextField(
                          child: TextFormField(
                            controller: noti.width,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppLocalizations.instance
                                  .text("Enter Your Width(in)"),
                              hintStyle: TextStyle(fontSize: 17),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please enter width(in)';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // CommanDrop(
                        //   onChangedFunction: (dynamic newValue) {
                        //     print(newValue.id);
                        //   },
                        //   selectValue: null,
                        //   itemsList: noti.brandList.map((Datum items) {
                        //     return DropdownMenuItem(
                        //       value: items,
                        //       child: Text(items.brand.toString()),
                        //     );
                        //   }).toList(),
                        // ),
                        CommanDrop(
                          onChangedFunction: (String newValue) {
                            noti.setTrailerValue(newValue);
                          },
                          selectValue: noti.trailerName,
                          title:AppLocalizations.instance
                              .text("Please Select Trailer Name"),
                          itemsList: trailerType.map<DropdownMenuItem<String>>(
                            (final String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InputTextField(
                          child: TextFormField(
                            controller: noti.capacity,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppLocalizations.instance
                                  .text("Enter Your Load Capacity(lbs)"),
                              hintStyle: TextStyle(fontSize: 17),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please enter load capacity';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CommanButtonWidget(
                          title: AppLocalizations.instance.text("Create"),
                          buttonColor: PrimaryColor,
                          titleColor: APP_BG,
                          onDoneFuction: () {
                            if (_formKey.currentState!.validate()) {
                              if (noti.trailerName == null) {
                                showMessage("Please Enter Trailer Type");
                              } else
                                noti.hitAddFleetManager("trailer");
                            }
                          },
                          loder:  noti.loder,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
