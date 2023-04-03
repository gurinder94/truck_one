import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/comments_model.dart';
import 'package:my_truck_dot_one/Screens/Home/CommentComponent/reply_recomment_item.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/comments_provider.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/recomments_provider.dart';
import 'package:provider/provider.dart';

class RecommentList extends StatelessWidget {
  late ReCommentsProvider _provider;
  // List<CommentItemModel> list;
  CommentItemModel data;
  String postId;
  var check = [];
int  index;

  CommentsProvider provider;

  RecommentList(this.data,this.postId, this. index, list, this.provider, );

  @override
  Widget build(BuildContext context) {
    _provider = context.read<ReCommentsProvider>();
    _provider.setPostId(postId);
    _provider.resetBookings();
    _provider.getComments({
      "commentId": provider.list[index].id,
      "postId": _provider.postId,
      "count": provider.list[index].totalReComment,
      "userId":provider.list[index].userId
    });
    return Consumer<ReCommentsProvider>(builder: (context, noti, child) {
      return noti.loading
          ? Center(child: CircularProgressIndicator.adaptive())
          : ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount:
          noti.list.length
          ,
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [

                  ReplyRecommectItem(noti.list, i, _provider, provider.list[index].id.toString(),
                      provider,data,noti.list[i],postId),
                ],
              ),
            );
          }
      );
    }

    );
  }
}