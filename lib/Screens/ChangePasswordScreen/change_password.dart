import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_truck_dot_one/Screens/SignUpScreen/Provider/SignUpUserProvider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:provider/provider.dart';
import '../../AppUtils/constants.dart';
import '../commanWidget/Custom_App_Bar_Widget.dart';
import '../commanWidget/comman_button_widget.dart';
import 'Provider/change_password_provider.dart';

class ChangePassword extends StatelessWidget {
  late ChangePasswordProvider _changePasswordProvider;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var loader = Provider.of<ChangePasswordProvider>(context);
    _changePasswordProvider = context.read<ChangePasswordProvider>();

    return  CustomAppBarWidget(
        title: AppLocalizations.instance.text('Change Password'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        floatingActionWidget: SizedBox(),
        actions: SizedBox(),
        child:  Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding:  EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 110,),
                InputTextField(
                    child: TextFormField(
                  controller: _changePasswordProvider.oldPassword,
                  obscureText: !loader.obscureText1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      child: Icon(
                        // Based on passwordVisible state choose the icon
                        !loader.obscureText1
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onTap: () => loader.ShowVisibleOldPassword(),
                    ),
                    hintText: AppLocalizations.instance.text("Old Password"),
                    hintStyle: TextStyle(fontSize: 17),
                    prefixIcon: Icon(Icons.lock),
                  ),
                      validator: (value) {
                        if (value!.trim().length == 0) {
                          return 'Please enter old password';
                        }  else {
                          return null  ;
                        }
                      },
                )),
                SizedBox(
                  height: 30,
                ),
                InputTextField(
                    child: TextFormField(
                  controller: _changePasswordProvider.newPassword,
                  obscureText: !loader.obscureText2,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      child: Icon(
                        // Based on passwordVisible state choose the icon
                        !loader.obscureText2
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onTap: () => loader.ShowVisiblePassword(),
                    ),
                    hintText:AppLocalizations.instance.text("New Password"),
                    hintStyle: TextStyle(fontSize: 17),
                    prefixIcon: Icon(Icons.lock),
                  ),
                      validator: (value) {
                        if (value!.trim().length == 0) {
                          return 'Please enter password';
                        } else if (validateStructure(value) == false) {
                          var message =
                              "Password should be of 6 letters, Contain at least one \n Capital  letter, Alphanumeric a-z,0-9 One special \n character";
                          return message;
                        } else {
                          return null  ;
                        }
                      },

                )),
                SizedBox(
                  height: 30,
                ),
                InputTextField(
                    child: TextFormField(
                  controller: _changePasswordProvider.confirmPassword,
                  obscureText: !loader.obscureText3,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      child: Icon(
                        // Based on passwordVisible state choose the icon
                        !loader.obscureText3
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onTap: () => loader.ShowVisibleConfirmPassword(),
                    ),
                    hintText:AppLocalizations.instance.text("Confirm Password"),
                    hintStyle: TextStyle(fontSize: 17),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value!.trim().length == 0) {
                      return 'Please enter password';
                    } else if (_changePasswordProvider.newPassword.text !=
                        value) {
                      return 'Password not match';
                    } else {
                      return null;
                    }
                  },
                )),
                SizedBox(
                  height: 30,
                ),


          CommanButtonWidget(
            title:AppLocalizations.instance.text('Change Password'),
            buttonColor:PrimaryColor ,
            titleColor:APP_BG ,
            onDoneFuction: () async {
              if (_formKey.currentState!.validate()) {
                _changePasswordProvider.changePassword(context);
              }
            },
            loder: loader.loading,
          )
              ],
            ),
          ),
        )
        )
            );
  }
}
