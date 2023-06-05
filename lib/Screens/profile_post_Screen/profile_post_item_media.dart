import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/user_detail_model.dart';
import 'package:my_truck_dot_one/Screens/profile_post_Screen/profile_post_display_page.dart';

import '../../AppUtils/constants.dart';
import '../Home/post_display_page.dart';
import '../Network/group_view/GroupComponent/video_view.dart';
import '../commanWidget/loading_widget.dart';

class ProfilePostMediaPart extends StatefulWidget {
  List<Media> media;
  PostDatum provider;

  ProfilePostMediaPart(this.media, this.provider);

  @override
  State<ProfilePostMediaPart> createState() => _ProfilePostMediaPartState();
}

class _ProfilePostMediaPartState extends State<ProfilePostMediaPart> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController =
        PageController(initialPage: 0, keepPage: true, viewportFraction: 1);

    super.initState();
  }

  @override
  void dispose() {
    //...

    _pageController.dispose();
    super.dispose();
    //...
  }

  int pagePos = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false, // set to false
            pageBuilder: (_, __, ___) =>
                ProfilePostDisplayPage(widget.provider),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
              itemCount: widget.media.length,
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: (val) {
                pagePos = val;
                setState(() {
                  print(val);
                });
              },
              itemBuilder: (BuildContext context, int itemIndex) {
                Media _media = widget.media[itemIndex];
                return _media.type == 'IMAGE'
                    ? Container(
                        child: Image.network(
                        Base_URL_group_image + _media.name.toString(),
                        height: 300,
                        fit: BoxFit.cover,
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
                          'assets/default.png',
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        )),
                      ))
                    : VideoView(_media.name!);
              },
            ),
          ),
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
                        itemCount: widget.media.length,
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
      ),
    );
  }
}
