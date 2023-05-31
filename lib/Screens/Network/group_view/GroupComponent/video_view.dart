import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  String name;

  VideoView(this.name);

  @override
  _VideoVideState createState() => _VideoVideState(name);
}

class _VideoVideState extends State<VideoView> {

  late VideoPlayerController _controller;
  String name;

  _VideoVideState(this.name);

  bool load = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(Base_URL_video_ThumbNail + name);
    _controller = VideoPlayerController.network(Base_URL_video_ThumbNail + name)
      ..initialize().then((val) {
        setState(() {
          load = false;
        });
      });
  }
  void dispose()
  {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
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
