import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/post_list_model.dart';
import 'package:my_truck_dot_one/Screens/Home/post_display_page.dart';
import 'package:my_truck_dot_one/Screens/Network/group_view/GroupComponent/video_view.dart';

import 'package:video_player/video_player.dart';

import '../../commanWidget/loading_widget.dart';

class ImageVideoComponent extends StatefulWidget {
  List<Media> media;
  PostItem provider;

  ImageVideoComponent(this.media, this.provider);

  @override
  State<ImageVideoComponent> createState() => _ImageVideoComponentState();
}

class _ImageVideoComponentState extends State<ImageVideoComponent> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController =
        PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
    super.initState();
  }

  @override
  int pagePos = 0;

  void dispose() {
    //...

    _pageController.dispose();
    super.dispose();
    //...
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 300,
          child: GestureDetector(
            onDoubleTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  opaque: false, // set to false
                  pageBuilder: (_, __, ___) => PostDisplayPage(widget.provider),
                ),
              );
            },
            child: PageView.builder(
              itemCount: widget.media.length,
              controller: PageController(
                  initialPage: 0, keepPage: true, viewportFraction: 1),
              onPageChanged: (value) {
                pagePos = value;
                setState(() {});
              },
              itemBuilder: (BuildContext context, int itemIndex) {
                Media _media = widget.media[itemIndex];
                return _media.type == 'IMAGE'
                    ? Image.network(
                        Base_URL_group_image + _media.name.toString(),
                        width: double.infinity,
                        fit: BoxFit.fill,
                        loadingBuilder: (context, child, progress) {
                          return progress == null
                              ? child
                              : Center(
                                  child: LoadingWidget(((progress
                                                  .cumulativeBytesLoaded /
                                              progress.expectedTotalBytes!) *
                                          100)
                                      .toInt()));
                        },
                        errorBuilder: (a, b, c) => Image.asset(
                          'assets/default.png',
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      )
                    : VideoView(_media.name!);
              },
            ),
          ),
        ),
        /*Container(
          height: 400,
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
            allowImplicitScrolling: true,
            itemCount: widget.provider.media!.length,
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            onPageChanged: (val) {
              pagePos = val;
              setState(() {});
            },
            itemBuilder: (BuildContext context, int itemIndex) {
              Media _media = widget.provider.media![itemIndex];

              return _media.type == 'IMAGE'
                  ? GestureDetector(
                      onDoubleTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false, // set to false
                            pageBuilder: (_, __, ___) =>
                                PostDisplayPage(widget.provider),
                          ),
                        );
                      },
                      child: Image.network(
                        Base_URL_Image_ThumbNail + _media.name.toString(),
                        fit: BoxFit.fill,
                        loadingBuilder: (context, child, progress) {
                          return progress == null
                              ? child
                              : Center(
                                  child: LoadingWidget(((progress
                                                  .cumulativeBytesLoaded /
                                              progress.expectedTotalBytes!) *
                                          100)
                                      .toInt()));
                        },
                        errorBuilder: (a, b, c) => Center(
                            child: Image.asset(
                          'icons/defaultImage.jpg',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )),
                      ),
                    )
                  : GestureDetector(
                      onDoubleTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false, // set to false
                            pageBuilder: (_, __, ___) =>
                                PostDisplayPage(widget.provider),
                          ),
                        );
                      },
                      child: VideoView(_media.name!));
            },
          ),
        ),*/
        widget.media.length > 1
            ? Container(
                width: double.infinity,
                color: Colors.black.withOpacity(.5),
                alignment: Alignment.center,
                child: SizedBox(
                  height: 25,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: widget.provider.media!.length,
                      itemBuilder: (context, index) => Container(
                            height: index == pagePos ? 9 : 5,
                            width: index == pagePos ? 9 : 5,
                            margin: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          )),
                ))
            : SizedBox()
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
