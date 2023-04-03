import 'package:flutter/material.dart';

class ShareEvent extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
        child:Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: 100,
              height: 4,
              color: Color(0xFF1A62A9),
            ),
            Padding(
                padding:
                const EdgeInsets.only(left: 25, right: 10, bottom: 20, top: 30),
                child: Row(
                  children: [
                    Text(
                      "Share this event",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 20),
                    )
                  ],
                )),

            Container(
              width: double.infinity,
              height: 1,
              color: Colors.black26,
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(10.0),

                child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 10, right: 25),
                        child: Image.asset(
                          "icons/share.jpg",
                          scale: 1.5),

                        ),
                    Text("Share in a Message")
                  ],
                ),

              ),
              onTap: ()
              {



              },
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.black26,
            ),
            SizedBox(height: 30,),
          ],
        )
    );
  }
}
