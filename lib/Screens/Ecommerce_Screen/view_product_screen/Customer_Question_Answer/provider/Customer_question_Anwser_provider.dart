import 'package:flutter/material.dart';
import '../../../../../ApiCall/api_Call.dart';
import '../../../../../Model/E_commerce_Model/question_answer_model.dart';

class CustomerQuestionAnwserProvider extends ChangeNotifier
{
  bool    questionLoder = false;
  QuestionAnswerModel ?questionAnswerModel;
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
     var  message = e.toString().replaceAll('Exception:', '');
      //
      // print(e.toString());
      // notifyListeners();
    }
  }



}