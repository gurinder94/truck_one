import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_truck_dot_one/Screens/ForgetPasswordScreen/Provider/ForgetPasswordProvider.dart';
import 'package:provider/provider.dart';

import '../../../AppUtils/constants.dart';
import '../../commanWidget/commanField_widget.dart';
import '../../commanWidget/comman_button_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  ForgetPasswordProvider forgetPasswordProvider;
   ChangePasswordScreen(this.forgetPasswordProvider, {Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    var loader = Provider.of<ForgetPasswordProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          'Reset Password',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Please enter OTP sent on your email to reset password',
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
              controller1: widget.forgetPasswordProvider.code1,
              code: (value) {
                widget.forgetPasswordProvider.code1.text = value;
              },
            ),
            OTPDigitTextFieldBox(
              first: false,
              last: false,
              controller1: widget.forgetPasswordProvider.code2,
              code: (value) {
                widget.forgetPasswordProvider.code2.text = value;
              },
            ),
            OTPDigitTextFieldBox(
              first: false,
              last: false,
              controller1: widget.forgetPasswordProvider.code3,
              code: (value) {
                widget.forgetPasswordProvider.code3.text = value;
              },
            ),
            OTPDigitTextFieldBox(
              first: false,
              last: false,
              controller1: widget.forgetPasswordProvider.code4,
              code: (value) {
                widget.forgetPasswordProvider.code4.text = value;
              },
            ),
            OTPDigitTextFieldBox(
              first: false,
              last: true,
              controller1: widget.forgetPasswordProvider.code5,
              code: (value) {
                widget.forgetPasswordProvider.code5.text = value;
              },
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        InputTextField(
          child: TextFormField(
            obscureText: !loader.obscureText,
            controller: widget.forgetPasswordProvider.password,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: [FilteringTextInputFormatter.deny(' ')],
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'New Password',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: GestureDetector(
                  child: Icon(
                    // Based on passwordVisible state choose the icon
                    !loader.obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onTap: () => loader.ShowVisiblePassword(),
                ),
                contentPadding: EdgeInsets.only(top: 15)),
            validator: (value) {
              if (value!.trim().length == 0) {
                return 'Please enter Password';
              } else if (validateStructure(value) == false) {
                var message =
                    "Password should be of 6 lettersContain at least one Capital \n letterAlphanumeric a-z,0-9One special character";
                return message;
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
            obscureText: !loader.obscure,
            controller: widget.forgetPasswordProvider.passwordconfirm,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: [FilteringTextInputFormatter.deny(' ')],
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Confirm Password',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: GestureDetector(
                  child: Icon(
                    // Based on passwordVisible state choose the icon
                    !loader.obscure
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onTap: () => loader.ShowVisibleConfirmPassword(),
                ),
                contentPadding: EdgeInsets.only(top: 15)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Password';
              } else if (widget.forgetPasswordProvider.password.text != value) {
                return 'Password not match';
              } else {
                return null;
              }
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // loader.PasswordLoder==true? Center(child: CustomLoder()):   GestureDetector(
        //       child: Container(
        //         width: double.infinity,
        //         height: 40,
        //         margin:
        //             EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
        //         decoration: BoxDecoration(
        //             color: Color(0xFFEEEEEE),
        //             borderRadius: BorderRadius.all(Radius.circular(20)),
        //             boxShadow: [
        //               BoxShadow(
        //                 color: Color(0xFFD9D8D8),
        //                 offset: Offset(5.0, 5.0),
        //                 blurRadius: 7,
        //               ),
        //               BoxShadow(
        //                 color: Colors.white.withOpacity(.4),
        //                 offset: Offset(-5.0, -5.0),
        //                 blurRadius: 10,
        //               ),
        //             ]),
        //         child: Center(
        //             child: Text(
        //           "Reset Password",
        //           style: TextStyle(
        //             color: Color(0xFF1A62A9),
        //             fontSize: 22,
        //           ),
        //         )),
        //       ),
        //       onTap: () {
        //
        //          _forgetPasswordProvider.hitPassword(context,code1.text,code2.text,code3.text,code4.text,code5.text);
        //
        //       },
        //     ),

        CommanButtonWidget(
          title: "Reset Password",
          buttonColor: APP_BG,
          titleColor: PrimaryColor,
          onDoneFuction: () {
            widget.forgetPasswordProvider.hitPassword(context,widget.forgetPasswordProvider.code1.text,widget.forgetPasswordProvider.code2.text,widget.forgetPasswordProvider.code3.text,widget.forgetPasswordProvider.code4.text,widget.forgetPasswordProvider.code5.text);
          },
          loder: loader.PasswordLoder,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
class OTPDigitTextFieldBox extends StatelessWidget {
  final bool? first;
  final bool? last;
  TextEditingController? controller1;
  Function code;

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
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}