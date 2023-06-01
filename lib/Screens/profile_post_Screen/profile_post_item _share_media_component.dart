import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/user_detail_model.dart';
import 'package:my_truck_dot_one/Screens/profile_post_Screen/profile_post_display_page.dart';
import 'package:my_truck_dot_one/Screens/profile_post_Screen/profile_share_post_display_page.dart';

import '../../AppUtils/constants.dart';
import '../Network/group_view/GroupComponent/video_view.dart';
import '../commanWidget/loading_widget.dart';

class ProfilePostShareMedia extends StatefulWidget {
  List<Media> media;
  PostDatum item;
   ProfilePostShareMedia(this. media,this.item, {Key? key}) : super(key: key);

  @override
  State<ProfilePostShareMedia> createState() => _ProfilePostShareMediaState();
}

class _ProfilePostShareMediaState extends State<ProfilePostShareMedia> {

  int pagePos=0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 300,
          child: GestureDetector(
            onDoubleTap: (){
              Navigator.of(context).push(
                  PageRouteBuilder(
                      opaque: false, // set to false
                      pageBuilder: (_, __, ___) => SharePostDisplayPage(widget.item)));
            },
            child: PageView.builder(
              itemCount: widget.media.length,
              onPageChanged: (val)
              {
                pagePos=val;
                setState(() {
                });
              },
              controller: PageController(
                  initialPage: 0, keepPage: true, viewportFraction: 1),
              itemBuilder: (BuildContext context, int itemIndex) {
                Media _media = widget.media[itemIndex];
                return _media.type == 'IMAGE'
                    ? Container(
                    height: 300,
                    child:Image.network(

                      Base_URL_group_image + _media.name.toString(),
                      height: 300,
                      width:double.infinity ,fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        return progress == null
                            ? child
                            : Center(
                            child: LoadingWidget(
                                ((progress.cumulativeBytesLoaded /
                                    progress.expectedTotalBytes!) *
                                    100)
                                    .toInt()));

                      },
                      errorBuilder: (a, b, c) =>
                          Center(child: Image.asset('assets/default.png',
                            height: 300,
                            width:double.infinity ,fit: BoxFit.fill,
                          )),
                    ))

                    : VideoView(_media.name!);
              },
            ),
          ),
        ),
        widget.media.length>1?      Container(
            width: double.infinity,
            color: Colors.black.withOpacity(.5),
            alignment: Alignment.center,
            child: SizedBox(
              height: 25,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: widget.media.length,
                  itemBuilder: (context, index) => Container(
                    height: index == pagePos ? 9 : 5,
                    width: index == pagePos ? 9 : 5,
                    margin: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle),
                  )),
            )):SizedBox()
      ],
    );
  }
}
