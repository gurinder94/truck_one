import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/PrivacyPolicyScreen/privacy_policy_page.dart';
import 'package:my_truck_dot_one/Screens/PrivacyPolicyScreen/privacy_policy_provider.dart';
import 'package:my_truck_dot_one/Screens/SignUpScreen/Provider/SignUpUserProvider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customLoder.dart';
import 'package:provider/provider.dart';
import '../../../AppUtils/comman_validation.dart';
import '../../LoginScreen/LoginScreen.dart';
import '../../commanWidget/comman_button_widget.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool checkbox = false;
  late UserProvider _UserProvider;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _UserProvider = Provider.of<UserProvider>(context, listen: false);
    _UserProvider.Resetmodel();
  }

  @override
  Widget build(BuildContext context) {
    var loader = Provider.of<UserProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                InputTextField(
                    child: TextFormField(
                  controller: _UserProvider.firstName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(20),
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'First Name * ',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) => firstNameValidation(value!),
                )),
                SizedBox(
                  height: 20,
                ),
                InputTextField(
                    child: TextFormField(
                  controller: _UserProvider.lastName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(20),
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Last Name * ',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) => lastNameValidation(value!),
                )),
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
                      controller: _UserProvider.mobilenumber,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
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
                  controller: _UserProvider.email,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(' ')
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email * ',
                  ),
                  validator: (value) => emailValidation(value!),
                )),
                SizedBox(
                  height: 20,
                ),
                InputTextField(
                    child: TextFormField(
                  controller: _UserProvider.password,
                  obscureText: !loader.obscureText,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      // // showMessage(message, context);

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
                  controller: _UserProvider.confirmpassword,
                  textInputAction: TextInputAction.done,
                  obscureText: !loader.obscure,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(' ')
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Confirm password * ',
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
                      print(_UserProvider.password.text == value);
                      return 'Please enter confirm password';
                    } else if (_UserProvider.password.text != value) {
                      return 'Password not match';
                    }

                    return null;
                  },
                )),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  child: Row(
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
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: PrimaryColor),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider(
                                      create: (_) => PrivacyPolicyProvider(),
                                      child: PrivacyPolicyPage(
                                        type: "TERMSCONDITION",
                                      ))));
                        },
                      ),
                    ],
                  ),
                ),
                CommanButtonWidget(
                  title: "Sign Up",
                  buttonColor: APP_BG,
                  titleColor: PrimaryColor,
                  onDoneFuction: () {
                    if (_formKey.currentState!.validate()) {
                      if (checkbox == true) {
                        loader.loading == true
                            ? Center(child: CustomLoder())
                            : _UserProvider.hitUser(context);
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
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 10, left: 5),
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

  validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  void showMessage(String msg, context) {
    final snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
