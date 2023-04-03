import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../AppUtils/constants.dart';
import '../../../../Language_Screen/application_localizations.dart';
import '../../../../commanWidget/commanField_widget.dart';

class AddCustomerQuestion extends StatelessWidget {
  AddCustomerQuestion({Key? key}) : super(key: key);

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
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: InputTextField(
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
                ),
                Expanded(
                  child: GestureDetector(
                    child: Center(
                      child: Container(

                        width: 70,
                        height: 40,

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
                        // productViewProvider.hitQuestion(
                        //     productViewProvider.productView.data!.id.toString(),
                        //     questionText.text,
                        //     productViewProvider.productView.data!.createdById
                        //         .toString(),
                        //     productViewProvider.productView.data!.productName
                        //         .toString());
                        questionText.text = "";
                      }
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Center(
                      child: Container(

                        width: 70,
                        height: 40,

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
                        // productViewProvider.hitQuestion(
                        //     productViewProvider.productView.data!.id.toString(),
                        //     questionText.text,
                        //     productViewProvider.productView.data!.createdById
                        //         .toString(),
                        //     productViewProvider.productView.data!.productName
                        //         .toString());
                        questionText.text = "";
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),

          ],
        ),
      ),
    );
  }
}
