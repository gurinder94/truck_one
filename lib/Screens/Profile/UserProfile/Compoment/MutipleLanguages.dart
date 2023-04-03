import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/Provider/UserProfileProvider.dart';

class MutipleLanguage extends StatefulWidget {
  UserProfileProvider userProfileProvider;

  MutipleLanguage(this.userProfileProvider);

  @override
  _MutipleLanguageState createState() =>
      _MutipleLanguageState(userProfileProvider);
}

class _MutipleLanguageState extends State<MutipleLanguage> {
  _MutipleLanguageState(this.userProfileProvider);

  UserProfileProvider userProfileProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("hello");
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
              'Mutiple language',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                    itemCount: userProfileProvider.multiLanguageKeys.length,
                    itemBuilder: (context, index) {
                      var key = userProfileProvider.multiLanguageKeys[index];
                      return Row(
                        children: [
                          Text(
                            key.toString(),
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          Checkbox(
                              value: userProfileProvider.mutipleLanguage[key],
                              onChanged: (val) {
                                userProfileProvider.mutipleLanguage[key] = val!;
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      userProfileProvider.languagearray=[];
                      List.generate(
                          userProfileProvider.multiLanguageKeys.length,
                          (index) => {
                                if (userProfileProvider.mutipleLanguage[
                                        userProfileProvider
                                            .multiLanguageKeys[index]] ==
                                    true)
                                  userProfileProvider.languagearray.add(userProfileProvider
                                      .multiLanguageKeys[index])
                              });
                      userProfileProvider.languages.text =userProfileProvider.languagearray
                          .toString()
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
