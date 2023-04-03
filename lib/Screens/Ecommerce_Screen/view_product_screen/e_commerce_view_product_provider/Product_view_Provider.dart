import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/product_view_model.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/question_answer_model.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/seller_rating_model.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/similar_product_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/e_commerce_Product_List/Provider/ecommerce_product_list_provider.dart';
import 'package:provider/provider.dart';

import '../../../../Model/ChatModel/CreateSingleConversationModel.dart';
import '../../../../Model/profanity_filter.dart';
import '../../../ChatScreen/chat_home_Page.dart';
import '../../../ChatScreen/provider/chat_home_provider.dart';

class ProductViewProvider extends ChangeNotifier {
  bool loading = true;
  bool questionLoder = true;
  bool sellerLoder = true;
  bool similarLoder = true;
  String? categoryId;

  String? id;
  late SimilarProduct similarProduct;
  String? message;

  late ProductView productView;
  late QuestionAnswerModel questionAnswerModel;
  late SellerRatingModel sellerRatingModel;
  late ProductListProvider productListProvider;
  late ResponseModel responseModel;
  final filter = ProfanityFilter();
  late SingleConversationChatListModel  _singleConversationChatListModel;
  getProductView(String value) async {
    var getId = await getUserId();
    Map<String, String> map = {"_id": value, "userId": getId};

    print(map);
    loading = true;
notifyListeners();
    try {
      productView = await hitProductViewApi(map);
      getQuestionAnswer(productView.data!.id.toString(),
          productView.data!.createdById.toString());
      getSimilarProduct(productView.data!.id.toString(),
          productView.data!.categoryId.toString());
      getSellerRating(productView.data!.createdById.toString());


    } on Exception catch (e) {
      print("hh");
      message = e.toString().replaceAll('Exception:', '');
      //
      // print(e.toString());
      // notifyListeners();
    }
  }

  setCategory(
    String categoryId,
    String id,
  ) {
    this.categoryId = categoryId;
    this.id = id;
  }

  getQuestionAnswer(String value, String sellId) async {
    Map<String, String> map = {"productId": value, 'sellerId': sellId};

    print(map);
    questionLoder = true;

    try {
      questionAnswerModel = await hitQuestionAnswerApi(map);

      questionLoder = false;
      notifyListeners();
    } on Exception catch (e) {

      questionLoder = false;
      notifyListeners();
      message = e.toString().replaceAll('Exception:', '');
      //
      // print(e.toString());
      // notifyListeners();
    }
  }

  getSellerRating(String sellId) async {
    Map<String, String> map = {'sellerId': sellId};

    print(map);
    sellerLoder = true;

    try {
      sellerRatingModel = await hitSellerRatingApi(map);

      sellerLoder = false;
      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      print("hh");
      message = e.toString().replaceAll('Exception:', '');
      //
      // print(e.toString());
      // notifyListeners();
    }
  }

  hitQuestion(String productid, String question, String sellerId,
      String productname) async {
    var userId = await getUserId();
    var userName = await getNameInfo();
    var questionCustomer = filter.censor(question.toString());
    Map<String, String> map = {
      "customerId": userId,
      "productId": productid,
      "question": questionCustomer,
      "sellerId": sellerId,
      "userName": userName,
      "userId": userId,
      "productName": productname,
    };

    print(map);

    notifyListeners();

    try {
      responseModel = await hitQuestionApi(map);
      showMessage(responseModel.message.toString());
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
  }


  getSimilarProduct(String productId, String categoryId) async {
    var userId = await getUserId();
    Map<String, String> map = {
      "categoryId": categoryId,
      "productId": productId
    };

    print(map);
    similarLoder = true;

    try {
      similarProduct = await hitSimilarProductApi(map);
      print(similarProduct.data!.length);

      notifyListeners();
      similarLoder = false;
    } on Exception catch (e) {

      message = e.toString().replaceAll('Exception:', '');
      //
      print(e.toString());
      notifyListeners();
    }
  }




  Future<void> addChatList(String sellerId, String sellerName, var sellerimage, BuildContext context) async {

    var uId = await getUserId();
    var roleName=await getRoleInfo();


    Map<String, dynamic> map={
      "image": sellerimage,
      "loggedInUser":uId,
      "membersArr": [sellerId ],
      "name": sellerName,
      "nowTime":   DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(DateTime.now().toUtc()),
      "roleTitle": roleName.toString().toUpperCase(),
      "type": "SELLER"
    };
    print(map);
    try {
      _singleConversationChatListModel = await hitCreateConversationApi(map);
      // chatHomeProvider.addChatConversation(_SingleConversationChatListModel.data!.conversation_id.toString(), _SingleConversationChatListModel.data!.image.toString(), _SingleConversationChatListModel.data!.lastMessages==null?[]:_SingleConversationChatListModel.data!.lastMessages, _SingleConversationChatListModel.data!.name.toString(), _SingleConversationChatListModel.data!.type.toString(), _SingleConversationChatListModel.data!.unReadMsg);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  create: (_) => ChatHomeProvider(), child: ChatHomePage(2))));
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');

      notifyListeners();
    }
  }


}
