import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/ForgetPasswordScreen/Provider/ForgetPasswordProvider.dart';
import 'package:provider/provider.dart';

import 'Forget_Change_Password_form.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({Key? key}) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  late ForgetPasswordProvider _forgetPasswordProvider;
  Timer? timer;
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  bool resend = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    seconds = 0;
    startTimer();
  }
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (seconds > 0) {
        if (mounted) {
          setState(() {
            seconds--;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            seconds = 0;
            resend = false;
          });
        }
      }
    });
  }

  Widget build(BuildContext context) {
    _forgetPasswordProvider =
        Provider.of<ForgetPasswordProvider>(context, listen: false);
    var loader = Provider.of<ForgetPasswordProvider>(context);

    return Padding(
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

                ChangePasswordScreen(_forgetPasswordProvider),

            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Row(
                  children: [
                    RichText(
                        text: TextSpan(text: '', children: [
                      TextSpan(
                          text: ' << Back ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      TextSpan(
                          text: 'Login Page',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A62A9),
                              fontSize: 16))
                    ])),
                    SizedBox(
                      width: 100,
                    ),
                    resend == true
                        ? Text("0" + "" + "0" + ":" + seconds.toString())
                        : GestureDetector(
                            child: Text("Resend OTP"),
                            onTap: () {
                              loader==false?_forgetPasswordProvider.hitResetOtp(context):SizedBox();

                              setState(() {
                                resend = true;
                                seconds = 30;
                              });
                            },
                          ),
                  ],
                ),
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
    );
  }
}

// class OTPDigitTextFieldBox extends StatelessWidget {
//   final bool? first;
//   final bool? last;
//   TextEditingController? controller1;
//   Function code;
//
//   OTPDigitTextFieldBox(
//       {@required this.first,
//       @required this.last,
//       @required controller1,
//       required this.code});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       child: AspectRatio(
//         aspectRatio: 1.2,
//         child: InputTextField(
//           child: TextFormField(
//             textInputAction: TextInputAction.done,
//             controller: controller1,
//
//             inputFormatters: <TextInputFormatter>[
//               FilteringTextInputFormatter.digitsOnly,
//               LengthLimitingTextInputFormatter(1),
//               FilteringTextInputFormatter.deny(' ')
//             ],
//             textAlign: TextAlign.center,
//             keyboardType: TextInputType.number,
//             // controller: this.code,
//             onChanged: (value) {
//               if (value.length == 1 && last == false) {
//                 code(value);
//                 FocusScope.of(context).nextFocus();
//               } else if (value.length == 0 && first == false) {
//                 FocusScope.of(context).previousFocus();
//               } else if (value.length == 1 && last == true) {
//                 code(value);
//               }
//             },
//             decoration: InputDecoration(
//                 hintText: "*",
//                 counterText: '',
//                 border: InputBorder.none,
//                 hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// validateStructure(String value) {
//   String pattern =
//       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
//   RegExp regExp = new RegExp(pattern);
//   return regExp.hasMatch(value);
// }
