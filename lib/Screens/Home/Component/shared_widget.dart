import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/post_list_model.dart';
import 'package:my_truck_dot_one/Screens/Home/share_post_component/share_image_video_Component.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/home_page_list_provider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';


import 'description_txt.dart';
import 'image_video_component.dart';
import 'option_button.dart';

class SharedWidget extends StatelessWidget {
  PostItem item;

  HomePageListProvider listProvider;

  SharedWidget(this.item,  this.listProvider);

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
                        image:   item.orignalPostData==null?  IMG_URL+item.userData!.image.toString():IMG_URL+item.orignalPostData!.userData!.image.toString(),
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
                              capitalize( item.orignalPostData!.userData!.personName.toString(),),

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
                item.orignalPostData!.media!.length==0?SizedBox():        ShareImageVideoComponent(item.orignalPostData!.media!, item)
              ],
            ),
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(10)),
        )
        : SizedBox();

  }


}
