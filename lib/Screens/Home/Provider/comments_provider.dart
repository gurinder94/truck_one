import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/comments_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';

import 'package:my_truck_dot_one/Model/NetworkModel/response_comment_model.dart';

import '../../../Model/profanity_filter.dart';

class CommentsProvider extends ChangeNotifier {
  late BuildContext context;
  bool loading = false, postComment = false;
  late String postId;
  String? commentId;
  String? replyName;
  bool? check = false;
  bool paginationLoding = false;
  late CommentItemModel data;
  String image = '';

  setContext(BuildContext context) {
    this.context = context;
  }

  final filter = ProfanityFilter();
  String message = '';
  CommentsModel _postModel = CommentsModel();

  CommentsModel get postModel => _postModel;
  ResponseCommentModel? commentModel;

  List<CommentItemModel> _list = [];

  List<CommentItemModel> get list => _list;

  CommentItemModel Comment = CommentItemModel();

  getComments(Map<String, dynamic> map, bool paginationLoader) async {
    if (paginationLoader == false) {
      loading = true;
      notifyListeners();
    } else {
      paginationLoding = true;
      notifyListeners();
    }

    print(map);
    try {
      _postModel = await hitGetComments(map);
      _list.addAll(_postModel.data!);
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
    loading = false;
    getUserImage();
  }

  void resetBookings() {
    _list = [];
  }

  refreshList() {
    list;
    notifyListeners();
  }

  postCommnet(
    Map<String, dynamic> map,
    String txt,
    CommentsProvider provider,
  ) async {
    postComment = true;
    notifyListeners();
    print(map);
    var name = await getNameInfo();
    var getid = await getUserId();
    var image = await getprofileInfo();
    String cleanString = filter.censor(txt);

    try {
      var res = await hitPostComment(map);
      var parseData = json.decode(res.body);

      //Censor the string - returns a 'cleaned' string.

      //
      provider.list.insert(
          0,
          CommentItemModel(
            userId: getid,
            comment: cleanString,
            personName: name,
            designation: '',
            id: parseData['data']['_id'],
            image: image,
            role: '',
            isMyComment: true,
            totalReComment: 0,
          ));

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
    postComment = false;
  }

  void reloadComments() {
    getComments({"postId": postId}, false);
  }

  void setPostId(String postId) {
    this.postId = postId;
  }

  setCommentId(
    String commentId,
  ) {
    this.commentId = commentId;
  }

  setReplyName(String replyName) {
    this.replyName = replyName;
    notifyListeners();
  }

  setCheckRecomment(
    bool check,
  ) {
    this.check = check;
    print(check);
    notifyListeners();
  }

  setTotal(CommentItemModel data) {
    this.data = data;
  }

  getUserImage() async {
    image = await getprofileInfo() ?? '';
  }

  hitDeleteCommnet(
    Map<String, dynamic> map,
    CommentsProvider provider,
    int index,
  ) async {
    postComment = true;
    notifyListeners();
    print(map);
    try {
      ResponseModel res = await commentDelete(map);

      provider.list.removeAt(index);
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
}
