import 'package:flutter/material.dart';

import '../../AppUtils/constants.dart';
import '../Language_Screen/application_localizations.dart';

class DialogUtils {
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
                      title.toString() == "null" ? '' : title.toString(),
                    ),
                    content: Text(
                      alertTitle.toString(),
                      textAlign: TextAlign.justify,
                    ),
                    actions: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          splashColor: PrimaryColor,
                          highlightColor: Colors.white,
                          child: Text(AppLocalizations.instance.text('No'),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16)),
                          onTap: () async {
                            oncancelFunction();
                          },
                        ),
                      ),
                      SizedBox(),
                      loder == true
                          ? CircularProgressIndicator()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                splashColor: PrimaryColor,
                                highlightColor: Colors.white,
                                child: Text(
                                    AppLocalizations.instance.text('Yes'),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16)),
                                onTap: () async {
                                  onDoneFunction();
                                },
                              ),
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

  static Future AlertBox(
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
                        title.toString() == "null" ? '' : title.toString()),
                    content:
                        Text(alertTitle.toString(), textAlign: TextAlign.left),
                    actions: <Widget>[
                      secondBtnText.toString() == "null"
                          ? SizedBox()
                          : InkWell(
                              splashColor: PrimaryColor,
                              highlightColor: Colors.white,
                              child: Text(secondBtnText.toString()),
                              onTap: () async {
                                oncancelFunction();
                              },
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          splashColor: PrimaryColor,
                          highlightColor: Colors.white,
                          child: Text(
                            buttonTitle.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          onTap: () async {
                            onDoneFunction();
                          },
                        ),
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

  static Future<dynamic> showMySuccessful(
    BuildContext context, {
    required Widget child,
  }) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
              transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
              child: Opacity(opacity: a1.value, child: child));
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

  static Future WarningMesaage(
    BuildContext context, {
    required Widget? childd,
  }) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
              transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
              child: Opacity(opacity: a1.value, child: childd));
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
