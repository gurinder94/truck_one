import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_image_screen_component.dart';
import 'Component/LoginComponent.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        
        child: SingleChildScrollView(
          child: Column(
            children: [
              CommanImageComponent(),
                SizedBox(height: 10,),
              LoginComponent(),
            ],
          ),
        ),


      ),


    );
  }
}
