import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/Debouncer.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/input_shape.dart';

class CommanSearchBar extends StatefulWidget {
  Function onTextChange;
  var IconName;
  CommanSearchBar({required this.onTextChange,this.IconName}) ;
  State<CommanSearchBar> createState() => _CommanSearchBarState();
}

class _CommanSearchBarState extends State<CommanSearchBar> {
  TextEditingController _controller = TextEditingController();

  Debouncer _debouncer = Debouncer();

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return InputShape(
      child: TextFormField(

        controller: _controller,
        onChanged: (val) {
      _debouncer.run(() {

        widget.onTextChange(val);
          // if (_debounce?.isActive ?? false) _debounce?.cancel();
          // _debounce = Timer(const Duration(milliseconds: 500), () {
          //   if (this.searchText != val) {
          //
          //   } else {}
          //
          //   this.searchText = val;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
            suffixIcon:widget.IconName ,
            hintText: 'Search', border: InputBorder.none),
      ),
    );
  }
}
