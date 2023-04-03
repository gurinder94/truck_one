import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/LoginScreen/Provider/term_condition_provider.dart';
import 'package:provider/provider.dart';

class TermsCondition extends StatefulWidget {
  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
  var checkBoxValue = false;

  late TermConditionProvider _termConditionProvider;

  @override
  Widget build(BuildContext context) {
    _termConditionProvider = context.read<TermConditionProvider>();
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.all(23),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
      title: Center(child: Text("Warning UGC")),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Divider(),
            ListTile(
              title: Text(
                  '[User-Generated CONTENT POLICY (UGC) IF you are going to use this app then acccepts these policies.'),
            ),
            Divider(),
            ListTile(
              leading: Container(
                width: 10,
                height: 20,
                decoration: BoxDecoration(
                    color: Color(0xFF044a87), shape: BoxShape.circle),
              ),
              title: Text('I will not use any abusive language.'),
            ),
            Divider(),
            ListTile(
              leading: Container(
                width: 10,
                height: 20,
                decoration: BoxDecoration(
                    color: Color(0xFF044a87), shape: BoxShape.circle),
              ),
              title: Text('I will respect other users.'),
            ),
            Divider(),
            ListTile(
              leading: Container(
                width: 10,
                height: 20,
                decoration: BoxDecoration(
                    color: Color(0xFF044a87), shape: BoxShape.circle),
              ),
              title: Text(
                  'I will not share any sexual content of any kind of abusive content'),
            ),
            Divider(),
            ListTile(
              leading: Container(
                width: 10,
                height: 20,
                decoration: BoxDecoration(
                    color: Color(0xFF044a87), shape: BoxShape.circle),
              ),
              title: Text('I will not harass anyone'),
            ),
            Divider(),
            ListTile(
              leading: Container(
                width: 10,
                height: 20,
                decoration: BoxDecoration(
                    color: Color(0xFF044a87), shape: BoxShape.circle),
              ),
              title: Text('I will not send any hacking or cheats links.'),
            ),
            Divider(),
            ListTile(
              leading: Container(
                width: 10,
                height: 20,
                child: Checkbox(
                    value: checkBoxValue,
                    activeColor: PrimaryColor,
                    onChanged: (newValue) {
                      print(newValue);
                      checkBoxValue = newValue!;

                      setState(() {});
                    }),
              ),
              title: Text('Accept Terms & Conditions'),
            ),
            Divider(),
            ListTile(
              title: Text(
                  'If you accepts the above  conditions then use the app otherwise uninstall and leave.'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Selector<TermConditionProvider, bool>(
            selector: (_, provider) => provider.loading,
            builder: (context, loading, child) {
              return   loading?SizedBox(
                  width: 35,
                  height: 35,
                  child: Center(child: CircularProgressIndicator())):   IgnorePointer(
                ignoring: checkBoxValue==false?true:false,
                child: InkWell(
                  highlightColor: Colors.white,
                  child: Text("OK",style: TextStyle(
                    color:checkBoxValue==true? PrimaryColor:Colors.grey.shade500,
                  )),
                  onTap: () async {
                    _termConditionProvider.hitTermCondition(context);
                  },
                ),
              );
            }),

      ],
    );
  }
}
