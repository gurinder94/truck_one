import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/comments_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/user_detail_model.dart';
import 'package:my_truck_dot_one/Screens/Home/CommentComponent/comment_send.dart';
import 'package:my_truck_dot_one/Screens/Home/CommentComponent/orginal_comment_item.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/comments_provider.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/recomments_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

class UserCommentPage extends StatefulWidget {
  PostDatum postData;

  UserCommentPage(this.postData);

  @override
  _UserCommentPageState createState() => _UserCommentPageState(postData);
}

class _UserCommentPageState extends State<UserCommentPage> {
  @override
  PostDatum postData;

  _UserCommentPageState(this.postData);

  ScrollController scrollController = ScrollController();

  late CommentsProvider _provider;
  CommentItemModel? data;
  var reply;
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    _provider = context.read<CommentsProvider>();
    _provider.setContext(context);
    getComments(1, false);
  }

  @override
  Widget build(BuildContext context) {
    _provider.setPostId(postData.id!);
    addScrollListener(context);
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
        title: Text(
          AppLocalizations.instance.text("Comments"),
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
                      ? Center(
                          child: Text(AppLocalizations.instance
                              .text("No comments found")))
                      : ListView.builder(
                          itemCount: noti.list.length,
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            return ChangeNotifierProvider<
                                CommentItemModel>.value(
                              value: noti.list[index],
                              child: GestureDetector(
                                child: orginalCommentItem(
                                  noti.list,
                                  noti.postId.toString(),
                                  noti,
                                  index,
                                  replyClick: (value, commentid) {
                                    noti.setCheckRecomment(value);
                                    noti.setCommentId(commentid);
                                  },
                                  isMyPost: postData.isMyPost!,
                                ),
                              ),
                            );
                          });
            },
          )),
          // reply == true
          //     ?
          // reply== true
          ChangeNotifierProvider(
              create: (_) => ReCommentsProvider(),
              child: CommentSend(
                postData.id.toString(),
                _provider,
              )),
          // ChangeNotifierProvider(create: (_) => ReCommentsProvider(),
          //     child:CommentSend(_provider.postId,_provider,postData)),

          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Future<void> getComments(int i, bool paginationLoader) async {
    var getid = await getUserId();
    Future.delayed(Duration(milliseconds: 100), () {
      _provider.getComments(
          {"postId": postData.id.toString(), "userId": getid, "page": i},
          paginationLoader);
    });
  }

  addScrollListener(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        page = page + 1;
        if (_provider.postModel.data!.length == 0) {
          print("hello");
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
}
