import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_truck_dot_one/Screens/LoginScreen/LoginScreen.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:provider/provider.dart';

import '../../../AppUtils/constants.dart';
import '../../commanWidget/comman_button_widget.dart';
import '../Provider/otp_provider.dart';

class SignUpOtpForm extends StatefulWidget {
  String resetkey;
  SignUpOtpForm(this.resetkey);

  @override
  _SignUpOtpFormState createState() => _SignUpOtpFormState(resetkey);
}

class _SignUpOtpFormState extends State<SignUpOtpForm> {
  late OtpProvider _UserProvider;


  TextEditingController code1 = TextEditingController();
  TextEditingController code2 = TextEditingController();
  TextEditingController code3 = TextEditingController();
  TextEditingController code4 = TextEditingController();
  TextEditingController code5 = TextEditingController();
  late bool first;
  late bool last;
  final _formKey = GlobalKey<FormState>();
  String resetkey;
  _SignUpOtpFormState(this.resetkey);

  Widget build(BuildContext context) {
    _UserProvider = Provider.of<OtpProvider>(context, listen: false);
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
                'Verify Email',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Please enter OTP sent on your email',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OTPDigitTextFieldBox(
                    first: true,
                    last: false,
                    controller1: code1,
                    code: (value) {
                      code1.text = value;

                      print(code1.text);
                    },
                  ),
                  OTPDigitTextFieldBox(
                    first: false,
                    last: false,
                    controller1: code2,
                    code: (value) {
                      code2.text = value;
                    },
                  ),
                  OTPDigitTextFieldBox(
                    first: false,
                    last: false,
                    controller1: code3,
                    code: (value) {
                      code3.text = value;
                    },
                  ),
                  OTPDigitTextFieldBox(
                      first: false,
                      last: false,
                      controller1: code4,
                      code: (value) {
                        code4.text = value;
                      }),
                  OTPDigitTextFieldBox(
                      first: false,
                      last: true,
                      controller1: code5,
                      code: (value) {
                        code5.text = value;
                      }),
                ],
              ),
              SizedBox(
                height: 10,
              ),
                  Selector<OtpProvider, bool>(
                      selector: (_, provider) => provider.loading,
                      builder: (context, loder, child) {
                        return CommanButtonWidget(
                          title: "Submit",
                          buttonColor:APP_BG ,
                          titleColor:PrimaryColor,
                          onDoneFuction: () {
                            if (_formKey.currentState!.validate()) {
                              _UserProvider.hitAccountVerifyyOtp(
                                context, code1, code2, code3, code4, code5,resetkey);
                            }
                          },
                          loder: loder,
                        );
                      }),

              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen())),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: RichText(
                      text: TextSpan(text: '', children: [
                    TextSpan(
                        text: ' << Back ',
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
              ),
              SizedBox(
                height: 20,
              ),
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

class OTPDigitTextFieldBox extends StatelessWidget {
  final bool? first;
  final bool? last;
  Function code;
  TextEditingController? controller1;

  OTPDigitTextFieldBox(
      {@required this.first,
      @required this.last,
      @required controller1,
      required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: AspectRatio(
        aspectRatio: 1.2,
        child: InputTextField(
          child: TextFormField(
            textInputAction: TextInputAction.done,
            controller: controller1,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.deny(' ')
            ],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            // controller: this.code,
            onChanged: (value) {
              if (value.length == 1 && last == false) {
                code(value);
                FocusScope.of(context).nextFocus();
              } else if (value.length == 0 && first == false) {
                FocusScope.of(context).previousFocus();
              } else if (value.length == 1 && last == true) {
                code(value);
              }
            },
            decoration: InputDecoration(
                hintText: "*",
                counterText: '',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
          ),
        ),
      ),
    );
  }
}

validateStructure(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
