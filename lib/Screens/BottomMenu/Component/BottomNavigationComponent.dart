import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/BottomMenu/Provider/bottom_provider.dart';
import 'package:provider/provider.dart';

class BottomNavigationComponent extends StatelessWidget {
  int pos;
  String title;
  String path;

  BottomNavigationComponent(this.pos, this.title, this.path);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
          onTap: () => hitButton(pos, context),
          child: Provider.of<BottomProvider>(context, listen: true).menuClick ==
              pos
              ? Container(
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFD9D8D8),
                    offset: Offset(-2.0, -2.0),
                    blurRadius: 3,
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(.5),
                    offset: Offset(1.0, 1.0),
                    blurRadius: 1,
                  ),
                ]),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFE5E5E5),
                      Color(0xFFECEAEA),

                      Color(0xFFECEAEA),
                    ],),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFD5D5D5),
                      offset: Offset(5.0, 5.0),
                      blurRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5.0, -5.0),
                      blurRadius: 3,
                    ),
                  ]),
               child: SvgPicture.asset(
              path,
                 width: 25,
                 height: 25,
                 color: PrimaryColor,
            ),
            ),
          )
              : Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xF8C6C4C4),
                      offset: Offset(5.0, 5.0),
                      blurRadius: 10,
                      spreadRadius: -4),
                  BoxShadow(
                    color: Colors.white.withOpacity(.5),
                    offset: Offset(-3.0, -3.0),
                    blurRadius: 1,
                  ),
                ]),
            // child:FaIcon(
            //   path,
            //   size: 30,
            //   color: Color(0xFF044a87),
            //
            // ),
            child: Center(
              child: SvgPicture.asset(
                path,
                width: 20,
                height: 20,
                color: Colors.black54.withOpacity(0.3),
              ),
            ),
          )),
    );
  }

  hitButton(int pos, BuildContext context) {
    context.read<BottomProvider>()

        .setMenuClick(pos);
  }
}