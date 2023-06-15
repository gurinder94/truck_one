import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/Compoment/dropexperience.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/Compoment/maritalStatus.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/Compoment/monthExperience.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/Compoment/phoneFormat.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/Provider/UserProfileProvider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:provider/provider.dart';

import '../../../commanWidget/comman_button_widget.dart';
import 'MutipleLanguages.dart';
import 'dropgender.dart';
import 'educationalQualification.dart';
import 'mutipleKeySkills.dart';

class UserForm extends StatefulWidget {
  UserForm(this.roleName, {Key? key}) : super(key: key);
  String roleName;

  @override
  _UserFormState createState() => _UserFormState();
}

// add marital status and  qualification
class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();

  late UserProfileProvider _userProfileProvider;
  var percent = 0;

  @override
  Widget build(BuildContext context) {
    _userProfileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.only(top: 260),
      padding: EdgeInsets.only(left: 15, top: 10, right: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            InputTextField(
              child: TextFormField(
                  controller: _userProfileProvider.firstName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(20),
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Your First Name *',
                    hintStyle: TextStyle(fontSize: 17),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Your First Name';
                    } else {
                      return null;
                    }
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            InputTextField(
              child: TextFormField(
                  controller: _userProfileProvider.lastName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(20),
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Your Last Name *',
                    hintStyle: TextStyle(fontSize: 17),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Your Last Name';
                    } else {
                      return null;
                    }
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            InputTextField(
              child: TextFormField(
                readOnly: true,
                controller: _userProfileProvider.email,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Your Email',
                    hintStyle: TextStyle(fontSize: 17),
                    contentPadding: EdgeInsets.all(10),
                    prefixIcon: Icon(Icons.email)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Your Email';
                  }
                  return null;
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
                    controller: _userProfileProvider.mobile,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.deny(' '),
                      PhoneInputFormatter()
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Your Phone Number *',
                      hintStyle: TextStyle(fontSize: 17),
                      contentPadding: EdgeInsets.all(10),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your  phone number';
                      }
                      return null;
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
                controller: _userProfileProvider.dateofbirth,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                readOnly: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Your Date of Birth *',
                    hintStyle: TextStyle(fontSize: 17),
                    contentPadding: EdgeInsets.all(10),
                    prefixIcon: Icon(Icons.calendar_today)),
                onTap: () {
                  _userProfileProvider.setStartDate(context);
                },

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Your Date of Birth';
                  } else {
                    print("error");
                  }
                  return null;
                }, // validator: (value) => companyNameValidation(value),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InputTextField(
                child: TextFormField(
              controller: _userProfileProvider.permanentsaddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              maxLines: 10,
              minLines: 1,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(75),
                FilteringTextInputFormatter.allow(
                    RegExp('[a-z A-Z á-ú Á-Ú 0-9 ]')),
                FilteringTextInputFormatter.deny('  ')
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Your Permanent Address',
                hintStyle: TextStyle(fontSize: 17),
                contentPadding: EdgeInsets.all(10),
              ),
            )),
            SizedBox(
              height: 20,
            ),
            _userProfileProvider.roleName == "SALESPERSON"
                ? InputTextField(
                    child: TextFormField(
                      controller: _userProfileProvider.crosssaddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(75),
                        FilteringTextInputFormatter.allow(
                            RegExp('[a-z A-Z á-ú Á-Ú 0-9 ]')),
                        FilteringTextInputFormatter.deny('  ')
                      ],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Your Mailing Address',
                        hintStyle: TextStyle(fontSize: 17),
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  )
                : InputTextField(
                    child: TextFormField(
                      controller: _userProfileProvider.crosssaddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(75),
                        FilteringTextInputFormatter.allow(
                            RegExp('[a-z A-Z á-ú Á-Ú 0-9 ]')),
                        FilteringTextInputFormatter.deny('  ')
                      ],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Your Corresponding Address',
                        hintStyle: TextStyle(fontSize: 17),
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            InputTextField(
              child: TextFormField(
                controller: _userProfileProvider.workplace,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(20),
                  FilteringTextInputFormatter.allow(
                      RegExp('[a-z A-Z á-ú Á-Ú 0-9 ]')),
                  FilteringTextInputFormatter.deny('  ')
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Your Workplace *',
                  hintStyle: TextStyle(fontSize: 17),
                  contentPadding: EdgeInsets.all(10),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Your Workplace';
                  }
                  return null;
                },
              ),

              // validator: (value) => companyNameValidation(value),
            ),
            SizedBox(
              height: 20,
            ),
            InputTextField(
              child: TextFormField(
                controller: _userProfileProvider.designation,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(20),
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Your Final Designation *',
                  hintStyle: TextStyle(fontSize: 17),
                  contentPadding: EdgeInsets.all(10),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Your Final Designation';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InputTextField(
              child: GenderDrop(),
            ),
            SizedBox(
              height: 20,
            ),
            InputTextField(
              child: ExperienceDrop(),
            ),
            SizedBox(
              height: 20,
            ),
            InputTextField(
              child: MonthExperience(),
            ),
            SizedBox(
              height: 20,
            ),
            widget.roleName.toUpperCase() == "SALEPERSON"
                ? SizedBox()
                : Column(
                    children: [
                      InputTextField(
                        child: MaritaleDrop(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
            InputTextField(
              child: TextFormField(
                readOnly: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _userProfileProvider.skillText,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Your Keys Skill',
                  hintStyle: TextStyle(fontSize: 17),
                  contentPadding: EdgeInsets.all(10),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          MutipleKeySkill(_userProfileProvider)).then((value) {
                    _userProfileProvider.skill = value;
                    print(_userProfileProvider.skill);
                    _userProfileProvider.notifyListeners();
                  });
                },
              ),
            ),
            if (_userProfileProvider.userModel != null)
              if (_userProfileProvider.userModel!.data!.otherSkill != "")
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    InputTextField(
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _userProfileProvider.marriedStatus,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Your Other Skill',
                          hintStyle: TextStyle(fontSize: 17),
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ],
                )
              else
                for (int i = 0; i < _userProfileProvider.skillarray.length; i++)
                  if (_userProfileProvider.skillarray[i] == "Others")
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        InputTextField(
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: _userProfileProvider.marriedStatus,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter Your Other Skill',
                              hintStyle: TextStyle(fontSize: 17),
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                      ],
                    ),
            SizedBox(
              height: 20,
            ),
            InputTextField(
              child: TextFormField(
                readOnly: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _userProfileProvider.languages,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Your Language Known',
                  hintStyle: TextStyle(fontSize: 17),
                  contentPadding: EdgeInsets.all(10),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          MutipleLanguage(_userProfileProvider));
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            widget.roleName.toUpperCase() == "SALEPERSON"
                ? InputTextField(
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _userProfileProvider.qualificationEditText,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Your Educational Qualification',
                        hintStyle: TextStyle(fontSize: 17),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => EducationalQualification(
                                _userProfileProvider)).then((value) {
                          _userProfileProvider.data = value;
                          _userProfileProvider.notifyListeners();
                        });
                      },
                    ),
                  )
                : InputTextField(
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _userProfileProvider.qualificationEditText,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Your Educational Qualification',
                        hintStyle: TextStyle(fontSize: 17),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => EducationalQualification(
                                _userProfileProvider)).then((value) {
                          _userProfileProvider.data = value;
                          _userProfileProvider.notifyListeners();
                        });
                      },
                    ),
                  ),
            if (_userProfileProvider.userModel!.data!.otherQualification != "")
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  InputTextField(
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _userProfileProvider.educationQualification,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Your Other Qualification',
                        hintStyle: TextStyle(fontSize: 17),
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ],
              )
            else
              for (int i = 0;
                  i < _userProfileProvider.qualificationarray.length;
                  i++)
                if (_userProfileProvider.qualificationarray[i] == "Others")
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      InputTextField(
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller:
                              _userProfileProvider.educationQualification,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Your Other Qualification',
                            hintStyle: TextStyle(fontSize: 17),
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                    ],
                  ),
            SizedBox(
              height: 20,
            ),
            _userProfileProvider.roleName == "DRIVER"
                ? Column(
                    children: [
                      Selector<UserProfileProvider, bool>(
                          selector: (_, provider) =>
                              provider.loaderDriverlicense,
                          builder: (context, loder, child) {
                            return InputTextField(
                              child: TextFormField(
                                readOnly: true,
                                controller:
                                    _userProfileProvider.drivingDocument,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(20),
                                ],
                                decoration: InputDecoration(
                                  suffixIcon: loder == true
                                      ? CircularProgressIndicator()
                                      : GestureDetector(
                                          child: Icon(
                                              // Based on passwordVisible state choose the icon
                                              Icons.upload_file),
                                          onTap: () {
                                            _userProfileProvider
                                                .getFile("Driving License");
                                          }),
                                  border: InputBorder.none,
                                  hintText: 'Upload Driving License ',
                                  hintStyle: TextStyle(fontSize: 17),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Selector<UserProfileProvider, bool>(
                          selector: (_, provider) => provider.LoderResume,
                          builder: (context, loder, child) {
                            return InputTextField(
                              child: TextFormField(
                                readOnly: true,
                                controller: _userProfileProvider.resumeDocument,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(20),
                                ],
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                      child: loder == true
                                          ? CircularProgressIndicator()
                                          : Icon(
                                              // Based on passwordVisible state choose the icon
                                              Icons.upload_file),
                                      onTap: () {
                                        _userProfileProvider.getFile("Resume");
                                      }),
                                  border: InputBorder.none,
                                  hintText: 'Upload Resume',
                                  hintStyle: TextStyle(fontSize: 17),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                                onTap: () {},
                              ),
                            );
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Selector<UserProfileProvider, bool>(
                          selector: (_, provider) =>
                              provider.loderAdditonalDocument,
                          builder: (context, loder, child) {
                            return InputTextField(
                              child: TextFormField(
                                readOnly: true,
                                controller:
                                    _userProfileProvider.additionalEditText,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(20),
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: loder == true
                                      ? CircularProgressIndicator()
                                      : GestureDetector(
                                          child: Icon(
                                              // Based on passwordVisible state choose the icon
                                              Icons.upload_file),
                                          onTap: () {
                                            _userProfileProvider
                                                .getFile("Additional document");
                                          }),
                                  hintText: 'Upload Additional Document',
                                  hintStyle: TextStyle(fontSize: 17),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Selector<UserProfileProvider, bool>(
                          selector: (_, provider) => provider.LoderMedical,
                          builder: (context, loder, child) {
                            return InputTextField(
                              child: TextFormField(
                                readOnly: true,
                                controller: _userProfileProvider.medical,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(20),
                                ],
                                decoration: InputDecoration(
                                  suffixIcon: loder == true
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : GestureDetector(
                                          child: Icon(
                                              // Based on passwordVisible state choose the icon
                                              Icons.upload_file),
                                          onTap: () {
                                            _userProfileProvider.getFile(
                                                "DMV Medical Certificate");
                                          }),
                                  border: InputBorder.none,
                                  hintText: 'Upload DMV Medical Certificate',
                                  hintStyle: TextStyle(fontSize: 17),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  )
                : SizedBox(),
            InputTextField(
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                //Normal textInputField will be displayed
                maxLines: 10,
                controller: _userProfileProvider.aboutUs,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(250),
                ],
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: ' About *',
                  hintStyle: TextStyle(fontSize: 17),
                  contentPadding: EdgeInsets.all(10),
                ),
                validator: (value) {
                  if (value!.trim().length == 0) {
                    return 'Please enter brief about your ';
                  } else if (value.length < 10) {
                    return 'Please enter minimum 10 characters';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Selector<UserProfileProvider, bool>(
                selector: (_, provider) => provider.updateloder,
                builder: (context, loder, child) {
                  return CommanButtonWidget(
                    title: "Update",
                    buttonColor: PrimaryColor,
                    titleColor: APP_BG,
                    onDoneFuction: () {
                      if (_formKey.currentState!.validate()) {
                        if (_userProfileProvider.valueExperience == null)
                          showMessage("Please select experience *");
                        else
                          _userProfileProvider.hitUserProfileUpdate(context);
                      }
                    },
                    loder: loder,
                  );
                }),
            SizedBox(
              height: 20,
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
