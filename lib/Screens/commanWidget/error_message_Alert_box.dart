import 'package:flutter/material.dart';

import '../../AppUtils/constants.dart';
import '../Language_Screen/application_localizations.dart';

class DialogUtilsError {
  static const double padding = 20;
  static const double avatarRadius = 45;

  static Future<dynamic> showMyDialog(
    BuildContext context, {
    String? alertTitle,
    String? title,
    String? btnText,
    bool? loder,
    String? secondBtnText,
    required Function onDoneFunction,
    required Function oncancelFunction,
    Widget? alertImage,
  }) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
              transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
              child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    title: Text(
                      title.toString() == "null"
                          ? ''
                          : AppLocalizations.instance.text(title.toString()),
                    ),
                    content: Text(
                        AppLocalizations.instance.text(alertTitle.toString())),
                    actions: <Widget>[
                      InkWell(
                        splashColor: PrimaryColor,
                        highlightColor: Colors.white,
                        child: new Text(
                          AppLocalizations.instance.text('No'),
                        ),
                        onTap: () {
                          oncancelFunction();
                        },
                      ),

                      loder == true
                          ? CircularProgressIndicator()
                          :         InkWell(
                        splashColor: PrimaryColor,
                        highlightColor: Colors.white,
                        child: new Text(
                            AppLocalizations.instance.text('Yes')),

                        onTap: () async {
                          onDoneFunction();
                        },
                      ),


                      SizedBox(
                        width: 5,
                      ),
                    ],
                  )));
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(0, 1),
              end: const Offset(0, 0),
            ).animate(animation1),
          );
        });
  }

  static Future ErrorMessageAlertBox(
    BuildContext context, {
    String? alertTitle,
    String? title,
    String? buttonTitle,
    String? secondBtnText,
    String? btnText,
    required Function onDoneFunction,
    required Function oncancelFunction,
    Widget? alertImage,
  }) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.2),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 0.0;
          return Transform(
              transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Opacity(
                    opacity: a1.value,
                    child: Stack(children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            left: padding,
                            top: avatarRadius + padding,
                            right: padding,
                            bottom: padding),
                        margin: EdgeInsets.only(top: avatarRadius),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(padding),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(0, 10),
                                  blurRadius: 10),
                            ]),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              alertTitle.toString(),
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              title.toString(),
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child:   InkWell(
                                splashColor: PrimaryColor,
                                highlightColor: Colors.white,
                                child: new Text(
                                  buttonTitle.toString(),
                                  style: TextStyle(fontSize: 18),
                                ),
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          left: padding,
                          right: padding,
                          child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: avatarRadius,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(avatarRadius)),
                                child: Image.asset(
                                    "directionIcon/noroutefound.png"),
                              )))
                    ])),
              ));
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(0, 1),
              end: const Offset(0, 0),
            ).animate(animation1),
          );
        });
  }
}
