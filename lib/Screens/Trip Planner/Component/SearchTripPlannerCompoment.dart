import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';

class SearchTripPlanner extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/3,

        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                      Text("My Trips"),
              SizedBox(height:10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Enter Origin Location"),
                  Text("Enter Origin Location")

                ],
              ),
              SizedBox(height:10,),
              Row(
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left:0,right: 10),
                      child: InputTextField(
                        child: TextFormField(


                          autovalidateMode: AutovalidateMode.onUserInteraction,

                          decoration: InputDecoration(
                            border: InputBorder.none,

                          ),

                        ),
                      ),
                    ),
                  ),

                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left:10,right: 0),
                      child: InputTextField(
                        child: TextFormField(




                          decoration: InputDecoration(
                            border: InputBorder.none,


                          ),

                        ),
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(height:10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Enter Origin Location"),
                  Text("Enter Origin Location")

                ],
              ),
              SizedBox(height:10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left:0,right: 10),
                      child: InputTextField(
                        child: TextFormField(


                          autovalidateMode: AutovalidateMode.onUserInteraction,

                          decoration: InputDecoration(
                            border: InputBorder.none,

                          ),

                        ),
                      ),
                    ),
                  ),

                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left:10,right: 0),
                      child: InputTextField(
                        child: TextFormField(




                          decoration: InputDecoration(
                            border: InputBorder.none,


                          ),

                        ),
                      ),
                    ),
                  ),

                ],
              )

            ],
          ),
        ),
        decoration: BoxDecoration(color: Color(0xFFEEEEEE),

            borderRadius: BorderRadius.circular(10),boxShadow: [
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
