import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/view_question_answer_model.dart';

class ViewQuestionAnswerProvider extends ChangeNotifier {
  bool loading = true;

  String? message;
  late ViewQuestionAnswerModel questionAnswerModel;

  getQuestionAnswer(String id) async {
    Map<String, dynamic> map = {
      "_id": id,
    };



    loading = true;

    try {
      questionAnswerModel = await SellerViewQuestionAnswerApi(map);

      notifyListeners();
      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      print("hh");
      message = e.toString().replaceAll('Exception:', '');
      print(message);
      loading = false;
    }
  }
}
