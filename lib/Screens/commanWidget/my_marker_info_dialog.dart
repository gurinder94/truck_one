import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';

import 'comman_rich_text.dart';

class MyMarkerInfoDialog extends StatefulWidget {
  String image, address, lat, long, description, name;

  MyMarkerInfoDialog(
      this.image, this.address, this.lat, this.long, this.description, this.name,
      {Key? key})
      : super(key: key);

  @override
  State<MyMarkerInfoDialog> createState() => _MyMarkerInfoDialogState();
}

class _MyMarkerInfoDialogState extends State<MyMarkerInfoDialog> {
  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(color: Colors.black, width: 1),
              color: Colors.white,
              boxShadow: [
                new BoxShadow(
                    color: Colors.black, spreadRadius: 1, blurRadius: 10)
              ]),
          height: MediaQuery.of(context).size.height/2.8,
    //       child: Stack(
    //         clipBehavior: Clip.none,
    //         children: [
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.stretch,
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             children: [
    //               SizedBox(height:10,),
    //               Container(
    //                 padding: EdgeInsets.all(5),
    //                 decoration: BoxDecoration(
    //                     color: PrimaryColor,
    //                     border: Border.all(color: Colors.black54, width: 1),
    //                     borderRadius: BorderRadius.all(Radius.circular(5))),
    //                 child: Text(
    //                   '${widget.address}',
    //                   style: TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 13,
    //                       fontWeight: FontWeight.w500),
    //                   textAlign: TextAlign.center,
    //                 ),
    //               ),
    //               Container(
    //                   padding: EdgeInsets.all(1),
    //                   decoration: BoxDecoration(
    //                       border: Border.all(color: Colors.black54, width: 1),
    //                       borderRadius: BorderRadius.all(Radius.circular(5))),
    //                   child: Column(
    //                     children: [
    //                       SizedBox(
    //                         height: 5,
    //                       ),
    //                       SizedBox(
    //                         height: 5,
    //                       ),
    //                       Text(
    //                         'Latitude:-${widget.lat} \nLongitude:-${widget.long}',
    //                         style: TextStyle(
    //                             color: Colors.black,
    //                             fontSize: 10,
    //                             fontWeight: FontWeight.w700),
    //                         textAlign: TextAlign.center,
    //                       ),
    //                       SizedBox(
    //                         height: 6,
    //                       ),
    //                       Image.asset(
    //                         "serviceIcon/${widget.image}",
    //                         height: 70,
    //                         width: 70,
    //                         fit: BoxFit.contain,
    //                       ),
    //                       SizedBox(
    //                         height: 5,
    //                       ),
    //
    //
    //                     ],
    //                   )),
    //               SizedBox(
    //                 height: 10,
    //               ),
    //               Text("Description : ${widget.description.toString()=="null"?"N/A":widget.description.toString()}"),
    //
    //
    //
    //
    //
    //
    //           Positioned(
    //               right: -10,
    //               top: -30,
    //               child: GestureDetector(
    //                 child: Container(
    //                   padding: EdgeInsets.all(3),
    //                   child: Icon(Icons.close,color: Colors.red,),
    //                 decoration: BoxDecoration(
    //                   shape: BoxShape.circle,
    //                   color: Colors.white
    //                 ),),
    //                 onTap: ()
    //                 {
    //                   Navigator.pop(context);
    //                 },
    //               ))
    //         ]
    //       )
    //   ]
    // ),
        child:Column(
          children: [
            SizedBox(height: 10,),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    SizedBox(),
        Text("${widget.name}",style: TextStyle(
            fontWeight: FontWeight.bold,
            height: 1.4,
            color: Colors.black),),
  GestureDetector(child: Icon(Icons.close),
  onTap: ()
    {
      Navigator.pop(context);
    },),
  ],
),
            Divider(),
            SizedBox(height: 5,),
            Row(
crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(  "serviceIcon/${widget.image}",width: 50,height: 50,fit: BoxFit.cover),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CommonRichText(
                                richText1: 'Location\n',
                                style1: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    height: 1.4,
                                    color: Colors.black),
                                richText2: widget.address,
                                style2:
                                TextStyle(fontWeight: FontWeight.normal),
                              ),


                              Divider(),
                              CommonRichText(
                                richText1: 'Description\n',
                                style1: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    height: 1.4,
                                    color: Colors.black),
                                richText2: widget.description=="null"?'':widget.description,
                                style2:
                                TextStyle(fontWeight: FontWeight.normal),
                              ),


                      Padding(
                          padding: EdgeInsets.all(5),
                          child: SizedBox(width: 20,height: 20,),
                      )
                ] // end of Column Widgets
            ),  // end of Column
      ),  // end of Container
    ),  // end of Expanded
              ],
            ),
          ],
        ),

      )    );
  }
}
