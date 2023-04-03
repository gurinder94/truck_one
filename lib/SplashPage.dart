import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/provider/ProfileProvider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:provider/provider.dart';

import 'Screens/BottomMenu/bottom_menu.dart';
import 'Screens/LoginScreen/LoginScreen.dart';
import 'Screens/Profile/Company/CompanyProfile.dart';
import 'Screens/Profile/UserProfile/Userprofile.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends State with TickerProviderStateMixin {
  late Size size;
  late AnimationController _animationController;
  late Animation _animation;
  String name = '';
  var name_arr = ['M', 'y', 'T', 'r', 'u', 'c', 'k', '.', 'O', 'n', 'e'];
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: .8).animate(_animationController);
    _animation.addListener(() {
      setState(() {});
    });
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        printCharacters();
      }
    });
    _animationController.forward();
  }

  printCharacters() {
    int val = 0;
    const oneDecimal = const Duration(milliseconds: 100);
    _timer = new Timer.periodic(
        oneDecimal,
        (Timer timer) => setState(() {
              if (val < 11) {
                name += name_arr[val];
                val++;
              } else {
                _timer.cancel();

                // sleep(Duration(microseconds:1000));
                checkCondition();
                //   Navigator.of(context).pushAndRemoveUntil(
                //       MaterialPageRoute(
                //         builder: (context) => ChangeNotifierProvider(
                //             create: (_) => PriceProvider(),
                //             child: PricingScreen()),
                //       ),
                //     (Route<dynamic> route) => false);

                // Navigator.of(context).pushAndRemoveUntil(
                //     MaterialPageRoute(
                //       builder: (context) => ChangeNotifierProvider(
                //
                //           create: (_)=>AddCartProvider(),
                //           child: AddCartScreen()),
                //     ),
                //         (Route<dynamic> route) => false);
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: Column(
          children: [
            Spacer(),
            Opacity(
              opacity: _animation.value,
              child: Image.asset(
                'assets/app_logo.png',
                scale: 2,
              ),
            ),
            Text(
              name,
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A62A9)),
            ),
            Spacer(),
            // Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Text(
            //       "Beta Version",
            //       style: TextStyle(
            //           color: PrimaryColor,
            //           fontSize: 18,
            //           fontWeight: FontWeight.w800),
            //     )),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkCondition() async {
    var id = await getUserId();
    var role = await getRoleInfo();
    var profileComplete = await getProfileComplete();

    print(role);
    print(profileComplete);

    if (id != null) {
      switch (role) {
        case "COMPANY":
          if (profileComplete == false)
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                        create: (_) => ProfileProvider(),
                        child: CompanyProfile(false))));
          else
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => BottomMenu('Company', 0)),
                (Route<dynamic> route) => false);

          break;

        case "ENDUSER":
          if (profileComplete == false)
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileUser(false)));
          else
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => BottomMenu('User', 0)),
                (Route<dynamic> route) => false);

          break;
        case "DISPATCHER":
          if (profileComplete == false)
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileUser(false)));
          else
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => BottomMenu('Dispatcher', 0)),
                (Route<dynamic> route) => false);

          break;

        case "SELLER":
          if (profileComplete == false)
            DialogUtils.AlertBox(
              context,
              onDoneFunction: () async {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false);
              },
              oncancelFunction: () => Navigator.pop(context),
              title: 'Profile Complete!',
              buttonTitle: "yes",
              alertTitle: "Kindly fill your profile before proceeding further.",
            );
          else
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => BottomMenu('Seller', 0)),
                (Route<dynamic> route) => false);
          break;
        case "DRIVER":
          if (profileComplete == false)
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileUser(false)));
          else
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => BottomMenu('Driver', 0)),
                (Route<dynamic> route) => false);
          break;
        case "HR":
          if (profileComplete == false)
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileUser(false)));
          else
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => BottomMenu('Hr', 0)),
                (Route<dynamic> route) => false);
          break;
        case "SALESPERSON":
          if (profileComplete == false) {
            DialogUtils.AlertBox(
              context,
              onDoneFunction: () async {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false);
              },
              oncancelFunction: () => Navigator.pop(context),
              title: 'Profile Complete!',
              buttonTitle: "yes",
              alertTitle: "Kindly fill your profile before proceeding further.",
            );
          } else
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => BottomMenu('Saleperson', 0)),
                (Route<dynamic> route) => false);
          break;
      }
    } else {
      if (id == null)
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
    // else {
    //   print("role");
    //   switch (role) {
    //
    //     case ("COMPANY"):
    //       Navigator.of(context).pushAndRemoveUntil(
    //           MaterialPageRoute(builder: (context) => BottomMenu('Company')),
    //               (Route<dynamic> route) => false);
    //       break;
    //     case ("ENDUSER"):
    //       Navigator.of(context).pushAndRemoveUntil(
    //           MaterialPageRoute(builder: (context) => BottomMenu('User')),
    //               (Route<dynamic> route) => false);
    //       break;
    //     case ("DISPATCHER"):
    //       Navigator.of(context).pushAndRemoveUntil(
    //           MaterialPageRoute(builder: (context) => BottomMenu('Dispatcher')),
    //               (Route<dynamic> route) => false);
    //       break;
    //     case ("SELLER"):
    //       Navigator.of(context).pushAndRemoveUntil(
    //           MaterialPageRoute(builder: (context) => BottomMenu('Seller')),
    //               (Route<dynamic> route) => false);
    //       break;
    //     default:
    //       print("Plz Check Role");
    //   }
    // }
  }
}
// AppLocalizations.instance.text('helloWorld')
