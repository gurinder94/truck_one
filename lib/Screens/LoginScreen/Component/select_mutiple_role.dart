import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/LoginListModel.dart';
import 'package:my_truck_dot_one/Screens/LoginScreen/Provider/LoginPageProvider.dart';


class MutipleRoleSelected extends StatefulWidget {
  List<Role> mutipleRole;
  String roleId;
  LoginProvider loginProvider;
  String id;

  MutipleRoleSelected(
      this.mutipleRole, this.roleId, this.loginProvider, this.id);

  @override
  State<MutipleRoleSelected> createState() => _MutipleRoleSelectedState();
}

class _MutipleRoleSelectedState extends State<MutipleRoleSelected> {
  var size;
  var group1Value;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [

            Container(
              width: double.infinity,
              height: double.infinity,
              child: Opacity(
                  opacity: .3,
                  child: Image.asset(
                    "Company_menu_image/abstract.jpg",
                    fit: BoxFit.cover,
                  )),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    end   : Alignment.topRight,
                    begin: Alignment.topLeft,
                    colors: [
                      Color(0xFF044a87).withOpacity(0.2),

                      Colors.white,
                    ],
                  )),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Image.asset(
                    "Company_menu_image/Group.png",
                    width: MediaQuery.of(context).size.width / 1,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Login As",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  //             Expanded(
                 Expanded(
                   child: ListView.builder(
                      itemCount: widget.mutipleRole.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child:    Container(
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.only(
                                  left: 35, right: 35, top: 15, bottom: 15),
                              decoration: group1Value==index?BoxDecoration(
                              color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color:     Colors.black12.withOpacity(0.1),


                                  offset: Offset(-4, -4)),
                              BoxShadow(
                                  color:Colors.white,
                                  blurRadius: 3,
                                  offset: Offset(4, 4)),
                            ]):BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                        color:Colors.white,

                                        offset: Offset(-4, -4)),
                                    BoxShadow(
                                        color:     Colors.black.withOpacity(0.2),
                                        blurRadius: 3,
                                        offset: Offset(4, 4)),
                                  ]),
                              child: Center(
                                  child: Text(
                                      capitalize( widget.mutipleRole[index].roleName.toString())
                                   ,
                                    style: TextStyle(
                                        color: Color(0xFF044a87),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ))),
                          onTap: () {
                            setState(() {
                               group1Value = index;
                              widget.loginProvider.hitMutipleRole(widget.roleId,
                                  widget.mutipleRole[index].id, widget.mutipleRole[index].roleName, context, widget.id);
                               setState(() {

                        });


                              // newRoleName = mutipleRole[index].roleName;
                              // newRoleId = mutipleRole[index].id;
                            });
                          },
                        );
                      }),
                 ),



                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
