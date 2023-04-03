import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/Provider/fliter_tabber_provider.dart';
import 'package:provider/src/provider.dart';

import '../../Fliter_component/heart_listener.dart';

class HeartAnimation extends StatefulWidget {
  @override
  _HeartAnimationState createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimation>
    with SingleTickerProviderStateMixin ,FavouriteListener{
  late Animation<double> animation;
  late Animation _colorAnimation;
  late Animation _sizeAnimation;
  late Animation _sizeAnimation1;
  late AnimationController animationController;
  late final Animation<double> curve;

  bool visibility = true,like = true;

  @override
  void initState() {
    super.initState();
    var _provider = context.read<FliterProvider>();
    _provider.setListener(this);
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    _sizeAnimation =
    Tween<double>(begin: 0, end: 200).animate(animationController)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });

    //
    // _sizeAnimation = Tween<double>(begin: 0.0, end: 100.0).animate(
    //     CurvedAnimation(parent: animationController, curve: Curves.bounceIn));

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        visibility = true;
      }
      if (status == AnimationStatus.completed) {
        visibility = false;
        animationController.reverse();
      }
    });
  }
  void dispose()
  {
    animationController.stop();//do i need to call it as well?
    animationController.dispose();
    super.dispose();// and does it matter if i dispose the controller before this line or after this line.
  }

  @override
  // Widget build(BuildContext context) {
  //   return AnimatedBuilder(
  //       animation: animationController,
  //       builder: (BuildContext context, _) {
  //         return GestureDetector(
  //           // child: Icon(
  //           //   Icons.favorite,
  //           //   size: _sizeAnimation.value,
  //           //   color: _colorAnimation.value,
  //           // ),
  //           child: visibility
  //               ? Icon(
  //                   visibility ? Icons.favorite : Icons.favorite,
  //                   color: visibility
  //                       ? Colors.red.withOpacity(.7)
  //                       : Colors.grey.withOpacity(.7),
  //                   size: _sizeAnimation.value,
  //                 )
  //               : SizedBox(),
  //           onTap: () {
  //             // if (checkValue == true) {
  //             //   setState(() {
  //             //     checkValue = false;
  //             //     animationController.reverse();
  //             //   });
  //             // } else {
  //             //   setState(() {
  //             //     checkValue = true;
  //             //     animationController.forward();
  //             //
  //             //
  //             //   });
  //           },
  //         );
  //       });
  // }
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: visibility
            ? Icon(
          like ? Icons.favorite : Icons.favorite,
          color: like ? Colors.red.withOpacity(.7) : Colors.redAccent.withOpacity(.7),
          size:_sizeAnimation.value,
        )
            : SizedBox()
    );
  }
  @override
  void FavouriteEventHit() {
    like = true;
    setState(() {});
    animationController.reverse();

  }

  @override
  void UnFavouriteEventHit() {
    // TODO: implement UnFavouriteEventHit
    like = false;
    setState(() {});
    animationController.forward();
  }
}
