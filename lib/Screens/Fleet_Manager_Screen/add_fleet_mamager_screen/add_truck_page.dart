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

import '../../../Model/E_commerce_Model/BrandListModel.dart';

class AddTruckManager extends StatefulWidget {
  const AddTruckManager({Key? key}) : super(key: key);

  @override
  State<AddTruckManager> createState() => _AddTruckManagerState();
}

class _AddTruckManagerState extends State<AddTruckManager> {
  late AddFleetManagerProvider _fleetManagerProvider;

  @override
  void initState() {
    // TODO: implement initState
    _fleetManagerProvider =
        Provider.of<AddFleetManagerProvider>(context, listen: false);
    _fleetManagerProvider.getBrandList();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 55,
        title: Text(AppLocalizations.instance.text("Add Truck")),
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
          print('BrandName ${noti.textType}');
          return noti.loading
              ? Center(child: CircularProgressIndicator())
              : Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                                height: 200,
                                width: double.infinity,
                                child: noti.imageloder == true
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
                                  noti.getFromGallery(context, "TRUCKIMAGE");
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
                          child: Focus(
                            onFocusChange: (value) {
                              if (noti.vin.text.length == 17)
                                noti.hitVehicleData("truck");
                            },
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
                              onFieldSubmitted: (val) {
                                if (noti.vin.text.length == 17) {
                                  noti.hitVehicleData("truck");
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
                        ),
                        noti.textType == null || noti.textType == ""
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CommanDrop(
                                    title: AppLocalizations.instance
                                        .text("Please Select Brand Name"),
                                    onChangedFunction: (dynamic newValue) {
                                      noti.setBrandValue(newValue);
                                    },
                                    selectValue: noti.brandvalue == null
                                        ? null
                                        : noti.brandvalue,
                                    itemsList:
                                        noti.brandList.map((Datum items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items.brand.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  InputTextField(
                                    child: TextFormField(
                                      controller: noti.brand,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter Brand Name",
                                        hintStyle: TextStyle(fontSize: 17),
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return 'Enter Brand Name';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                        noti.brandName != "Others"
                            ? SizedBox()
                            : noti.textType != null || noti.textType != ""
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      InputTextField(
                                        child: TextFormField(
                                          controller: noti.brand,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Enter Brand Name",
                                            hintStyle: TextStyle(fontSize: 17),
                                            contentPadding: EdgeInsets.all(10),
                                          ),
                                          validator: (value) {
                                            if (value!.trim().isEmpty) {
                                              return 'Enter Brand Name';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                        SizedBox(
                          height: 20,
                        ),
                        InputTextField(
                          child: TextFormField(
                            controller: noti.modelNumber,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(20),
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppLocalizations.instance
                                  .text("Enter Your Model Number"),
                              hintStyle: TextStyle(fontSize: 17),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please enter model number';
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
                              .text("Please Select Fuel Type"),
                          onChangedFunction: (String newValue) {
                            noti.setFuelValue(newValue);
                          },
                          selectValue: noti.fuelType,
                          itemsList: fuelType.map<DropdownMenuItem<String>>(
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
                            controller: noti.engineNumber,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(17),
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppLocalizations.instance
                                  .text("Enter Your Engine Number"),
                              hintStyle: TextStyle(fontSize: 17),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please enter engine number';
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
                                  .text("Enter Your Fuel Capacity(gl)"),
                              hintStyle: TextStyle(fontSize: 17),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please enter engine number';
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
                          title: "Enter Number Of Tyres",
                          onChangedFunction: (String newValue) {
                            noti.setTyreValue(newValue);
                          },
                          selectValue: noti.tyre,
                          itemsList:
                              noti.totalTyres.map<DropdownMenuItem<String>>(
                            (value) {
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
                        noti.tyre == "Other"
                            ? Column(
                                children: [
                                  InputTextField(
                                    child: TextFormField(
                                      controller: noti.tyreenter,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      textInputAction: TextInputAction.next,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(4),
                                      ],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter Other Number Of Tyres",
                                        hintStyle: TextStyle(fontSize: 17),
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return 'Please enter other number of tyres';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              )
                            : SizedBox(),
                        InputTextField(
                          child: TextFormField(
                            controller: noti.wheelbase,
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
                                  .text("Enter Your WheelBase"),
                              hintStyle: TextStyle(fontSize: 17),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please enter wheelbase';
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
                            controller: noti.power,
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
                                  .text("Enter Your Power"),
                              hintStyle: TextStyle(fontSize: 17),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please enter power';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CommanButtonWidget(
                          title: AppLocalizations.instance.text("Create"),
                          buttonColor: PrimaryColor,
                          titleColor: APP_BG,
                          onDoneFuction: () {
                            if (_formKey.currentState!.validate()) {
                              if (noti.fuelType == null) {
                                showMessage("Please Enter Fuel Type");
                              } else if (noti.tyre == null) {
                                showMessage("Please Enter Number Of Tyres");
                              } else
                                noti.hitAddFleetManager("truck");
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
