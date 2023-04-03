import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/PrivacyPolicyScreen/privacy_policy_page.dart';
import 'package:my_truck_dot_one/Screens/PrivacyPolicyScreen/privacy_policy_provider.dart';

import 'package:my_truck_dot_one/Screens/SignUpScreen/Provider/SignUpCompanyProvider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customLoder.dart';
import 'package:provider/provider.dart';

import '../../../AppUtils/comman_validation.dart';
import '../../LoginScreen/LoginScreen.dart';
import '../../commanWidget/comman_button_widget.dart';

class CompanyForm extends StatefulWidget {
  @override
  _CompanyFormState createState() => _CompanyFormState();
}

class _CompanyFormState extends State<CompanyForm> {
  bool checkbox = false;
  late CompanyProvider _CompanyProvider;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _CompanyProvider = Provider.of<CompanyProvider>(context, listen: false);
    _CompanyProvider.Resetmodel();
  }

  @override
  Widget build(BuildContext context) {
    var loader = Provider.of<CompanyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                InputTextField(
                    child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(30),
                  ],
                  controller: _CompanyProvider.companyName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Company Name *',
                    prefixIcon: Icon(Icons.business),
                  ),
                  validator: (value) => companyNameValidation(value!),
                )),
                SizedBox(
                  height: 20,
                ),
                InputTextField(
                  child: TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                    ],
                    controller: _CompanyProvider.firstname,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'First Name *',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) => firstNameValidation(value!),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InputTextField(
                  child: TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                    ],
                    controller: _CompanyProvider.lastName,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Last  Name *',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) => lastNameValidation(value!),
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
                      controller: _CompanyProvider.mobilenumber,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.deny(' ')
                      ],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: ' Phone Number *',
                      ),
                      validator: (value) => mobileValidation(value!),
                    ))
                  ],
                )),
                SizedBox(
                  height: 20,
                ),
                InputTextField(
                    child: TextFormField(
                  controller: _CompanyProvider.email,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(' ')
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email *',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) => emailValidation(value!),
                )),
                SizedBox(
                  height: 20,
                ),
                InputTextField(
                    child: TextFormField(
                  obscureText: !loader.obscureText,
                  controller: _CompanyProvider.password,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(' ')
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password *',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      child: Icon(
                        // Based on passwordVisible state choose the icon
                        !loader.obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onTap: () => loader.ShowVisiblePassword(),
                    ),
                  ),
                  validator: (value) {
                    if (value!.trim().length == 0) {
                      return 'Please enter password';
                    } else if (validateStructure(value) == false) {
                      var message =
                          "Password should be of 6 letters, Contain at least one \n Capital  letter, Alphanumeric a-z,0-9 One special \n character";
                      return message;
                    } else {
                      return null;
                    }
                  },
                )),
                SizedBox(
                  height: 20,
                ),
                InputTextField(
                    child: TextFormField(
                  obscureText: !loader.obscure,
                  controller: _CompanyProvider.confirmpassword,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(' ')
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Confirm Password *',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      child: Icon(
                        // Based on passwordVisible state choose the icon
                        !loader.obscure
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onTap: () => loader.ShowVisibleConfirmPassword(),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter confirm password';
                    } else if (_CompanyProvider.password.text != value) {
                      return 'Password not match';
                    }

                    return null;
                  },
                )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: Color(0xFF1A62A9),
                      value: checkbox,
                      onChanged: (value) {
                        setState(() {
                          checkbox = value!;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Text(
                        'I accept the terms & conditions',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15,color: PrimaryColor),
                      ),
                      onTap: ()
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChangeNotifierProvider(
                                        create: (_) =>
                                            PrivacyPolicyProvider(),
                                        child: PrivacyPolicyPage(
                                          type: "TERMSCONDITION",
                                        ))));
                      },
                    ),
                  ],
                ),
                CommanButtonWidget(
                  title: "Sign Up",
                  buttonColor: APP_BG,
                  titleColor: PrimaryColor,
                  onDoneFuction: () {
                    if (_formKey.currentState!.validate()) {
                      if (checkbox == true) {
                        loader.loading == true
                            ? CustomLoder()
                            : _CompanyProvider.hitComapny(context);
                      } else {
                        final snackBar = SnackBar(
                            content:
                                Text('Please Accept the Policy and Terms'));

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  loder: loader.loading,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (Route<dynamic> route) => false)
                        .then((_) {
                      // This block runs when you have returned back to the 1st Page from 2nd.
                      setState(() {
                        // Call setState to refresh the page.
                      });
                    }),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: RichText(
                          text: TextSpan(text: '', children: [
                        TextSpan(
                            text: ' Already have an account ? ',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                        TextSpan(
                            text: 'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: PrimaryColor,
                                fontSize: 16))
                      ])),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}

