import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/provider/ProfileProvider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:provider/provider.dart';
import '../../../commanWidget/comman_button_widget.dart';
import 'company_state_dropdown.dart';

class CompanyForm extends StatefulWidget {
  @override
  _CompanyFormState createState() => _CompanyFormState();
}

class _CompanyFormState extends State<CompanyForm> {
  final _formKey = GlobalKey<FormState>();
  late ProfileProvider _profileProvider;

  @override
  Widget build(BuildContext context) {
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.only(top: 260),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            InputTextField(
              child: TextFormField(
                controller: _profileProvider.companyName,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(30),
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Your Company Name',
                  hintStyle: TextStyle(fontSize: 17),
                  contentPadding: EdgeInsets.all(10),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Please enter company name';
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
                controller: _profileProvider.firstName,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(20),
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Your First name',
                  hintStyle: TextStyle(fontSize: 17),
                  contentPadding: EdgeInsets.all(10),
                ),
                validator: (value) {
                  if (value!.trim().length == 0) {
                    return 'Please enter first name';
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
                controller: _profileProvider.lastName,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(20),
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Your Last Name',
                  hintStyle: TextStyle(fontSize: 17),
                  contentPadding: EdgeInsets.all(10),
                ),
                validator: (value) {
                  if (value!.trim().length == 0) {
                    return 'Please enter last name';
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
                controller: _profileProvider.directorName,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(30),
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Your Director Name',
                  hintStyle: TextStyle(fontSize: 17),
                  contentPadding: EdgeInsets.all(10),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Please enter director name';
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
                textInputAction: TextInputAction.next,
                controller: _profileProvider.email,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(70),
                  FilteringTextInputFormatter.deny(' ')
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Your email',
                  hintStyle: TextStyle(fontSize: 17),
                  contentPadding: EdgeInsets.all(10),
                ),
                validator: (value) {
                  if (value!.trim().length == 0) {
                    return 'Please enter email';
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return 'Please enter a valid email Address';
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
              child: GestureDetector(
                child: TextFormField(
                  controller: _profileProvider.incorprationDate,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  enabled: false,

                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppLocalizations.instance.text('Enter Your Incorporation Date'),
                      hintStyle: TextStyle(fontSize: 17),
                      contentPadding: EdgeInsets.all(10),
                      prefixIcon: Icon(Icons.calendar_today)),
                  // validator: (value) {
                  //   if (value == '' || value!.isEmpty) {
                  //     return 'Please enter incorporation date';
                  //   } else {
                  //     return null;
                  //   }
                  //
                  // },
                ),
                onTap: () {
                  _profileProvider.setStartDate(context);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InputTextField(
                child: Row(
              children: [
                SizedBox(width: 10),
                Text(
                  "+1",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    controller: _profileProvider.mobile,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.deny(' ')
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppLocalizations.instance.text('Enter Your Phone Number'),
                      hintStyle: TextStyle(fontSize: 17),
                      contentPadding: EdgeInsets.all(10),
                    ),
                    validator: (value) {
                      if (value!.trim().length == 0) {
                        return 'Please enter phone number';
                      } else {
                        return null;
                      }
                    },
                  ),
                )
              ],
            )),

            SizedBox(
              height: 20,
            ),
            InputTextField(
              child: TextFormField(
                controller: _profileProvider.addresss,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp('[a-z A-Z á-ú Á-Ú 0-9 ]')),
                  FilteringTextInputFormatter.deny('  '),
                  LengthLimitingTextInputFormatter(75),
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText:AppLocalizations.instance.text('Enter Your Address'),
                  hintStyle: TextStyle(fontSize: 17),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CompanyStateDrop(),
            SizedBox(
              height: 20,
            ),
            InputTextField(
                child: TextFormField(
              textInputAction: TextInputAction.next,
              controller: _profileProvider.postcode,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(6),
                FilteringTextInputFormatter.deny(' ')
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText:AppLocalizations.instance.text('Enter Your Postal Code'),
                hintStyle: TextStyle(fontSize: 17),
                contentPadding: EdgeInsets.all(10),
              ),
              validator: (value) {
                if (value!.trim().length == 0) {
                  return 'Please enter Postal code';
                } else if (_profileProvider.checkPostalCode == false) {
                  return 'Postal code is invalid ';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                Future.delayed(Duration(milliseconds: 100), () {
                  _profileProvider.hitPostelCode(value);
                });
              },
            )
                // validator: (value) => companyNameValidation(value),
                ),
            SizedBox(
              height: 20,
            ),

            InputTextField(
              child: TextFormField(
                controller: _profileProvider.city,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(50),
                  FilteringTextInputFormatter.deny(' ')
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: AppLocalizations.instance.text('Enter Your city'),
                  hintStyle: TextStyle(fontSize: 17),
                  contentPadding: EdgeInsets.all(10),
                ),
                validator: (value) {
                  if (value!.trim().length == 0) {
                    return 'Please enter city ';
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
                keyboardType: TextInputType.multiline,
                minLines: 1,
                //Normal textInputField will be displayed
                maxLines: 10,
                controller: _profileProvider.aboutcompany,
                textInputAction: TextInputAction.done,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(2000),
                ],

                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: AppLocalizations.instance.text('Enter Your About Company'),
                  hintStyle: TextStyle(fontSize: 17),
                  contentPadding: EdgeInsets.all(10),
                ),
                validator: (value) {
                  if (value!.trim().length == 0) {
                    return 'Please brief about your company';
                  } else if (value.length < 10) {
                    return 'Please enter minimum 10 characters';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // InputTextField(
            //   child: TextFormField(
            //     controller: _profileProvider!.serviceName,
            //     decoration: InputDecoration(
            //       border: InputBorder.none,
            //       hintText: 'Enter Your Service',
            //       hintStyle: TextStyle(fontSize: 17),
            //       contentPadding: EdgeInsets.all(10),
            //     ),
            //     onTap: () {
            //       showDialog(
            //           context: context,
            //           builder: (context) => MultiServicesDialog(
            //               _profileProvider!.serviceModel,
            //               _profileProvider));
            //     },
            //     validator: (value) {
            //       if (value!.trim().length == 0) {
            //         return 'Please enter Service';
            //       } else {
            //         return null;
            //       }
            //     }, // validator: (value) => companyNameValidation(value),
            //   ),
            // ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 5,
            ),
            Selector<ProfileProvider, bool>(
                selector: (_, provider) => provider.updateloder,
                builder: (context, loder, child) {
                  return CommanButtonWidget(
                    title: "Update",
                    buttonColor: PrimaryColor,
                    titleColor: APP_BG,
                    onDoneFuction: () {
                      if (_profileProvider.incorprationDate.text=='')
                        showMessage('Please enter incorporation date');
                      if (_formKey.currentState!.validate()) {
                        if (_profileProvider.countryId == null)
                          showMessage('Please select country');

                        else
                          _profileProvider.hitUpdateCompanyDetail(
                            context,
                          );
                      }
                    },
                    loder: loder,
                  );
                }),

            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: APP_BG,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      ),
    );
  }
}
