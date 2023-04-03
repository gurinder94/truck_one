import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/input_shape.dart';
import 'package:my_truck_dot_one/Screens/team_manage_Screen%20/Invite_member/invited_menber_drop_down.dart';

import 'package:provider/provider.dart';

import '../../../AppUtils/comman_validation.dart';
import '../../commanWidget/comman_button_widget.dart';
import '../Provider/_invite_member_provider.dart';

class InviteFriends extends StatelessWidget {
  late SendMemInviteProvider _provider;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _provider = context.read<SendMemInviteProvider>();
    _provider.setContext(context);
    var fNameController = TextEditingController();
    var lNameController = TextEditingController();
    var emailController = TextEditingController();
    var noController = TextEditingController();
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: APP_BAR_BG,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30))),
        title: Text(AppLocalizations.instance.text("Invite Members")),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(
                  Icons.person_add_alt_1_rounded,
                  size: 150,
                  color: Color(0xFFE0E0E0),
                ),
                Row(
                  children: [
                    Expanded(
                        child: InputShape(
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: fNameController,
                        maxLength: 80,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            counterText: '',
                            hintText: AppLocalizations.instance.text("First Name"),
                            border: InputBorder.none),
                        validator: (value) => firstNameValidation(value!),
                      ),
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: InputShape(
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: lNameController,
                        maxLength: 80,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            counterText: '',
                            hintText: AppLocalizations.instance.text("Last Name"),
                            border: InputBorder.none),
                        validator: (value) => lastNameValidation(value!),
                      ),
                    )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: InputShape(
                      child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: emailController,
                          maxLength: 150,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              counterText: '',
                              hintText:AppLocalizations.instance.text("Email"),
                              border: InputBorder.none),
                          validator: (value) => emailValidation(value!)),
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: InputShape(
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: noController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.deny(' ')
                        ],
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            counterText: '',
                            hintText: AppLocalizations.instance.text("Phone Number"),
                            border: InputBorder.none),
                        validator: (value) => mobileValidation(value!),
                      ),
                    )),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                InvitedMenberDropDownScreen(),
                SizedBox(
                  height: 30,
                ),
                Selector<SendMemInviteProvider, bool>(
                    selector: (_, provider) => provider.loading,
                    builder: (context, paginationLoading, child) {
                      return CommanButtonWidget(
                        title: AppLocalizations.instance.text('Invite'),
                        buttonColor: PrimaryColor,
                        titleColor: APP_BG,
                        onDoneFuction: () async {
                          var getId = await getUserId();
                          var companyId = await getCompanyId();
                          var roleName = await getRoleInfo();

                          if (_formKey.currentState!.validate()) {
                            if (_provider.valueItemSelected == null) {
                              showMessage("Please select access level");
                            } else
                              _provider.sendInviteMember({
                                "accessLevel": _provider.valueItemSelected
                                    .toString()
                                    .toUpperCase(),
                                "companyId":
                                    companyId == '' ? getId : companyId,
                                "constName":
                                    _provider.valueItemSelected == "Driver"
                                        ? 'NOOFDRIVERS'
                                        : _provider.valueItemSelected == "HR"
                                            ? 'NOOFHR'
                                            : "NOOFDISPATCHER",
                                "createdById": getId,
                                "email": emailController.text,
                                "lastName": lNameController.text,
                                "firstName": fNameController.text,
                                "mobileNumber": noController.text,
                                "planTitle": "TRIPPLAN",
                                "roleTitle": roleName.toString().toUpperCase()
                              });
                          }
                        },
                        loder: paginationLoading,
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
