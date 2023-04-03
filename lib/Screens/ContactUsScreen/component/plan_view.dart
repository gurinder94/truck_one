import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import '../provider/contact_us_provider.dart';

class PlanScreen extends StatefulWidget {
  ContactProvider contactProvider;

  PlanScreen(this.contactProvider);

  @override
  _PlanScreenState createState() => _PlanScreenState(contactProvider);
}

class _PlanScreenState extends State<PlanScreen> {
   ContactProvider contactProvider;

  _PlanScreenState(this.contactProvider);

  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
            height: 300,
            width: 200,
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(children: [
              Text(
                'Plans',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Divider(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: ListView.builder(
                      itemCount: contactProvider.PlanList.length,
                      itemBuilder: (context, index) {
                        var key = contactProvider.PlanList[index];
                        return Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  showCapitalize(
                                  contactProvider.PlanList[index]),
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Spacer(),
                                Checkbox(
                                    value: contactProvider.mutiplePlan[key] ??
                                        false,
                                    onChanged: (val) {
                                      print(val);
                                      contactProvider.mutiplePlan[key] = val!;
                                      print(contactProvider.mutiplePlan[key]);
                                      setState(() {});
                                    })
                              ],
                            ),
                          ],
                        );
                      }),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Text(
                        'Ok',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        contactProvider.userPlanList=[];
                        List.generate(
                            contactProvider.PlanList.length,
                                (index) =>
                            {
                              if (contactProvider.mutiplePlan[
                              contactProvider.PlanList[index]] ==
                                  true)
                                {
                                  contactProvider.userPlanList
                                      .add(contactProvider.PlanList[index]),


                                }
                              else
                                {
                                  contactProvider.userPlanList
                                      .remove(contactProvider.PlanList[index]),
                                }
                            });
                        contactProvider.plan.text = contactProvider.userPlanList
                            .toString()
                            .replaceAll('[', '')
                            .replaceAll(']', '');
                        Navigator.pop(context);
                        print(contactProvider);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              )
            ])));
  }
}
