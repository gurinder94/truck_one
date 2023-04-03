import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/OutsideButton.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';

class AppBarWithSearch extends StatelessWidget {
  Function onSearch;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/app_logo.png',
            width:40,
            height:40,
          ),

          SizedBox(width: 10,),
          SizedBox(
            width:40,
            height:40,
            child: OutsideButton(
              Icon: Icon(Icons.search_rounded,size: 22,),
            ),
          ),

          // Expanded(
          //   child: Row(
          //     children: [
          //       SizedBox(width: 5,),
          //       Flexible(
          //         child: Padding(
          //           padding: EdgeInsets.only(left: 13,right: 13),
          //           child: InputTextField(
          //             child: TextFormField(
          //               textInputAction: TextInputAction.done,
          //               onChanged: (val){
          //                 onSearch(val);
          //               },
          //               style: TextStyle( fontSize:12,),
          //               decoration: InputDecoration(
          //                 hintText: 'Search',
          //                 suffixIcon: Icon(Icons.search_rounded),
          //                 border: InputBorder.none,
          //                 hintStyle: TextStyle(fontSize: 14,),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //
          //     ],
          //   ),
          // ),
          // SizedBox(width: 10,),
          // Image.asset(
          //   'assets/message_ic.png',
          //   scale: 1.2,
          // ),
          // SizedBox(width: 15,),
          // Image.asset(
          //   'assets/language_ic.png',
          //   scale: 1.2,
          // ),
        ],
      ),
    );
  }

  AppBarWithSearch({required this.onSearch});
}
