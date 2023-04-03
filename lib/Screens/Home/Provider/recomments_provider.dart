import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/comments_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/recomments_model.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/comments_provider.dart';

import '../../../Model/profanity_filter.dart';

class ReCommentsProvider extends ChangeNotifier {
  late BuildContext context;
  bool loading = false, postComment = false;
  late String postId;
  late String commentId;
  final filter = ProfanityFilter();

  setContext(BuildContext context) {
    this.context = context;
  }

  String message = '';
  ReCommentsListModel _postModel = ReCommentsListModel();
  ResponseModel _model = ResponseModel();
  List<RecommentModel> _list = [];

  List<RecommentModel> get list => _list;

  ResponseModel get model => _model;

  getComments(Map<String, dynamic> map) async {
    loading = true;
    print(map);
    var getId = await getUserId();
    map["userId"] = getId;
    notifyListeners();

    print(map);

    try {
      _postModel = await hitGetReComments(map);
      _list.addAll(_postModel.data!);
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message.toString());
      print(e.toString());
      notifyListeners();
    }
    loading = false;
  }

  void resetBookings() {
    _list = [];
  }

  postReCommnet(Map<String, dynamic> map, CommentsProvider provider,
      ReCommentsProvider rovider, String? mess) async {
    postComment = true;
    var getid = await getUserId();
    var name = await getNameInfo();
    var image = await getprofileInfo();
    notifyListeners();
    print(map);
    String cleanString = filter.censor(mess!);
    try {
      _model = await hitPostReComment(map);

      rovider.list.insert(
          0,
          RecommentModel(
            image: image,
            id: provider.commentId,
            personName: capitalize(name),
            comment: cleanString,
            userId: getid,
          ));

      provider.data.commentTotalCount(provider.data.totalReComment!.toInt());

      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
    postComment = false;
  }

  void reloadComments() {
    getComments({"postId": postId});
  }

  void setPostId(String postId) {
    this.postId = postId;
  }

  hitDeleteCommnet(
    Map<String, dynamic> map,
    ReCommentsProvider provider,
    int index,
    CommentsProvider commentsProvider,
    CommentItemModel data,
  ) async {
    postComment = true;
    notifyListeners();
    print(map);
    try {
      ResponseModel res = await commentDelete(map);
      Navigator.pop(navigatorKey.currentState!.context);

      data.reCommentTotalCount(1);
      // rovider.data.commentTotalCount(provider.data.totalReComment!.toInt());
      //

      postComment = false;
      notifyListeners();
      // reloadComments();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
  }

  void setRemoveList(int index) {
    list.removeAt(index);
    notifyListeners();
  }

  void updateRecommentList(
    int index,
    getId,
    String text,
    String nameCapitalize,
    image,
    String id,
  ) {
    list.insert(
        index,
        (RecommentModel(
            image: image,
            id: id,
            comment: text,
            isMyComment: true,
            personName: nameCapitalize,
            userId: getId)));
    notifyListeners();
  }
}
