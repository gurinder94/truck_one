import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_model.dart';

import 'package:my_truck_dot_one/Screens/Network/group_view/GroupComponent/video_view.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import '../../../Home/Component/description_white.dart';
import '../../../commanWidget/loading_widget.dart';

class GroupPostDisplayPage extends StatefulWidget {
  PostDatum postDatum;
   GroupPostDisplayPage(this.postDatum);

  @override
  _GroupPostDisplayPageState createState() => _GroupPostDisplayPageState(postDatum);
}

class _GroupPostDisplayPageState extends State<GroupPostDisplayPage> {
  PostDatum postDatum;
  _GroupPostDisplayPageState(this.postDatum);
  int pagePos = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              clipBehavior: Clip.antiAlias,
              child: Image.network(

                IMG_URL + postDatum.userData!.image.toString(),
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
                errorBuilder: (a, b, c) =>
                    Center(child: Image.asset('icons/bannerProfile.png')),
                fit: BoxFit.cover,
              ),
              decoration:  BoxDecoration(
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      postDatum.userData!.personName.toString(),
                      style:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      postDatum.postedAt.toString(),
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          fontSize: 15),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
      backgroundColor: Colors.black.withOpacity(.5),
      body: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: PageView.builder(
                      itemCount: postDatum.media!.length,
                      onPageChanged: (val) {
                        pagePos = val;
                        setState(() {});
                      },
                      controller: PageController(
                          initialPage: 0, keepPage: true, viewportFraction: 1),
                      itemBuilder: (BuildContext context, int itemIndex) {
                        Media _media = postDatum.media![itemIndex];
                        return _media.type == 'IMAGE'
                            ? Padding(
                            padding:
                            const EdgeInsets.only(top: 20, bottom: 20),
                            child: PinchZoom(
                              child: CustomImage(
                                height: 300,
                                width:double.infinity ,
                                boxFit: BoxFit.fill,
                                image:    /* Base_URL_group_image + */_media.name.toString(),
                              ),
                              resetDuration:
                              const Duration(milliseconds: 100),
                              maxScale: 2.5,
                              onZoomStart: () {
                                print('Start zooming');
                              },
                              onZoomEnd: () {
                                print('Stop zooming');
                              },
                            ))
                            : VideoView(_media.name!);
                      },
                    ),
                  ),
                  Container(
                      color: Colors.black.withOpacity(.5),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: postDatum.media!.length,
                                itemBuilder: (context, index) => Container(
                                  height: index == pagePos ? 7 : 5,
                                  width: index == pagePos ? 7 : 5,
                                  margin: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                )),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/like_ic.png',
                                scale: 30,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                postDatum.totalLike.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),

                              Expanded(
                                  child: Text(
                                    '${postDatum.totalComment} Comments',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ))
                            ],
                          ),
                        ],
                      ))
                ],
              ),
              Positioned(
                  bottom: 100,
                  child: DescriptionWhite(description: postDatum.caption!)),
            ],
          )),
    );
  }
}
