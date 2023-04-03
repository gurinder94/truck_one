import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'Provider/applyJobProvider.dart';

class DocumentDisplayPage extends StatefulWidget {
  @override
  State<DocumentDisplayPage> createState() => _DocumentDisplayPageState();
}

class _DocumentDisplayPageState extends State<DocumentDisplayPage> {
  late JobApplyProvider _jobApplyProvider;

  @override
  Widget build(BuildContext context) {
    _jobApplyProvider = context.watch<JobApplyProvider>();
    return _jobApplyProvider.documentDriverList.length == 0
        ? SizedBox()
        : Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: List<Widget>.generate(
                _jobApplyProvider.documentDriverList.length, (int index) {
              return GestureDetector(
                  child: _jobApplyProvider.documentDriverList[index].name ==
                          "Resume"
                      ? SizedBox()
                      : ChoiceChip(
                          selected:
                              _jobApplyProvider.documentDriverList[index].check,
                          label: Text(_jobApplyProvider
                              .documentDriverList[index].name
                              .toString()),
                          onSelected: (bool selected) {
                            setState(() {
                              if (_jobApplyProvider
                                      .documentDriverList[index].check ==
                                  false) {
                                _jobApplyProvider
                                    .documentDriverList[index].check = true;
                              } else {
                                _jobApplyProvider
                                    .documentDriverList[index].check = false;
                              }
                            });

                            if (_jobApplyProvider
                                    .documentDriverList[index].check ==
                                true) {
                              switch (_jobApplyProvider
                                  .documentDriverList[index].name) {
                                case ("Additional document"):
                                  _jobApplyProvider.addtionDocumentMap['name'] =
                                      _jobApplyProvider
                                          .documentDriverList[index].name
                                          .toString();
                                  _jobApplyProvider
                                          .addtionDocumentMap['fileName'] =
                                      _jobApplyProvider
                                          .documentDriverList[index].fileName;
                                  _jobApplyProvider
                                          .medicalCertificateMap['_id'] =
                                      _jobApplyProvider
                                          .documentDriverList[index].id;

                                  break;

                                case ("DMV Medical Certificate"):
                                  _jobApplyProvider
                                          .medicalCertificateMap['name'] =
                                      _jobApplyProvider
                                          .documentDriverList[index].name
                                          .toString();
                                  _jobApplyProvider
                                          .medicalCertificateMap['fileName'] =
                                      _jobApplyProvider
                                          .documentDriverList[index].fileName;
                                  _jobApplyProvider
                                          .medicalCertificateMap['_id'] =
                                      _jobApplyProvider
                                          .documentDriverList[index].id;
                                  break;

                                case ("Driving License"):
                                  _jobApplyProvider.driverMap['name'] =
                                      _jobApplyProvider
                                          .documentDriverList[index].name
                                          .toString();
                                  _jobApplyProvider.driverMap['fileName'] =
                                      _jobApplyProvider
                                          .documentDriverList[index].fileName;
                                  _jobApplyProvider.driverMap['_id'] =
                                      _jobApplyProvider
                                          .documentDriverList[index].id;

                                  break;
                              }
                            } else {
                              switch (_jobApplyProvider
                                  .documentDriverList[index].name) {
                                case ("Additional document"):
                                  _jobApplyProvider.uploadDocument.remove(
                                      _jobApplyProvider.addtionDocumentMap);

                                  break;

                                case ("DMV Medical Certificate"):
                                  _jobApplyProvider.uploadDocument.remove(
                                      _jobApplyProvider.medicalCertificateMap);
                                  break;

                                case ("Driving License"):
                                  _jobApplyProvider.uploadDocument
                                      .remove(_jobApplyProvider.driverMap);
                                  break;
                              }
                            }
                          },
                        ));
            }),
          );
  }
}
