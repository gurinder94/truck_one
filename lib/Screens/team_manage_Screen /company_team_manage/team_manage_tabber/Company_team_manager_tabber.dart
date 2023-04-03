import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/UserEventScreen/EventListScreen/Provider/UserEventTabBarProvider.dart';
import 'package:my_truck_dot_one/Screens/team_manage_Screen%20/company_team_manage/Provider/team_manger_provider.dart';
import 'package:provider/provider.dart';

class ManagerTeamTabber extends StatefulWidget {
  int pos;
  late String title;

  Function onTabHit;

  ManagerTeamTabber(
      {required this.title, required this.pos, required this.onTabHit});

  @override
  _ManagerTeamTabber createState() => _ManagerTeamTabber(title, pos, onTabHit);
}

class _ManagerTeamTabber extends State<ManagerTeamTabber> {
  int pos;
  late String title;
  Function onTabHit;

  _ManagerTeamTabber(this.title, this.pos, this.onTabHit);

  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          hitButton(pos, context);

          switch (pos) {
            case 0:
              setState(() {
                onTabHit('Team Manage');
              });

              break;

            case 1:
              setState(() {
                onTabHit("Separated Employees");
              });

              break;
          }
        },
        // child: Provider.of<ManagerTeamProvider>(context, listen: true).menuClick ==
        //     pos
        //     ? Container(
        //   height: 50,
        //   width: MediaQuery.of(context).size.width*0.4,
        //
        //   padding: EdgeInsets.all(1),
        //   decoration: BoxDecoration(color: Color(0xFFEEEEEE),
        //       borderRadius: BorderRadius.circular(20),
        //       boxShadow: [
        //         BoxShadow(
        //           color: Color(0xFFD9D8D8),
        //           offset: Offset(5.0, 5.0),
        //           blurRadius: 7,
        //         ),
        //         BoxShadow(
        //           color: Colors.white.withOpacity(.4),
        //           offset: Offset(-5.0, -5.0),
        //           blurRadius: 10,
        //         ),
        //       ]),
        //   child: Container(
        //     padding: EdgeInsets.all(1),
        //     decoration: BoxDecoration(color: Color(0xFFEEEEEE),
        //         borderRadius: BorderRadius.circular(20),boxShadow: [
        //           BoxShadow(
        //             color: Color(0xFFD9D8D8),
        //             offset: Offset(-5.0, -5.0),
        //             blurRadius: 2,
        //           ),
        //           BoxShadow(
        //             color: Colors.white.withOpacity(.4),
        //             offset: Offset(5.0, 5.0),
        //             blurRadius: 10,
        //           ),
        //         ]),
        //     child: Center(child: Text(title,style: TextStyle(color: Color(0xFF044a87),),)),
        //   ),
        // )
        //     : Container(
        //   height: 50,
        //   width: MediaQuery.of(context).size.width*0.5,
        //   padding: EdgeInsets.all(10),
        //   decoration: BoxDecoration(
        //       color: Color(0xFFEEEEEE),
        //       shape: BoxShape.rectangle,
        //       borderRadius: BorderRadius.circular(20),
        //       boxShadow: [
        //         BoxShadow(
        //             color: Color(0xF8C6C4C4),
        //             offset: Offset(5.0, 5.0),
        //             blurRadius: 10,
        //             spreadRadius: -4),
        //         BoxShadow(
        //           color: Colors.white.withOpacity(.5),
        //           offset: Offset(-3.0, -3.0),
        //           blurRadius: 7,
        //         ),
        //       ]),
        //   child: Center(child: Text(title)),
        // )
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(

            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow:
                    Provider.of<ManagerTeamProvider>(context, listen: true)
                                .menuClick ==
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
            child: Center(
                child: Text(title,
                    style: Provider.of<ManagerTeamProvider>(context,
                                    listen: true)
                                .menuClick ==
                            pos
                        ? TextStyle(color: Color(0xFF044a87))
                        : TextStyle(color: Colors.black))),
          ),
        ));
  }

  hitButton(int pos, BuildContext context) {
    Provider.of<ManagerTeamProvider>(context, listen: false).setMenuClick(pos);
  }
}
