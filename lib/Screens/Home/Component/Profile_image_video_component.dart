import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/user_detail_model.dart';
import 'package:my_truck_dot_one/Screens/Home/Component/profile_VideoView.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/user_detail_provider.dart';

import 'package:video_player/video_player.dart';

import '../../commanWidget/loading_widget.dart';

class ProfileImageVideoComponent extends StatelessWidget {

  UserDetailProvider?provider;

  var list;
  late VideoPlayerController _controller;

  ProfileImageVideoComponent( this.list, this. provider);

  @override
  Widget build(BuildContext context) {


    return SizedBox(
      height: 300,
      child: GestureDetector(

        child: PageView.builder(
          itemCount: list.length,
          controller: PageController(
              initialPage: 0, keepPage: true, viewportFraction: 1),
          itemBuilder: (BuildContext context, int itemIndex) {
            Media _media = list[itemIndex];
            return _media.type == 'IMAGE'
                ? Container(
              height: 300,
              child: Image.network(
                Base_URL_image + _media.name.toString(),
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  return progress == null
                      ? child
                      : Center(child: LoadingWidget(((progress.cumulativeBytesLoaded / progress.expectedTotalBytes!) *
                      100)
                      .toInt()));
                },
              ),
            )
                : ProfileVideoView(_media.name);
          },
        ),
      ),
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
