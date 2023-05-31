import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/user_detail_provider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';

import '../../../AppUtils/constants.dart';
import '../../../Model/NetworkModel/user_detail_model.dart';
import '../../Home/Component/description_txt.dart';
import '../../commanWidget/comman_video_play.dart';
import '../../commanWidget/loading_widget.dart';

class GroupSharedWidget extends StatelessWidget {
  PostDatum item;
  int position;
  UserDetailProvider listProvider;

  GroupSharedWidget(this.listProvider, this.position, this.item);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return item.type == "SHARED"
        ? Container(
      padding: EdgeInsets.all(10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      child: CustomImageProfile(
                        width: 50,
                        height: 50,
                        image:  item.orignalPostData==null? IMG_URL + item.userData!.image.toString():IMG_URL +  item.orignalPostData!.userData!.image.toString(),
                        boxFit: BoxFit.cover,
                      ),
                    ),
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
                              item.orignalPostData==null?item.userData!.personName.toString():          item.orignalPostData!.userData!.personName.toString(),
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

                    /* Text(
              '+  Follow',
              style: TextStyle(color: PrimaryColor, fontWeight: FontWeight.bold),
            ),*/
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                DescriptionTxt(
                  description:  item.orignalPostData==null?item.caption.toString():item.orignalPostData!.caption.toString(),
                  isShared: item.type == 'SHARED' ? true : false,
                ),

                    item.orignalPostData == null
                        ? SizedBox()
                        :  item.orignalPostData!.media!.length!=0?Container(
                      width: double.infinity,
                      height: 250,
                      child: ListView.builder(
                          itemCount: item.orignalPostData!.media!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return item.orignalPostData!.media![index]
                                .type ==
                                "IMAGE"
                                ? Container(

width: MediaQuery.of(context).size.width,
                              height: 280,
                              child:Image.network(  Base_URL_group_image +
                                  item.orignalPostData!
                                      .media![index].name
                                      .toString(),
                                fit: BoxFit.fill,
                                loadingBuilder: (context, child, progress) {
                                  return progress == null
                                      ? child
                                      : Center(
                                        child: SizedBox(
                                    width: 50,
                                    height:50,
                                    child: LoadingWidget(
                                          ((progress.cumulativeBytesLoaded /
                                              progress.expectedTotalBytes!) *
                                              100)
                                              .toInt()),
                                  ),
                                      );

                                },
                                errorBuilder: (a, b, c) =>
                                    Center(
                                      child: Image.asset('icons/bannerProfile.png',  fit: BoxFit.cover,
                                        width:MediaQuery.of(context).size.width,
                                        height: 280,
                                      ),
                                    ),
                              ),
                             )
                                : CommanVideoView(item
                                .orignalPostData!.media![index].name
                                .toString());
                          }),
                    ):SizedBox(),

              ],
            ),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10)
      ),
        )
        : SizedBox();
  }
}
