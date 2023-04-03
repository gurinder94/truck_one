import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/ForgetPasswordScreen/ForgetPassword.dart';
import 'package:my_truck_dot_one/Screens/LoginScreen/Provider/LoginPageProvider.dart';
import 'package:my_truck_dot_one/Screens/SignUpScreen/Sign_up_Page.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customLoder.dart';
import 'package:provider/provider.dart';
import '../../../AppUtils/comman_validation.dart';
import '../../commanWidget/comman_button_widget.dart';

class LoginComponent extends StatefulWidget {
  const LoginComponent({Key? key}) : super(key: key);

  @override
  _LoginComponentState createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  late LoginProvider _loginProvider;

  bool per = false;
  final _formKey = GlobalKey<FormState>();
  double? lat, long;
  var _radioSelected;
  String _radioVal = "";
  var items = ["role", "value"];

  @override
  void initState() {
    // TODO: implement initState
    _loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _loginProvider.Reset();}

  @override
  Widget build(BuildContext context) {
    var loader = Provider.of<LoginProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14),
      child: Form(
        key: _formKey,
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
                "Welcome",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Let's get started",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 20,
              ),
              InputTextField(
                  child: TextFormField(
                      controller: _loginProvider.email,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        hintStyle: TextStyle(fontSize: 17),
                        prefixIcon: Icon(
                          Icons.mail,
                        ),
                      ),
                      validator: (value) => emailValidation(value))),
              SizedBox(
                height: 20,
              ),
              InputTextField(
                child: TextFormField(
                  obscureText: !loader.obscureText,
                  controller: _loginProvider.password,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
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
                  validator: (value) => passwordValidation(value),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CommanButtonWidget(
                title: "Login",
                buttonColor: APP_BG,
                titleColor: PrimaryColor,
                onDoneFuction: () {
                  loader.loading == true
                      ? Center(child: CustomLoder())
                      : OpenNextScreen(context);
                },
                loder: loader.loading,
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => openForgotPassword(context),
                child: Row(
                  children: [
                    Text(
                      'Forgot Password',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: PrimaryColor,
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => openSignUpPage(context),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: RichText(
                      text: TextSpan(text: '', children: [
                    TextSpan(
                        text: 'Don\'t have an account ?    ',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.black)),
                    TextSpan(
                        text: 'Sign up here',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A62A9),
                            fontSize: 16))
                  ])),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  OpenNextScreen(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _loginProvider.getNetworkInfo();

      _loginProvider.hitLogin(context, lat, long, _loginProvider);
    }
  }

  openSignUpPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  openForgotPassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPassword()),
    );
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => ForgetPasswordOtp()));
  }
}
