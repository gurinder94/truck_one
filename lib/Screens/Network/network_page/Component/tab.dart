import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Network/network_page/network_provider.dart';
import 'package:provider/provider.dart';

class CustomTab extends StatelessWidget {
  String title;
  Function onClick;

  int  enable=0;
  bool loading =false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        loading==true?SizedBox():   onClick();
        loading==true?SizedBox():  hitButton( enable,  context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration:  BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: Provider.of<NetworkProvider>(context, listen: true).tabEnable ==
                  enable ?[
              BoxShadow(
                  color: Colors.white, blurRadius: 5, offset: Offset(5, 5)),
              BoxShadow(
                  color: Colors.black12, blurRadius: 5, offset: Offset(-5, -5))
              ]:[
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(5, 5)),
                BoxShadow(
                    color: Colors.white, blurRadius: 2, offset: Offset(-5, -5))
              ]),
          child: Text(title),
        ),
      ),
    );
  }
  hitButton(int pos, BuildContext context) {
    Provider.of<NetworkProvider>(context, listen: false).setRecommendationTab(pos);
  }
  CustomTab({required this.title,required this.onClick,required this.enable, required this.loading});
}
