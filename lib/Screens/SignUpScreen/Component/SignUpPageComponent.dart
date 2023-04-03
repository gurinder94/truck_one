import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/Sign_up_provider.dart';
import 'Sign_Up_Company_from.dart';
import 'Sign_Up_User.dart';
import '../SignUp_Taber/Sign_Up_taber.dart';

class SignUpPageComponent extends StatelessWidget {

int pos=0;
  @override

  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(


        decoration: BoxDecoration(       color: Color(0xFFEEEEEE), boxShadow: [
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 15,bottom: 10),
              child: Text(
                'SignUp',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            SizedBox(height: 10,),
             SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: Container(
                 child: Row(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SignUpTaber(0, 'User',),

                    // SignUpTaber(1, 'Company',),

                  ],
            ),
               ),
             ),


               Container(

                child: menuWidget(context),

            ),

          ],
        ),
      ),
    );
  }

  menuWidget(BuildContext context ) {

    var sign= context.watch<SignUpProvider>();

    switch (sign.signUp) {
      case 0:
         return SignUpForm();
      // case 1:
      //   return CompanyForm();
    }
  }

}
