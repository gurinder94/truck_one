import 'package:flutter/material.dart';

import 'Forget_change_Password_OTP.dart';

class ForgetPasswordOtp extends StatelessWidget {
  const ForgetPasswordOtp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                  image: DecorationImage(fit:BoxFit.cover,image: NetworkImage('https://drivetrucks.com/wp-content/uploads/2017/12/truck-driving-in-winter.jpg'),)
              ),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Color(0x32EEEEEE),
                          Color(0x40EEEEEE),
                          Color(0x4BEEEEEE),
                          Color(0xFFEEEEEE),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter
                    )
                ),
              ),
            ),
            SizedBox(height: 10,),
            OtpForm()


          ],
        ),
      ),
    );
  }
}
