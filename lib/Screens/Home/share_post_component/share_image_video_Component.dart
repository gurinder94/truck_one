import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Home/share_post_component/share_post_display_page.dart';
import 'package:video_player/video_player.dart';

import '../../../AppUtils/constants.dart';
import '../../../Model/NetworkModel/post_list_model.dart';
import '../../Network/group_view/GroupComponent/video_view.dart';
import '../../commanWidget/loading_widget.dart';
import '../post_display_page.dart';

class ShareImageVideoComponent extends StatefulWidget {

  List<Media> media;
  PostItem provider;
  ShareImageVideoComponent(this.media, this.provider);

  @override
  State<ShareImageVideoComponent> createState() => _ShareImageVideoComponentState();
}

class _ShareImageVideoComponentState extends State<ShareImageVideoComponent> {
int pagePos=0;

  late VideoPlayerController _controller;

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
                  pageBuilder: (_, __, ___) => SharePostDisplayPage(widget.provider),
                ),
              );
            },
            child: PageView.builder(
              itemCount: widget.media.length,
              controller: PageController(
                  initialPage: 0, keepPage: true, viewportFraction: 1),
              onPageChanged: (value)
              {
                pagePos=value;
                setState(() {

                });
              },
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
                          Center(child: Image.asset('icons/defaultImage.jpg',
                            height: 300,
                            width:double.infinity ,fit: BoxFit.cover,
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

class Dot extends StatelessWidget {
  Color color;
  double size;

  Dot(this.color, this.size);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: size,
      width: size,
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
