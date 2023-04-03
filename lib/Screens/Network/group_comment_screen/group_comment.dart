import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/comments_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_model.dart';
import 'package:my_truck_dot_one/Screens/Home/CommentComponent/comment_send.dart';
import 'package:my_truck_dot_one/Screens/Home/CommentComponent/orginal_comment_item.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/comments_provider.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/recomments_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

class GroupCommentPage extends StatefulWidget {
  PostDatum list;

  GroupCommentPage(this.list);

  @override
  _GroupCommentPage createState() => _GroupCommentPage(list);
}

class _GroupCommentPage extends State<GroupCommentPage> {
  PostDatum list;

  _GroupCommentPage(this.list);

  late CommentsProvider _provider;
  CommentItemModel? data;
  ScrollController scrollController = ScrollController();
  int page = 1;
  var reply;

  @override
  void initState() {
    // TODO: implement initState
    _provider = context.read<CommentsProvider>();
    _provider.setContext(context);
    getComments(1, false);
    addScrollListener(context);

    _provider.setPostId(list.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        centerTitle: false,
        title:Text(
          AppLocalizations.instance.text("Comments")    ,
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: Consumer<CommentsProvider>(
            builder: (context, noti, child) {
              return noti.loading
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : noti.list.length == 0
                      ? Center(child: Text('No comments found'))
                      : ListView.builder(
                          itemCount: noti.list.length,
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            return ChangeNotifierProvider<
                                CommentItemModel>.value(
                              value: noti.list[index],
                              child: orginalCommentItem(
                                noti.list,
                                list.id.toString(),
                                noti,
                                index,
                                replyClick: (value, commentid) {
                                  noti.setCheckRecomment(value);
                                  noti.setCommentId(commentid);
                                }, isMyPost: list.isMyPost!,
                              ),
                            );
                          });
            },
          )),
          ChangeNotifierProvider(
              create: (_) => ReCommentsProvider(),
              child: CommentSend(
                list.id!,
                _provider,
              )),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  addScrollListener(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        page = page + 1;
        if (_provider.postModel.data!.length == 0) {
          print(page);
        } else {
          print(page);
          pagnationList(context, page);
        }
        // Perform event when user reach at the end of list (e.g. do Api call)

      }
    });
  }

  pagnationList(
    BuildContext context,
    page,
  ) {
    getComments(page, true);
  }

  getComments(page, bool paginationLoder) async {
    var getid = await getUserId();

    Future.delayed(Duration(milliseconds: 100), () {
      _provider.getComments(
          {"postId": list.id, "userId": getid, "page": page}, paginationLoder);
    });
  }
}
