import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_model.dart';

import '../../Listener/group_like_listener.dart';
import '../Provider/group_provider.dart';

class GroupLikeAnimationComponent extends StatefulWidget {
  PostDatum postDatum;
   GroupLikeAnimationComponent(this.postDatum,  {Key? key}) : super(key: key);

  @override
  State<GroupLikeAnimationComponent> createState() => _GroupLikeAnimationComponentState();
}

class _GroupLikeAnimationComponentState extends State<GroupLikeAnimationComponent>
    with  GroupLikeDislikeListener, SingleTickerProviderStateMixin{

  late AnimationController controller;
  late Animation animation;
  bool visibility = false, like = true;
  void initState() {
    print("object");
    // TODO: implement initState
    super.initState();
     // _provider = context.read<GroupProvider>();
     widget.postDatum.setListener(this);
        controller = AnimationController(
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
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: visibility
              ? Icon(
            like ? Icons.thumb_up_sharp : Icons.thumb_down_alt_rounded,
            color: like ? Colors.blue.withOpacity(.7) : Colors.redAccent.withOpacity(.7),
            size: animation.value,
          )
              : SizedBox(),
        )
    );
  }

  @override
  void GroupDislikeHit() {
    // TODO: implement DislikeEventHit
    like = false;
    setState(() {});
    controller.forward();
  }

  @override
  void GroupLikeHit() {
    like = true;
    setState(() {});
    controller.forward();
  }
}
