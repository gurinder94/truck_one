import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/AppUtils/data_items.dart';
import 'package:my_truck_dot_one/Screens/Fleet_Manager_Screen/Edit_fleet_manager_screen/edit_truck_manager_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_button_widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_drop.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network.dart';
import 'package:provider/provider.dart';

class EditTrailerManager extends StatefulWidget {
  EditTrailerManager();

  @override
  State<EditTrailerManager> createState() => _EditTrailerManagerState();
}

class _EditTrailerManagerState extends State<EditTrailerManager> {
  late EditTruckManagerProvider _editTruckManagerProvider;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _editTruckManagerProvider =
        Provider.of<EditTruckManagerProvider>(context, listen: false);
    _editTruckManagerProvider.hitGetTruckDetails("trailer");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 55,
        title: Text(AppLocalizations.instance.text("Edit Trailer")),
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
            Consumer<EditTruckManagerProvider>(builder: (context, noti, child) {
          return noti.loading
              ? Center(child: CircularProgressIndicator())
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
                                child: noti.imageLoder == true
                                    ? Center(child: CircularProgressIndicator())
                                    : CustomImage(
                                        image: noti.image == null
                                            ? ""
                                            : noti.image,
                                        height: 200,
                                        width: double.infinity,
                                        boxFit: BoxFit.fill,
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
                          height: 20,
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
                              hintText: AppLocalizations.instance
                                  .text("Enter Your Nick Name"),
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
                            controller: noti.vin,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(17),
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Your VIN",
                              hintStyle: TextStyle(fontSize: 17),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            onChanged: (val) {
                              if (noti.vin.text.length == 17) {
                                noti.hitVehicleData("trailer");
                              }
                            },
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please enter VIN';
                              } else if (value.length < 17) {
                                return 'Please Enter Your VIN';
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
                            readOnly: true,
                            controller: noti.length,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(6),
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Your length",
                              hintStyle: TextStyle(fontSize: 17),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please enter length';
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
                                  .text("Enter Your Weight(lbs)"),
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
                              hintText: AppLocalizations.instance
                                  .text("Enter Your Height(in)"),
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
                        CommanDrop(
                          title: AppLocalizations.instance
                              .text("Please select Trailer name"),
                          onChangedFunction: (String newValue) {
                            noti.setTrailerValue(newValue);
                          },
                          selectValue: noti.trailerName,
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
                        CommanDrop(
                          title: " ",
                          onChangedFunction: (String newValue) {
                            noti.setDelete(newValue);
                          },
                          selectValue: noti.isDeleteName,
                          itemsList: delete.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CommanButtonWidget(
                          title: AppLocalizations.instance.text("Update"),
                          buttonColor: PrimaryColor,
                          titleColor: APP_BG,
                          onDoneFuction: () {
                            if (_formKey.currentState!.validate()) {
                              if (noti.trailerName == null) {
                                showMessage("Please Enter Trailer Type");
                              } else
                                noti.hitUpdateVehicelType(
                                    noti.truckDetailModel!.data!.id!,
                                    "trailer");
                            }
                          },
                          loder: noti.loder,
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
