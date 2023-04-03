import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/SellerScreen/seller_product_question_screen/Seller_Edit_Question_Screen/provider/seller_edit_question_answer_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:provider/src/provider.dart';

class EditQuestionAnswer extends StatelessWidget {
  late EditQuestionAnswerProvider _editQuestionAnswerProvider;
  String? question;
  String? customerId;
  String? customerName;

  EditQuestionAnswer(this.question, this.customerId, this.customerName);

  @override
  Widget build(BuildContext context) {
    _editQuestionAnswerProvider = context.read<EditQuestionAnswerProvider>();

    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xFFEEEEEE),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 55,
          title: Text(AppLocalizations.instance.text('Edit Question Answer')),
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
                  SizedBox(
                    height: 10,
                  ),
                  Question(_editQuestionAnswerProvider, question!, customerId!,
                      context, customerName ?? ''),
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

Question(
  EditQuestionAnswerProvider editQuestionAnswerProvider,
  String question,
  String customerId,
  BuildContext context,
  String customerName,
) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(
      AppLocalizations.instance.text('Question'),
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    ),
    SizedBox(
      height: 10,
    ),
    Text(
      question.toString(),
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ),
    SizedBox(
      height: 13,
    ),
    Text(AppLocalizations.instance.text('Answer'),
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        )),
    SizedBox(
      height: 15,
    ),
    InputTextField(
        child: TextFormField(
      controller: editQuestionAnswerProvider.EditAnswerText,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(150),
      ],
      textInputAction: TextInputAction.next,
      maxLines: 10,
      minLines: 1,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Please enter your answer",
        contentPadding: EdgeInsets.all(15),
        hintStyle: TextStyle(fontSize: 17),
      ),
      validator: (value) {
        return null;
      },
    )),
    SizedBox(
      height: 20,
    ),
    Row(
      children: [
        Expanded(
          child: GestureDetector(
            child: Container(
              width: double.infinity,
              height: 40,
              child: Center(
                  child: Text(
                AppLocalizations.instance.text('Cancel'),
                style: TextStyle(color: Colors.white),
              )),
              decoration: BoxDecoration(
                  color: PrimaryColor,
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
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              editQuestionAnswerProvider.getEditQuestionAnswer(
                  customerId, context, customerName);
            },
            child: Container(
              width: double.infinity,
              height: 40,
              child: Center(
                  child: Text(
                AppLocalizations.instance.text('Submit'),
                style: TextStyle(color: Colors.white),
              )),
              decoration: BoxDecoration(
                  color: PrimaryColor,
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
          ),
        ),
      ],
    )
  ]);
}
