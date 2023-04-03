import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/ViewJob/Provider/JobviewProvider.dart';
import 'package:provider/provider.dart';

class JobTabBar extends StatelessWidget {
  int pos;
  late String title;
  var size;

  JobTabBar({required this.title, required this.pos});


  Widget build(BuildContext context) {
    size = MediaQuery
        .of(context)
        .size;
    // return GestureDetector(
    //     onTap: () => hitButton(pos, context),
    //     child: Provider.of<JobViewProvider>(context, listen: true).signUp ==
    //         pos
    //         ? Container(
    //       height: size.height*(0.05),
    //       width: size.width*(0.40),
    //
    //
    //       padding: EdgeInsets.all(1),
    //       decoration: BoxDecoration(color: Color(0xFFEEEEEE),
    //           borderRadius: BorderRadius.circular(20),
    //           boxShadow: [
    //             BoxShadow(
    //               color: Color(0xFFD9D8D8),
    //               offset: Offset(5.0, 5.0),
    //               blurRadius: 7,
    //             ),
    //             BoxShadow(
    //               color: Colors.white.withOpacity(.4),
    //               offset: Offset(-5.0, -5.0),
    //               blurRadius: 10,
    //             ),
    //           ]),
    //       child: Container(
    //
    //         padding: EdgeInsets.all(1),
    //         decoration: BoxDecoration(color: Color(0xFFEEEEEE),
    //             borderRadius: BorderRadius.circular(20),boxShadow: [
    //               BoxShadow(
    //                 color: Color(0xFFD9D8D8),
    //                 offset: Offset(-5.0, -5.0),
    //                 blurRadius: 2,
    //               ),
    //               BoxShadow(
    //                 color: Colors.white.withOpacity(.4),
    //                 offset: Offset(5.0, 5.0),
    //                 blurRadius: 10,
    //               ),
    //             ]),
    //         child: Center(child: Text(title,style: TextStyle(color:Color(0xFF044a87),fontSize:16),),),
    //       ),
    //     )
    //         : Container(
    //       height: size.height*(0.05),
    //       width: size.width*(0.40),
    //       padding: EdgeInsets.all(10),
    //       decoration: BoxDecoration(
    //           color: Color(0xFFEEEEEE),
    //           shape: BoxShape.rectangle,
    //           borderRadius: BorderRadius.circular(20),
    //           boxShadow: [
    //             BoxShadow(
    //                 color: Color(0xF8C6C4C4),
    //                 offset: Offset(5.0, 5.0),
    //                 blurRadius: 10,
    //                 spreadRadius: -4),
    //             BoxShadow(
    //               color: Colors.white.withOpacity(.5),
    //               offset: Offset(-3.0, -3.0),
    //               blurRadius: 7,
    //             ),
    //           ]),
    //       child: Center(child: Text(title,style: TextStyle(fontSize:16),),),
    //     )
    // );

    return GestureDetector(
      child: Container(
        height: size.height*(0.05),
           width: size.width*(0.40),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow:
            Provider
                .of<JobViewProvider>(context, listen: true)
                .signUp ==
                pos
                ? [
              BoxShadow(
                  color: Colors.white,
                  blurRadius: 5,
                  offset: Offset(5, 5)),
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(-5, -5))
            ]
                : [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(5, 5)),
              BoxShadow(
                  color: Colors.white,
                  blurRadius: 2,
                  offset: Offset(-5, -5))
            ]),
        child: Center(child: Text(title, style: Provider
            .of<JobViewProvider>(context, listen: true)
            .signUp ==
            pos ? TextStyle(color: Color(0xFF044a87)) : TextStyle(
            color: Colors.black))),
      ),

        onTap: () => hitButton(pos, context)

    );


  }

  hitButton(int pos, BuildContext context) {
    Provider.of<JobViewProvider>(context, listen: false).setClick(pos);
  }
}
