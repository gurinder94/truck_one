import 'package:flutter/material.dart';

import '../commanWidget/Custom_App_Bar_Widget.dart';

class PaymentFailedScreen extends StatelessWidget {
  const PaymentFailedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppBarWidget(
        leading: SizedBox(),
        title: "Payment Failed",
        actions: SizedBox(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 120,
            ),
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.red,
              child: Icon(Icons.close, color: Colors.white, size: 60),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Payment Failed",
              style: TextStyle(
                  color: Colors.red, fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Oops! Something went Wrong",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.message_rounded,
                    color: Colors.black.withOpacity(0.6),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      "Any money deducted will be  refunded 3-8 working days",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionWidget: SizedBox());
  }
}
