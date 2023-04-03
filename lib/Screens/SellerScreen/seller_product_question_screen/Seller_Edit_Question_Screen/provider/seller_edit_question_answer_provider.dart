import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';

import '../../../../../Model/profanity_filter.dart';

class EditQuestionAnswerProvider extends ChangeNotifier {
  bool loading = false;
  late ResponseModel _responseModel;
  String? message;
  TextEditingController EditAnswerText = TextEditingController();
  final filter = ProfanityFilter();

  getEditQuestionAnswer(
      String? customerId, BuildContext context, String receiver) async {
    var getid = await getUserId();
    var companyId= await getCompanyId();
    var userName = await getNameInfo();
    Map<String, dynamic> map = {
      "answer": filter.censor(EditAnswerText.text),
      "answeredById": companyId==""? getid:companyId,
      "_id": customerId,
      "userName": userName,
      "userId": getid,
      "receiver": receiver,
    };

    print(map);
    loading = true;

    try {
      ResponseModel res = await AnsweredBySellerApi(map);
      Navigator.pop(navigatorKey.currentState!.context);
      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      print("hh");
      message = e.toString().replaceAll('Exception:', '');
      print(message);
      // print(e.toString());
      // notifyListeners();

    }
  }
}

