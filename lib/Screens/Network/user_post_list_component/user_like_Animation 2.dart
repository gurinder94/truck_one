import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/user_detail_model.dart';
import 'package:my_truck_dot_one/Screens/Network/like_listener.dart';
import 'package:provider/src/provider.dart';

class UserPostLikeAnimation extends StatefulWidget {

  PostDatum provider;
  UserPostLikeAnimation(
 this.provider,
  );

  @override
  _UserPostLikeAnimationState createState() =>
      _UserPostLikeAnimationState();
}

class _UserPostLikeAnimationState extends State<UserPostLikeAnimation>
    with  LikeListener, SingleTickerProviderStateMixin {
  late UserDetail _provider;
  late AnimationController controller;
  late Animation animation;
  bool visibility = false, like = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _provider = context.read<UserDetail>();
  widget.provider.setListener(this);
;    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0, end: 100).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
    controller.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        visibility = true;
      }
      if (status == AnimationStatus.completed) {
        visibility = false;
        controller.reverse();
       }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: visibility
            ? Icon(
                like ? Icons.thumb_up_sharp : Icons.thumb_down_alt_rounded,
                color: like
                    ? Colors.blue.withOpacity(.7)
                    : Colors.redAccent.withOpacity(.7),
                size: animation.value,
              )
            : SizedBox());
  }

  @override
  void DislikeEventHit() {
    // TODO: implement DislikeEventHit
    like = false;
    setState(() {});
    controller.forward();
  }

  @override
  void LikeEventHit() {
    // TODO: implement LikeEventHit
    like = true;
    setState(() {});
    controller.forward();
  }

}
