import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/question_answer_model.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/view_product_screen/Customer_Question_Answer/provider/Customer_question_Anwser_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

import '../Customer_Question_Answer/Customer_question_Answer_list.dart';
import '../e_commerce_view_product_provider/Product_view_Provider.dart';

class CustomerAnswer extends StatelessWidget {
  ProductViewProvider productViewProvider;
  CustomerAnswer(this.productViewProvider);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 180,
          child: ListView.builder(
              itemCount: productViewProvider.questionAnswerModel.data!.length<2?productViewProvider.questionAnswerModel.data!.length:2,
physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return      productViewProvider.questionAnswerModel.data!.length==0?Center(child: Text(AppLocalizations.instance.text('No Record Found'))):Padding(
                  padding:  EdgeInsets.only(left:20,right: 20,top: 10,bottom: 10),
                  child: Container(


                    child: Column(

                      children: [
                        SizedBox(height: 10,),
                        question(productViewProvider.questionAnswerModel,index),
                        SizedBox(height: 10,),
                        answer(productViewProvider.questionAnswerModel,index),
                        SizedBox(height: 10,),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFD9D8D8),
                            offset: Offset(5.0, 5.0),
                            blurRadius: 7,
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(.4),
                            offset: Offset(-5.0, -5.0),
                            blurRadius: 10,
                          ),
                        ]),
                  ),
                );
              }),
        ),
       //
        productViewProvider.questionAnswerModel.data!.length>2? GestureDetector(
          child: Text("view more (${productViewProvider.questionAnswerModel.data!.length-2})",style: TextStyle(
           color: PrimaryColor,
           fontSize: 18,
           fontWeight: FontWeight.w800
       ),

          ),
          onTap: ()
          {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                      create: (_) => CustomerQuestionAnwserProvider(),
                      child: CustomerQuestionAnswerList(productViewProvider.productView.data!.id.toString(),
                          productViewProvider. productView.data!.createdById.toString()))));


          },
        )
      :SizedBox()],
    );
  }
}

question(QuestionAnswerModel questionAnswerModel, int index) {
  return Row(
    children: [
SizedBox(width: 20,),
      Text("Q : "), Text(questionAnswerModel.data![index].question.toString())
    ],
  );
}

answer(QuestionAnswerModel questionAnswerModel, int index) {
  return Row(
    children: [
      SizedBox(width:20,),
      Text("A : "), Expanded(child: Text(questionAnswerModel.data![index].answer.toString()))],
  );
}
