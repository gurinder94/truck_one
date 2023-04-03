import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';

class DisplayWeatherColor extends StatefulWidget {
  const DisplayWeatherColor({Key? key}) : super(key: key);

  @override
  _DisplayWeatherColorState createState() => _DisplayWeatherColorState();
}

class _DisplayWeatherColorState extends State<DisplayWeatherColor> {
  var _width = 0.0;
  bool check = true;
  List name=['Slight Snow','Moderate Snow','Hight Snow','Thunderstorm','Freezing Rain','Temperature',
    'Precipitation'];
  List Color=['#00c5f1','#008a00','#ff0000','#1c4fad','#ffcd42','#ff6f00','#a200ff'];
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 15,
      height: 15,
          child: GestureDetector(
            child: Icon(
              Icons.menu,
              size: 19,
            ),
            onTap: () {
              setState(() {
                if (check == true) {
                  check = false;
                  _width = 300.0;
                } else {
                  check = true;
                  _width = 0.0;
                }
              });
            },
          ),
        ),
        AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: _width == 300.0 ? Curves.bounceOut : Curves.ease,
          padding: EdgeInsets.all(5),
          height: _width,
          child: check == true
              ? Container():Container(
            width: 200,
            color: Colors.white.withOpacity(0.7),
            height:300,
            child: ListView.builder(
                itemCount: name.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(

                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color:  hexToColor(Color[index]).withOpacity(0.5),
                            shape: BoxShape.rectangle,
                            border: Border.all(),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Text(name[index])
                      ],
                    ),
                  );
                }),
          ),
        ),
      ],
    );


  }

}
