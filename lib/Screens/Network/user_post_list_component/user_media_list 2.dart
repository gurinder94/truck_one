import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/user_detail_model.dart';
import 'package:video_player/video_player.dart';

import '../../commanWidget/loading_widget.dart';
import '../group_view/GroupComponent/video_view.dart';

class UserMediaList extends StatelessWidget {
  List<Media> media;

  UserMediaList(this.media);

  late VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: media.length,
        controller:
            PageController(initialPage: 0, keepPage: true, viewportFraction: 1),
        itemBuilder: (BuildContext context, int itemIndex) {
          Media _media = media[itemIndex];
          return _media.type == 'IMAGE'
              ? Container(
                  height: 300,
                  child: Image.network(
                    /*Base_URL_group_image +*/
                    _media.name.toString(),
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : SizedBox(
                              width: 50,
                              height: 50,
                              child: Center(
                                  child: LoadingWidget(((progress
                                                  .cumulativeBytesLoaded /
                                              progress.expectedTotalBytes!) *
                                          100)
                                      .toInt())),
                            );
                    },
                    errorBuilder: (a, b, c) => Center(
                      child: Image.asset(
                        'icons/bannerProfile.png',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: 280,
                      ),
                    ),
                  ),
                )
              : VideoView(_media.name!);
        },
      ),
    );
  }
}
