import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/user_detail_model.dart';
import 'package:my_truck_dot_one/Screens/profile_post_Screen/profile_post_display_page.dart';

import '../../AppUtils/constants.dart';
import '../Home/Component/description_txt.dart';
import '../commanWidget/custom_image_network_profile.dart';
import 'profile_post_item _share_media_component.dart';

class ProfilePostShareWidget extends StatelessWidget {
  PostDatum item;
   ProfilePostShareWidget(this.item, {Key? key}) : super(key: key);


    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return item.type == "SHARED"
          ? Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageProfile(
                    image: item.orignalPostData == null ? IMG_URL +
                        item.userData!.image.toString() : IMG_URL +
                        item.orignalPostData!.userData!.image.toString(),
                    width: 50,
                    boxFit: BoxFit.contain,
                    height: 50),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        capitalize(item.orignalPostData!.userData!.personName
                            .toString(),),

                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),


                      /* Text('157,786 followers',
                      style: TextStyle(
                        fontSize: 14,
                      )),*/
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                /* Text(
              '+  Follow',
              style: TextStyle(color: PrimaryColor, fontWeight: FontWeight.bold),
            ),*/

                // PopupMenuButton<String>(
                //   onSelected: (val) {
                //     switch (val) {
                //       case 'Delete':
                //         postDelete(item.id, context,listProvider);
                //         break;
                //       case 'Report':
                //         break;
                //     }
                //   },
                //   child: Center(
                //       child: Image.asset(
                //     'assets/post_menu_ic.png',
                //     scale: 10,
                //   )),
                //   itemBuilder: (context) {
                //     return List.generate(
                //         item.isMyPost!
                //             ? sharedMine.length
                //             : shared.length, (index) {
                //       String text =
                //       item.isMyPost!
                //               ? sharedMine[index]
                //               : shared[index];
                //       return PopupMenuItem(
                //         value: text,
                //         child: Text(item.isMyPost!
                //             ? sharedMine[index]
                //             : shared[index]),
                //       );
                //     });
                //   },
                // ),
              ],
            ),
            DescriptionTxt(
              description: item.orignalPostData!.caption.toString(),
              isShared: item.type == 'SHARED' ? true : false,
            ),
            item.orignalPostData!.media!.length == 0
                ? SizedBox()
                : ProfilePostShareMedia(item.orignalPostData!.media!, item)
          ],
        ),
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(10)),
      )
          : SizedBox();
    }

    void postDelete(String? id, BuildContext context,)
    {

    }
    }
    //     HomePageListProvider listProvider) {
    //   showDialog(
    //       context: context,
    //       builder: (context) =>
    //           Dialog(
    //             backgroundColor: Colors.transparent,
    //             child: Container(
    //               height: 130,
    //               color: Colors.white,
    //               padding: EdgeInsets.all(15),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     'Are you sure you want to delete this post?',
    //                     style: TextStyle(
    //                         fontSize: 18,
    //                         color: Colors.black,
    //                         fontWeight: FontWeight.w500),
    //                   ),
    //                   SizedBox(
    //                     height: 50,
    //                   ),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.end,
    //                     children: [
    //                       OptionButton(
    //                           onClick: () {
    //                             Navigator.pop(context);
    //                             var getId = getUserId();
    //                             // listProvider.postDelete({"id": id,"userId":getId}, position,);
    //                           },
    //                           title: 'Yes'),
    //                       OptionButton(
    //                           onClick: () {
    //                             Navigator.pop(context);
    //                           },
    //                           title: 'No'),
    //                     ],
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ));
    // }



