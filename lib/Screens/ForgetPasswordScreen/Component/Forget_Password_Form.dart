import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_truck_dot_one/Screens/ForgetPasswordScreen/Provider/ForgetPasswordProvider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:provider/provider.dart';

import '../../../AppUtils/constants.dart';
import '../../LoginScreen/LoginScreen.dart';
import '../../commanWidget/comman_button_widget.dart';

class ForgetPassword extends StatefulWidget {
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late ForgetPasswordProvider _forgetPasswordProvider;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _forgetPasswordProvider =
        Provider.of<ForgetPasswordProvider>(context, listen: false);
    _forgetPasswordProvider.resetData();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14),
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Forgot Password',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Enter your email address associated with your account',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InputTextField(
                  child: TextFormField(
                controller: _forgetPasswordProvider.email,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value!.trim().length == 0) {
                    return 'Please enter email';
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return 'Please enter  a valid email Address';
                  } else {
                    return null;
                  }
                },
              )),
              SizedBox(
                height: 20,
              ),
              Selector<ForgetPasswordProvider, bool>(
                  selector: (_, provider) => provider.loading,
                  builder: (context, loder, child) {
                    return CommanButtonWidget(
                      title: "Continue",
                      buttonColor: APP_BG,
                      titleColor: PrimaryColor,
                      onDoneFuction: () {
                        if (_formKey.currentState!.validate()) {
                          _forgetPasswordProvider.hitResetPassword(context);
                        }
                      },
                      loder: loder,
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: RichText(
                      text: TextSpan(text: '', children: [
                    TextSpan(
                        text: ' << Back to Home  ',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.black)),
                    TextSpan(
                        text: 'Login Page',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A62A9),
                            fontSize: 16))
                  ])),
                ),
              )
            ]),
          ),
          decoration: BoxDecoration(color: Color(0xFFEEEEEE), boxShadow: [
            BoxShadow(
              color: Color(0xFFD9D8D8),
              offset: Offset(5.0, 5.0),
              blurRadius: 7,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(.4),
              offset: Offset(-5.0, -5.0),
              blurRadius: 10,
            ),
          ]),
        ),
      ),
    );
  }
}
