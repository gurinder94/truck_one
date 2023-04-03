import 'package:flutter/material.dart';

class AttendeeList extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        Text("data");
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(

            child: Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 20),
              child: ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://googleflutter.com/sample_image.jpg'),

                    ),
                  ),
                ),
                title: Text("lakshit"),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text("Ul/Ux Designer at Zimo Infotech"),
                ),

                trailing: Container(
                  width: 80,
                  height: 40,
                  child: Center(child: Text("Host",style: TextStyle(color: Colors.white,fontSize:20 ),)),
                  decoration: BoxDecoration(
                      color: Color(0xFF1A62A9),

                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
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
            ),
              decoration: BoxDecoration(color: Color(0xFFEEEEEE), boxShadow: [
                BoxShadow(
                  color: Color(0xFFD9D8D8),
                  offset: Offset(5.0, 5.0),
                  blurRadius: 7,
                ),
                BoxShadow(
                  color:Colors.white.withOpacity(.5),
                  offset: Offset(-5.0, -5.0),
                  blurRadius:7,
                ),
              ])
          ),
        );
      },
    );
  }
}
