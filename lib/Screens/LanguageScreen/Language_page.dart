import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../AppUtils/constants.dart';
import '../Language_Screen/language_Provider.dart';

class LanguagePage extends StatefulWidget {
  String language;

  LanguagePage(this.language, {Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  List mutipleRole = ['English', "Punjabi", "Spanish"];
  List languageValue = [false, false, false];
  var group1Value;
  late LanguageChangeNotifierProvider _languageProvider;

  @override
  void initState() {
    group1Value = widget.language == "english"
        ? 0
        : widget.language == "punjab"
            ? 1
            : 2;
  }

  Widget build(BuildContext context) {
    _languageProvider = context.read<LanguageChangeNotifierProvider>();
    _languageProvider.setBuildcontext(context);
    return Dialog(
      backgroundColor: Colors.white,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: 250,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Language',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Divider(
              color: Colors.black45,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: mutipleRole.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Container(
                        child: ListTile(
                            leading: Container(
                              width: 20,
                              child: RadioListTile(
                                value: index,
                                groupValue: group1Value,
                                onChanged: (value) {
                                  setState(() {
                                    group1Value = index;
                                  });
                                },
                              ),
                            ),
                            title: Text(showCapitalize(mutipleRole[index]))),
                      ),
                      onTap: () {
                        setState(() {
                          group1Value = index;
                        });
                      },
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Selector<LanguageChangeNotifierProvider, bool>(
                    selector: (_, provider) => provider.loading,
                    builder: (context, loading, child) {
                      return loading
                          ? CircularProgressIndicator()
                          : Container(
                              margin: EdgeInsets.all(10),
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                child: Text(
                                  'Done',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  switch (group1Value) {
                                    case 0:
                                      _languageProvider.changeLocale('en');
                                      break;
                                    case 1:
                                      _languageProvider.changeLocale('pa');
                                      break;
                                    case 2:
                                      _languageProvider.changeLocale('es');
                                      break;
                                  }
                                },
                              ),
                            );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
