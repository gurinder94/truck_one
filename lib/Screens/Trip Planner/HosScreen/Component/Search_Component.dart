import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddStoppageMap/Provider/route_add_marker_provider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:provider/provider.dart';

import '../../../commanWidget/input_shape.dart';

class SearchAppBar extends StatefulWidget {

  RouteMarkerProvider provider;
  int index;
  String txt;
  SearchAppBar(this.index, this.provider, this.txt);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {


  Timer? _debounce;
  String searchText = '';


  @override
  void dispose() {
    // TODO: implement dispose
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<RouteMarkerProvider, bool>(
        selector: (_, provider) =>
        provider.hosLoder
        ,
        builder: (context, paginationLoading, child) {
          return
            InputShape(
              child: TextFormField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(RegExp("[0-9.]")),

                  FilteringTextInputFormatter.deny(' ')
                ],
                controller: widget.provider.speedController,
                onChanged: (val) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    if (this.searchText != val) {
                      if (!paginationLoading) {
                        if(val=="0"||val=="00"||val=="000")
                          {

                          }
                        else
                          {
                            widget.provider.hitHos(val, widget.index);
                          }

                      }
                    } else {}

                    this.searchText = val;
                  });
                },
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: 'search', border: InputBorder.none),
              ),

            );
        }
    );
  }
}
