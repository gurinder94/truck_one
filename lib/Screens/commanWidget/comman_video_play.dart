import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../AppUtils/constants.dart';

class CommanVideoView extends StatefulWidget {
  String name;

  CommanVideoView(this.name);

  @override
  _CommanVideoViewState createState() => _CommanVideoViewState(name);
}

class _CommanVideoViewState extends State<CommanVideoView> {
  String Base_URL_video = SERVER_URL+'/uploads/post/video/';
  late VideoPlayerController _controller;
  String name;

  _CommanVideoViewState(this.name);

  bool load = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(Base_URL_video + name)
      ..initialize().then((val) {
        setState(() {
          load = false;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(

        height: 280,
        width: 280,
      alignment: Alignment.center,
      child:Stack(
        children: [
      ClipRRect(
      borderRadius: BorderRadius.circular(15),
        child: VideoPlayer(_controller)
   ),
       Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child:  load?Center(child: CircularProgressIndicator()):   IconButton(
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 100,
                  color: Colors.white.withOpacity(0.8)
                )),
          )
        ],
      ),

    );
  }
}
