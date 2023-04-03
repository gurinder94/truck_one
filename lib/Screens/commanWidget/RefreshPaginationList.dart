
import 'package:flutter/material.dart';

class RefreshPaginationList extends StatefulWidget {
  Function listItem, refreshList, swipeList;
  int totalItems;
  bool refreshLoader = false, swipeLoader = false;

  RefreshPaginationList(
      {required this.listItem,
        required this.refreshList,
        required this.swipeList,
        required this.totalItems,
        required this.refreshLoader,
        required this.swipeLoader});

  @override
  // ignore: no_logic_in_create_state
  State<RefreshPaginationList> createState() => _RefreshPaginationListState(
      listItem, refreshList, swipeList, totalItems, refreshLoader, swipeLoader);
}

class _RefreshPaginationListState extends State<RefreshPaginationList> {
  late ScrollController _controller;
  Function listItem, refreshList, swipeList;
  int totalItems = 0;
  bool refreshLoader = false, swipeLoader = false;

  _RefreshPaginationListState(this.listItem, this.refreshList, this.swipeList,
      this.totalItems, this.refreshLoader, this.swipeLoader);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ScrollController();
    setScrollListener();
  }

  void setScrollListener() {
    _controller.addListener(() {
      if (_controller.position.pixels <= -200) {
        refreshLoader = true;
        swipeLoader = false;
        refreshList();
        setState(() {});
      }
      if (_controller.position.maxScrollExtent == _controller.position.pixels) {
        swipeLoader = true;
        refreshLoader = false;
        swipeList();
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        refreshLoader ? loaderWidget("Refresh...") : SizedBox(),
        Expanded(
          child: ListView.builder(
              itemCount: totalItems,
              itemBuilder: (context, index) => listItem(index)),
        ),
        swipeLoader ? loaderWidget("Wait...") : SizedBox(),
      ],
    );
  }

  loaderWidget(String text) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const LinearProgressIndicator(
          color: Colors.teal,
          minHeight: 50,
          backgroundColor: Colors.grey,
        ),
        Text(text)
      ],
    );
  }
}
