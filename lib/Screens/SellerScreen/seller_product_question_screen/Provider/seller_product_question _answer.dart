import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/seller_question_answer_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';

class SellerProductQuestionProvider extends ChangeNotifier {
  bool loading = true;
  bool paginationLoder=false;
  bool questionLoading = true;
  String? message;
  late SellerQuestionAnswerModel questionAnswerModel;
  late ResponseModel _responseModel;
  List<Datum> questionList = [];

  getQuestionAnswer(String value, String? search, int pagee, bool pagination) async {
    var getid = await getUserId();
    var companyId= await getCompanyId();
    Map<String, dynamic> map = {
      "isAnswered": value,
      "page": pagee,
      "searchText": search,
      "sellerId":companyId==""? getid:companyId,
    };

    print(map);

    if(pagination==false)
   {
     questionList=[];
     loading = true;
   }
    else
      paginationLoder=true;
    notifyListeners();

    try {
      questionAnswerModel = await SellerQuestionAnswerApi(map);

      questionList.addAll(questionAnswerModel.data!);

      loading = false;
      paginationLoder=false;
      notifyListeners();
    } on Exception catch (e) {
      print("hh");
      message = e.toString().replaceAll('Exception:', '');
      print(message);
      // print(e.toString());
      // notifyListeners();

    }
    loading = false;
    paginationLoder=false;
  }

  resetQuestionList() {
    questionList = [];
  }

  getDeleteQuestionAnswer(
      String id,
      SellerProductQuestionProvider sellerProductQuestionProvider,
      int index) async {
    Map<String, dynamic> map = {
      "id": id,
    };

    print(map);
    questionLoading = true;

    try {
      _responseModel = await SellerQyestionDeleteApi(map);

      sellerProductQuestionProvider.questionList.removeAt(index);

      questionLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      questionLoading = false;
      message = e.toString().replaceAll('Exception:', '');
      print(message);
      // print(e.toString());
      // notifyListeners();

    }
  }
}
