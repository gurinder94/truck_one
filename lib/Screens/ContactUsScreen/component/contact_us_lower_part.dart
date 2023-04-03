import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_truck_dot_one/Screens/ContactUsScreen/component/plan_view.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import '../../../../../AppUtils/comman_validation.dart';
import '../provider/contact_us_provider.dart';


class ContactUsLowerPart extends StatelessWidget {
  ContactProvider contactProvider;

  ContactUsLowerPart(this.contactProvider);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        InputTextField(
            child: TextFormField(
              controller: contactProvider.companyName,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: AppLocalizations.instance.text("Enter company name"),
            hintStyle: TextStyle(fontSize: 17),
            prefixIcon: Icon(
          Icons.business,
                size: 20,
            ),
          ),
          validator: (value) =>companyNameValidation(value),
        )),
        SizedBox(
          height: 20,
        ),
        InputTextField(
            child: TextFormField(
              readOnly: true,
              controller: contactProvider.plan,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: AppLocalizations.instance.text("Select plan"),
            hintStyle: TextStyle(fontSize: 17),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 15,right: 10,top: 13),
              child: FaIcon(FontAwesomeIcons.dollarSign, size: 20,),
            ),
          ),
          validator: (value) {
            if (value!.trim().length == 0) {

              return 'Please select your plan';
            } else {
              return null;
            }
          },
              onTap: ()
              {
                showDialog(
                    context: context,
                    builder: (context) =>
                        PlanScreen(contactProvider));
              },
        )),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
