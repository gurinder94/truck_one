import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';

import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';

import '../../../Language_Screen/application_localizations.dart';
import '../e_commerce_view_product_provider/Product_view_Provider.dart';

class CustomerQuestion extends StatefulWidget {
  ProductViewProvider productViewProvider;

  CustomerQuestion(this.productViewProvider);

  @override
  _CustomerQuestionState createState() =>
      _CustomerQuestionState(productViewProvider);
}

class _CustomerQuestionState extends State<CustomerQuestion> {
  ProductViewProvider productViewProvider;

  _CustomerQuestionState(this.productViewProvider);

  TextEditingController questionText = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                AppLocalizations.instance.text("Have a Question") + ' ?',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InputTextField(
                child: TextFormField(
              controller: questionText,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(150),
              ],
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "",
                hintStyle: TextStyle(fontSize: 17),
              ),
            )),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Center(
                child: Container(
                  width: 120,
                  height: 40,
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
                  decoration: BoxDecoration(
                      color: PrimaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
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
                  child: Center(
                      child: Text(
                    AppLocalizations.instance.text("Post"),
                    style: TextStyle(
                      color: Color(0xFFEEEEEE),
                      fontSize: 16,
                    ),
                  )),
                ),
              ),
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  productViewProvider.hitQuestion(
                      productViewProvider.productView.data!.id.toString(),
                      questionText.text,
                      productViewProvider.productView.data!.createdById
                          .toString(),
                      productViewProvider.productView.data!.productName
                          .toString());
                  questionText.text = "";
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
