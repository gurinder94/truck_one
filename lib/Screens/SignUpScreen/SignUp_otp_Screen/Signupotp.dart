import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_image_screen_component.dart';

import 'Sign_Up_Otp_Form.dart';

class SignUpOtp extends StatelessWidget {
  String  resetkey;
  SignUpOtp(this.resetkey);

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CommanImageComponent(),
              SignUpOtpForm(resetkey)
            ],
          ),
        ),
      ),
    );
  }
}
