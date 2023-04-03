import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/comments_model.dart';
import 'package:my_truck_dot_one/Screens/BottomMenu/bottom_menu.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/home_page_list_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';

import 'package:provider/provider.dart';
import 'CommentComponent/comment_send.dart';
import 'CommentComponent/orginal_comment_item.dart';
import 'Provider/comments_provider.dart';
import 'Provider/recomments_provider.dart';


class CommentPage extends StatefulWidget {
  String postId;
  String commentId;
  bool isMyPost;
  CommentPage(this.postId, this.commentId, this.isMyPost );

  @override
  _CommentPageState createState() => _CommentPageState(postId,commentId);
}

class _CommentPageState extends State<CommentPage> {



  String postId;
  String commentId;
  CommentItemModel? data;
late CommentsProvider _provider;
  ScrollController scrollController = ScrollController();
  int page = 1;
  var reply;

  _CommentPageState(this.postId, this.commentId );
@override
  void initState() {
    // TODO: implement initState
  _provider = context.read<CommentsProvider>();
  _provider.setContext(context);
getComments(1,false);
  }
  @override
  Widget build(BuildContext context) {

    _provider.setPostId(postId);
    addScrollListener(context);
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              getHomeList( context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        centerTitle: false,
        title:  Text(
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
                      ? Center(child: Text(AppLocalizations.instance.text("No comments found")))
                      : ListView.builder(
                          itemCount: noti.list.length,
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            return    ChangeNotifierProvider<CommentItemModel>.value(
                              value: noti.list[index],
                              child: GestureDetector(
                                child: orginalCommentItem(

                                  noti.list, postId,noti,index,
                                    replyClick: (value, commentid) {
                                      noti.setCheckRecomment(value);
                                      noti.setCommentId(commentid);

                                    },
                                  isMyPost:widget.isMyPost,

                                ),

                              ),
                            );
                          });
            },
          )),
          // reply == true
          //     ?
    // reply== true
          ChangeNotifierProvider(create: (_) => ReCommentsProvider(),
              child:CommentSend(postId,_provider,)),


          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Future<void> getComments(page, bool paginationLoder) async {
  var  getid= await getUserId();
    Future.delayed(Duration(milliseconds: 100), () {
      _provider.getComments({
        "postId": postId,
      "userId":getid,
        "page": page},paginationLoder);
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
    getComments(page,true);
  }

  getHomeList(BuildContext context) async {
  var  getid= await  getUserId();
  var  rolename= await getRoleInfo();
print(rolename);
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => BottomMenu(showCapitalize(rolename=="ENDUSER"?"user":rolename),0)),
          (Route<dynamic> route) => false).then((_) {

      // homeProvider.resetBookings();
    var  homeprovider= context.read<HomePageListProvider>();
    homeprovider.getPosts({
        "userId": getid,
        "count": 10,
        "page": 1,
        "searchText":''
        //"type": "Connections"
      }, false);
      // This block runs when you have come back to the 1st Page from 2nd.

    });
  }
}
