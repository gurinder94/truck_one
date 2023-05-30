import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/Provider/UserProfileProvider.dart';

class MutipleKeySkill extends StatefulWidget {
  UserProfileProvider userProfileProvider;

  MutipleKeySkill(this.userProfileProvider);

  @override
  _MutipleKeySkillState createState() =>
      _MutipleKeySkillState(userProfileProvider);
}

class _MutipleKeySkillState extends State<MutipleKeySkill> {
  @override
  UserProfileProvider userProfileProvider;

  _MutipleKeySkillState(this.userProfileProvider);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userProfileProvider.skill = '';
    setState(() {});
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
        child: Column(
          children: [
            Text(
              ' Key Skills',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: userProfileProvider.listSkill.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    width: 270,
                                    child: Text(
                                      userProfileProvider.listSkill[index].skill
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Checkbox(
                                    value: userProfileProvider
                                        .listSkill[index].isValue,
                                    onChanged: (val) {
                                      userProfileProvider
                                          .listSkill[index].isValue = val!;
                                      setState(() {});
                                    })
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black.withOpacity(0.2),
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      userProfileProvider.skillarray = [];
                      userProfileProvider.skillId = [];
                      List.generate(
                          userProfileProvider.listSkill.length,
                          (index) => {
                                if (userProfileProvider
                                        .listSkill[index].isValue ==
                                    true)
                                  {
                                    print(userProfileProvider
                                        .listSkill[index].skill),
                                    if (userProfileProvider
                                            .listSkill[index].skill
                                            .toString() ==
                                        "Others")
                                      {
                                        userProfileProvider.skill =
                                            userProfileProvider
                                                .listSkill[index].skill
                                                .toString()
                                      },
                                    userProfileProvider.skillarray.add(
                                        userProfileProvider
                                            .listSkill[index].skill),
                                    userProfileProvider.skillId.add(
                                        userProfileProvider.listSkill[index].id
                                            .toString()),
                                  }
                              });
                      userProfileProvider.skillText.text = userProfileProvider
                          .skillarray
                          .toString()
                          .replaceAll('[', '')
                          .replaceAll(']', '');

                      Navigator.of(context).pop(userProfileProvider.skill);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Text(
                      'Cancel',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
