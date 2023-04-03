import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';

class AnimSearchBar extends StatefulWidget {
  Function onTextChange;

  @override
  _AnimSearchBarState createState() => _AnimSearchBarState(onTextChange);

  AnimSearchBar( {required this.onTextChange});
}

class _AnimSearchBarState extends State<AnimSearchBar> {
  double _width = 0.0;
  TextEditingController _controller = TextEditingController();
  Function onTextChange;
  Timer? _debounce;
  String searchText = '';

  _AnimSearchBarState(this.onTextChange);

  @override
  void dispose() {
    // TODO: implement dispose
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 6, top: 6),
        decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            boxShadow: [
              const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 1,
                  spreadRadius: 2,
                  offset: Offset(-5, -5)),
              BoxShadow(
                  color: APP_BAR_BG,
                  blurRadius: 1,
                  spreadRadius: 2,
                  offset: Offset(5, 5)),
            ],
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Row(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: _width,
              curve: Curves.easeOutQuad,
              padding: EdgeInsets.only(left: 5),
              child: TextFormField(

                controller: _controller,
                onChanged: (val) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    if (this.searchText != val) {
                      onTextChange(val);
                    } else {}

                    this.searchText = val;
                  });
                },
                decoration: InputDecoration(
                    hintText: 'search', border: InputBorder.none),
              ),
            ),
            IconButton(
                padding: EdgeInsets.all(13),
                constraints: BoxConstraints(),
                iconSize: 20,
                onPressed: () {
                  setState(() {
                    if (_width == MediaQuery.of(context).size.width*0.8) {
                      _width = 0;
                      if (_controller.text == '') {

                      }
                      else {
                        onTextChange('');
                        _controller.text = '';
                      }
                    } else {
                      _width =  MediaQuery.of(context).size.width*0.8;
                    }
                  });
                },
                icon: Icon(
                  _width == MediaQuery.of(context).size.width*0.8 ? Icons.cancel_outlined : Icons.search,
                  color: Colors.black.withOpacity(.7),
                )),
          ],
        ));
  }
}