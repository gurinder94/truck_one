import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/post_list_model.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import '../../AppUtils/constants.dart';
import '../Network/group_view/GroupComponent/video_view.dart';
import 'custom_image_network.dart';

class CommanPageView extends StatefulWidget {

  int totalItem=0;
  List<Media> ?media;
   CommanPageView(this.totalItem,{required this.media} );


  @override
  State<CommanPageView> createState() => _CommanPageViewState();
}

class _CommanPageViewState extends State<CommanPageView> {
  int pagePos=0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(

                borderRadius:
                BorderRadius.circular(12),
              ),
              child: PageView.builder(
                itemCount: widget.totalItem,
                onPageChanged: (val) {
                  pagePos = val;
                  setState(() {});
                },
                controller: PageController(
                    initialPage: 0, keepPage: true, viewportFraction: 1),
                itemBuilder: (BuildContext context, int itemIndex) {
                  Media _media = widget.media![itemIndex];
                  return _media.type == 'IMAGE'
                      ? Padding(
                      padding:
                      const EdgeInsets.only(top: 20, bottom: 20),
                      child: PinchZoom(
                        child: CustomImage(
                          height: 300,
                          width:double.infinity ,
                          boxFit: BoxFit.contain,
                          image:          /* Base_URL_group_image  + */_media.name.toString(),
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
            SizedBox(
              height: 15,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: widget.media!.length,
                  itemBuilder: (context, index) => Container(
                    height: index ==pagePos ? 20 : 10,
                    width: index == pagePos ? 20 : 10,
                    margin: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle),
                  )),
            ),
            Container(
                color: Colors.black.withOpacity(.5),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: widget.media!.length,
                          itemBuilder: (context, index) => Container(
                            height: index ==pagePos ? 20 : 10,
                            width: index == pagePos ? 20 : 10,
                            margin: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle),
                          )),
                    ),

                  ],
                ))
          ],
        ),

      ],
    );
  }
}
