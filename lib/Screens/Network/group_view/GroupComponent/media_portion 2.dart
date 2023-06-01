import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_model.dart';
import 'package:my_truck_dot_one/Screens/Network/group_view/GroupComponent/video_view.dart';
import 'package:provider/src/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../commanWidget/loading_widget.dart';
import 'group_post_display_page.dart';

class MediaPortion extends StatefulWidget {
  List<Media> media;
  PostDatum data;
  MediaPortion(this.media, this.data );

  @override
  State<MediaPortion> createState() => _MediaPortionState();
}

class _MediaPortionState extends State<MediaPortion> {
  late VideoPlayerController _controller;
int pagePos=0;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(

        onDoubleTap: (){
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false, // set to false
              pageBuilder: (_, __, ___) => GroupPostDisplayPage(widget.data),
            ),
          );

      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: 300,
            child: PageView.builder(
              itemCount:widget.media.length,
              onPageChanged: (val)
              {
                pagePos=val;
                setState(() { });
              },
              controller:
                  PageController(initialPage: 0, keepPage: true, viewportFraction: 1),
              itemBuilder: (BuildContext context, int itemIndex) {
                Media _media = widget.media[itemIndex];
                return _media.type == 'IMAGE'
                    ? Container(
                        height: 300,
                        child: Image.network(
                          Base_URL_group_image + _media.name.toString(),
                          fit: BoxFit.fill, errorBuilder: (a, b, c) =>
                            Center(child: Image.asset('assets/default.png')),
                          loadingBuilder: (context, child, progress) {
                            return progress == null
                                ? child
                                : SizedBox(
                              width: 50,
                              height: 50,
                              child: Center(
                                  child: LoadingWidget(
                                      ((progress.cumulativeBytesLoaded /
                                          progress.expectedTotalBytes!) *
                                          100)
                                          .toInt())),
                            );

                          },
                        ),
                      )
                    : VideoView(_media.name!);
              },
            ),
          ),
          widget.media.length>1?    Container(
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
      ),

    );
  }
}
