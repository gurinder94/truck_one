import 'dart:async';

import 'package:flutter/material.dart';

class SearchButton extends StatefulWidget {
  Function onTextChange;

  @override
  State<SearchButton> createState() => _SearchButtonState(onTextChange);

  SearchButton({required this.onTextChange});
}

class _SearchButtonState extends State<SearchButton> {
  double _width = 0.0;
  TextEditingController _controller = TextEditingController();
  Function onTextChange;

  _SearchButtonState(this.onTextChange);

  Timer? _debounce;
  String searchText = '';

  void dispose() {
    // TODO: implement dispose
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 350,
      height: 70,
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search...",
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white),
        ),
        style: TextStyle(color: Colors.white, fontSize: 16.0),
        onChanged: (val) {
          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce = Timer(const Duration(milliseconds: 500), () {
            if (this.searchText != val) {
              onTextChange(val);
            } else {}

            this.searchText = val;
          });
        },
      ),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }
}
