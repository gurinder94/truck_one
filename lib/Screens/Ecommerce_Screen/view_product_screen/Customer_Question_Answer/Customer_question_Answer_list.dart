import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/view_product_screen/Customer_Question_Answer/provider/Customer_question_Anwser_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Custom_App_Bar_Widget.dart';
import 'package:provider/provider.dart';

import '../../../../Model/E_commerce_Model/question_answer_model.dart';

class CustomerQuestionAnswerList extends StatelessWidget {
  String productId, sellerId;
  late CustomerQuestionAnwserProvider _customerQuestionAnwserProvider;

  CustomerQuestionAnswerList(this.productId, this.sellerId);

  @override
  Widget build(BuildContext context) {
    return CustomAppBarWidget(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: AppLocalizations.instance.text("Customer Question"),
        actions: SizedBox(),
        child: FutureBuilder(
          future: Provider.of<CustomerQuestionAnwserProvider>(context,
                  listen: false)
              .getQuestionAnswer(productId, sellerId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('error${snapshot.error}'));
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return Consumer<CustomerQuestionAnwserProvider>(
                  builder: (context, proData, child) => Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.14,
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount:
                                    proData.questionAnswerModel!.data!.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 10),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          question(proData.questionAnswerModel!,
                                              index),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          answer(proData.questionAnswerModel!,
                                              index),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFFD9D8D8),
                                              offset: Offset(5.0, 5.0),
                                              blurRadius: 7,
                                            ),
                                            BoxShadow(
                                              color:
                                                  Colors.white.withOpacity(.4),
                                              offset: Offset(-5.0, -5.0),
                                              blurRadius: 10,
                                            ),
                                          ]),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ));
            } else
              return Center(child: CircularProgressIndicator.adaptive());
          },
        ),
        floatingActionWidget: SizedBox());
  }

  question(QuestionAnswerModel questionAnswerModel, int index) {
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Text("Q : "),
        Text(questionAnswerModel.data![index].question.toString())
      ],
    );
  }

  answer(QuestionAnswerModel questionAnswerModel, int index) {
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Text("A : "),
        Expanded(
            child: Text(questionAnswerModel.data![index].answer.toString()))
      ],
    );
  }
}
