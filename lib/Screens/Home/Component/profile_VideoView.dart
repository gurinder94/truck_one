import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ProfileVideoView extends StatefulWidget {
  String? name;

  ProfileVideoView(this.name);

  @override
  _ProfileVideoViewState createState() => _ProfileVideoViewState(name);
}

class _ProfileVideoViewState extends State<ProfileVideoView> {
  String Base_URL_video = 'http://74.208.25.43:4000/uploads/post/video/';
  late VideoPlayerController _controller;
  String ?name;

  _ProfileVideoViewState(this.name);

  bool load = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(Base_URL_video + name!)
      ..initialize().then((val) {
        setState(() {
          load = false;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      alignment: Alignment.center,
      child: load
          ? SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator.adaptive())
          : Stack(
        children: [
          VideoPlayer(_controller),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: IconButton(
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
                  color: Colors.black.withOpacity(.2),
                )),
          )
        ],
      ),
    );
  }
}