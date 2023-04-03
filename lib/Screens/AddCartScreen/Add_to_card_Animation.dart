import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Listeners/add_to_cart_listeners.dart';
import 'package:my_truck_dot_one/Screens/PricingScreen/Provider/Pricing_provider.dart';

class AddCartAnimation extends StatefulWidget {
  PriceProvider provider;
  int itemCount;

  AddCartAnimation(this.provider, this.itemCount, {Key? key}) : super(key: key);

  @override
  State<AddCartAnimation> createState() => _AddCartAnimationState();
}

class _AddCartAnimationState extends State<AddCartAnimation>
    with AddToCartListener, SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  bool visibility = false, like = true;

  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.provider.setListener(this);

    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0, end: 30).animate(controller);
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
    return visibility == false
        ?widget.itemCount == 0
        ? SizedBox()
        : Container(
            width: 25,
            height: 25,
            margin: EdgeInsets.only(top: 0),
            child:  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffc32c37),
                        border: Border.all(color: Colors.white, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Center(
                        child: Text(
                          widget.itemCount.toString(),
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                    ),
                  ))
        : Container(
            width: animation.value,
            height: animation.value,
            margin: EdgeInsets.only(top: 0),
            child: Container(
              width: animation.value,
              height: animation.value,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffc32c37),
                  border: Border.all(color: Colors.white, width: 1)),
              child: Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Center(
                  child: widget.itemCount == 0
                      ? SizedBox()
                      : Text(
                          widget.itemCount.toString(),
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                ),
              ),
            ));
  }

  @override
  void AddToCartItem() {
    like = false;
    setState(() {});
    controller.forward();
  }
}
