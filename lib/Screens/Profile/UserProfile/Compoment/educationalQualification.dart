import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/Provider/UserProfileProvider.dart';

class EducationalQualification extends StatefulWidget {
  UserProfileProvider userProfileProvider;

  EducationalQualification(this.userProfileProvider);

  @override
  _EducationalQualificationState createState() =>
      _EducationalQualificationState(userProfileProvider);
}

class _EducationalQualificationState extends State<EducationalQualification> {
  UserProfileProvider userProfileProvider;

  _EducationalQualificationState(this.userProfileProvider);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
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
                'Qualification',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                      itemCount: userProfileProvider.listQualification.length,
                      itemBuilder: (context, index) {
                        var key = userProfileProvider
                            .listQualification[index].qualification;
                        return Row(
                          children: [
                            Text(
                              userProfileProvider
                                  .listQualification[index].qualification
                                  .toString(),
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Checkbox(
                                value: userProfileProvider
                                    .listQualification[index].isvalue,
                                onChanged: (val) {
                                  userProfileProvider
                                      .listQualification[index].isvalue = val!;
                                  setState(() {});
                                })
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
                        userProfileProvider.qualificationarray = [];
                        userProfileProvider.qualificationId = [];
                        try {
                          List.generate(
                              userProfileProvider.listQualification.length,
                              (index) => {
                                    if (userProfileProvider
                                            .listQualification[index].isvalue ==
                                        true)
                                      {
                                        userProfileProvider.data =
                                            userProfileProvider
                                                .listQualification[index]
                                                .qualification!,
                                        userProfileProvider.qualificationarray
                                            .add(userProfileProvider
                                                .listQualification[index]
                                                .qualification),
                                        userProfileProvider.qualificationId.add(
                                            userProfileProvider
                                                .listQualification[index].id
                                                .toString())
                                      }
                                    else
                                      {
                                        userProfileProvider.data = '',
                                      }
                                  });
                        } catch (e, s) {
                          print(s);
                        }
                        userProfileProvider.qualificationEditText.text =
                            userProfileProvider.qualificationarray
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', '');
                        print(userProfileProvider.data);
                        Navigator.of(context).pop(userProfileProvider.data);
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
