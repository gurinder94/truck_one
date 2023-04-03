import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:provider/provider.dart';
import '../../../../../AppUtils/comman_validation.dart';
import '../../commanWidget/comman_button_widget.dart';
import '../provider/contact_us_provider.dart';
import 'contact_us_lower_part.dart';

class ContactForm extends StatefulWidget {
  ContactForm();

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var _contactProvider = context.read<ContactProvider>();
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          InputTextField(
              child: TextFormField(
            controller: _contactProvider.name,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(30),
            ],
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: AppLocalizations.instance.text("Enter name"),
              hintStyle: TextStyle(fontSize: 17),
              prefixIcon: Icon(
                Icons.person,
                size: 23,
              ),
            ),
            validator: (value) {
              if (value!.trim().length == 0) {
                return 'Please enter name';
              } else {
                return null;
              }
            },
          )),
          SizedBox(
            height: 20,
          ),
          InputTextField(
              child: TextFormField(
            controller: _contactProvider.email,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: AppLocalizations.instance.text("Enter email"),
              hintStyle: TextStyle(fontSize: 17),
              prefixIcon: Icon(
                Icons.mail,
                size: 20,
              ),
            ),
            validator: (value) => emailValidation(value),
          )),
          SizedBox(
            height: 20,
          ),
          InputTextField(
              child: Row(
            children: [
              SizedBox(width: 5),
              Text(
                "+1",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                    controller: _contactProvider.mobile,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.deny(' ')
                    ],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppLocalizations.instance
                            .text("Enter phone number"),
                        hintStyle: TextStyle(fontSize: 17),
                        prefixStyle: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: Colors.black.withOpacity(0.4))),
                    validator: (value) => mobileValidation(value!)),
              )
            ],
          )),
          SizedBox(
            height: 20,
          ),
          Text(
            AppLocalizations.instance.text("What is you query related to"),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 8,
          ),
          // Selector<ContactProvider, int>(
          //     selector: (_, provider) => provider.value,
          //     builder: (context, value, child) {
          //       return Column(children: [
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           children: [
          //             Row(
          //               children: [
          //                 Radio(
          //                   value: 1,
          //                   groupValue: value,
          //                   onChanged: (value) {
          //                     _contactProvider.setValue(value);
          //                   },
          //                 ),
          //                 Text(AppLocalizations.instance.text("Subscription Plan"))
          //               ],
          //             ),
          //             Row(
          //               children: [
          //                 Radio(
          //                   value: 2,
          //                   groupValue: value,
          //                   onChanged: (value) {
          //                     _contactProvider.setValue(value);
          //                   },
          //                 ),
          //                 Text(AppLocalizations.instance.text("Other"))
          //               ],
          //             ),
          //             SizedBox(
          //               height: 20,
          //             )
          //           ],
          //         ),
          //         value == 1
          //             ? ContactUsLowerPart(_contactProvider)
          //             : SizedBox(
          //                 height: 10,
          //               )
          //       ]);
          //     }),

          SizedBox(
            height: 10,
          ),
          InputTextField(
              child: TextFormField(
                  controller: _contactProvider.description,
                  minLines: 1,
                  maxLines: 10,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(2000),
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:
                        AppLocalizations.instance.text("Enter description"),
                    hintStyle: TextStyle(fontSize: 17),
                    prefixIcon: Icon(
                      Icons.description,
                      size: 20,
                    ),
                  ),
                  validator: (value) => descriptionValidation(value))),
          SizedBox(
            height: 40,
          ),
          Selector<ContactProvider, bool>(
              selector: (_, provider) => provider.loading,
              builder: (context, loder, child) {
                return CommanButtonWidget(
                  title: AppLocalizations.instance.text("Send Message"),
                  buttonColor: PrimaryColor,
                  titleColor: APP_BG,
                  onDoneFuction: () {
                    if (_formKey.currentState!.validate()) {
                      _contactProvider.hitcontactUsForm({
                        "companyName": _contactProvider.value == 1
                            ? _contactProvider.companyName.text
                            : '',
                        "description": _contactProvider.description.text,
                        "email": _contactProvider.email.text,
                        "name": _contactProvider.name.text,
                        "phone": _contactProvider.mobile.text,
                        "planOption": _contactProvider.value == 1
                            ? _contactProvider.userPlanList
                            : [],
                        "queryType": _contactProvider.value == 1
                            ? "SUBSCRIPTION PLAN"
                            : "OTHER"
                      }, context);
                    }
                  },
                  loder: loder,
                );
              }),
        ]),
      ),
    );
  }
}
