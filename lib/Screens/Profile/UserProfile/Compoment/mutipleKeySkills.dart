import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/Provider/UserProfileProvider.dart';

class MutipleKeySkill extends StatefulWidget {
  UserProfileProvider userProfileProvider;

  MutipleKeySkill(this.userProfileProvider);



  @override
  _MutipleKeySkillState createState() => _MutipleKeySkillState(userProfileProvider);
}

class _MutipleKeySkillState extends State<MutipleKeySkill> {
  @override



  UserProfileProvider userProfileProvider;

  _MutipleKeySkillState(this.userProfileProvider);



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
        child: Column(
          children: [
            Text(
              ' Key Skills',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: Container(

                child: ListView.builder(
                    itemCount: userProfileProvider.skillModel.data!.length,
                    itemBuilder: (context, index) {
                      var key = userProfileProvider.skillModel.data![index].skill;
                      return Column(
                        children: [
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    width: 270,
                                    child: Text(
                                      userProfileProvider
                                          .skillModel.data![index].skill
                                          .toString(),
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Checkbox(
                                    value:   userProfileProvider.skillModel.data![index].isValue,
                                    onChanged: (val) {
                                      userProfileProvider.skillModel.data![index].isValue = val!;
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
                      userProfileProvider.skillarray=[];
                      userProfileProvider.skillId=[];
                      List.generate(
                          userProfileProvider.skillModel.data!.length,
                              (index) => {
                            if (userProfileProvider.skillModel.data![index].isValue == true)
                              {
                                userProfileProvider.skillarray.add(
                                    userProfileProvider.skillModel.data![index]
                                        .skill),
                                userProfileProvider.skillId.add(userProfileProvider.skillModel.data![index].id.toString()),
                              }
                          });

                      userProfileProvider.skillText.text =    userProfileProvider.skillarray.toString()
                          .replaceAll('[', '')
                          .replaceAll(']', '');

                      Navigator.pop(context);
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
                      Navigator.pop(context);
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


