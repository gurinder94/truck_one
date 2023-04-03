import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';
import 'package:provider/provider.dart';

import 'Provider/view_question_answer_provider.dart';

class ViewQuestion extends StatelessWidget {
  int index;
  String image;
  String productName;
  String name;
  String customerId;
  late ViewQuestionAnswerProvider _viewQuestionAnswerProvider;

  ViewQuestion(
      this.index, this.image, this.productName, this.name, this.customerId);

  @override
  Widget build(BuildContext context) {
    _viewQuestionAnswerProvider = context.read<ViewQuestionAnswerProvider>();
    _viewQuestionAnswerProvider.getQuestionAnswer(customerId);

    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xFFEEEEEE),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 55,
          title: Text("View Question Answer"),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                color: APP_BAR_BG,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
          ),
          actions: [],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Hero(
                      tag: index,
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: CustomImageProfile(
                            image:  image,

                            height: 70,
                            width: 70,
                            boxFit: BoxFit.cover,
                          ),
                        ),
                      ),

                    ),


                    decoration: BoxDecoration(
                        color: APP_BG,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(5, 5)),
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 4,
                              offset: Offset(-5, -5))
                        ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  displayText("Product Name", productName, "Person Name", name),
                  SizedBox(
                    height: 10,
                  ),
                  Selector<ViewQuestionAnswerProvider, bool>(
                      selector: (_, provider) => provider.loading,
                      builder: (context, number2, child) {
                        print('Build num2');
                        return number2 == true
                            ? CircularProgressIndicator()
                            : Question(_viewQuestionAnswerProvider);
                      }),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: APP_BG,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(5, 5)),
                    BoxShadow(
                        color: Colors.white,
                        blurRadius: 4,
                        offset: Offset(-5, -5))
                  ]),
            ),
          ],
        ));
  }
}

Question(ViewQuestionAnswerProvider viewQuestionAnswerProvider) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.only(left: 8,right: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
      AppLocalizations.instance.text('Question'),
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 18),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          viewQuestionAnswerProvider.questionAnswerModel.data!.question
              .toString(),
          style:TextStyle(  color: Colors.black, fontSize: 16),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          AppLocalizations.instance.text('Answer'),
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),

        ),
        SizedBox(
          height: 6,
        ),
        Text(
          viewQuestionAnswerProvider.questionAnswerModel.data!.answer
              .toString(),
          style:TextStyle(  color: Colors.black, fontSize: 14),
        )
      ],
    ),
  );
}

displayText(String name, String value, String name2, String value2) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
             AppLocalizations.instance.text(name),
                style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  '$value',
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 14,
                  ),
                ),
              )
            ],
          )),
      SizedBox(
        width: 10,
      ),
      Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.instance.text(name2),
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '$value2',
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14,
                ),
              )
            ],
          )),


    ],
  );
}
