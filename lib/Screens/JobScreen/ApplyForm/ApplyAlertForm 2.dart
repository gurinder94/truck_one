import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/ApplyForm/Provider/applyJobProvider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';

import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customLoder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../commanWidget/comman_button_widget.dart';
import 'document_display_page.dart';

showApplyJobDialog(BuildContext context, String? id, userId, roleName,
    String companyId, String title) {
  late JobApplyProvider _jobApplyProvider;
  _jobApplyProvider = Provider.of<JobApplyProvider>(context, listen: false);

  roleName.toString().toUpperCase() == "DRIVER"
      ? _jobApplyProvider.hitUserProfileDetails(context)
      : SizedBox();
  _jobApplyProvider.pdfTextEditing.text = "";
  _jobApplyProvider.descriptionTextEditing.text = "";
  _jobApplyProvider.uploadDocument = [];
  File? files;
  PlatformFile? _platformFile;

  _jobApplyProvider.setContext(context);
  _jobApplyProvider.check = false;
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: Color(0xFFEEEEEE),
    title: Text(AppLocalizations.instance.text("Attach Resume")),
    content: Container(
        width: 700,
        height: 300,
        child: SingleChildScrollView(
          child: Consumer<JobApplyProvider>(builder: (_, proData, __) {
            return Column(children: [
              Text(
                  "Resume is  the most important document recruiters look for.Recruiters generally do not look at profiles without resumes."),
              SizedBox(
                height: 20,
              ),
              proData.check == false
                  ? proData.loading == true
                      ? CustomLoder()
                      : InputTextField(
                          child: TextFormField(
                            controller: _jobApplyProvider.pdfTextEditing,
                            readOnly: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(' ')
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Resume',
                              prefixIcon: Icon(Icons.upload_file),
                            ),
                            onTap: () async {
                              if (Platform.isAndroid) {
                                _jobApplyProvider.getFile();

                                return;
                              }
                              final serviceStatus =
                                  await Permission.storage.isGranted;

                              bool isCameraOn =
                                  serviceStatus == ServiceStatus.enabled;
                              final status = await Permission.storage.request();
                              if (status == PermissionStatus.granted) {
                                print('Permission Granted');
                                _jobApplyProvider.getFile();
                              } else if (status == PermissionStatus.denied) {
                                print('Permission denied');
                              } else if (status ==
                                  PermissionStatus.permanentlyDenied) {
                                print('Permission Permanently Denied');
                                await openAppSettings();
                              }

                              // if (await Permission.storage.request().isGranted) {
                              //   _jobApplyProvider.getFile();
                              // }
                            },
                          ),
                        )
                  : InputTextField(
                      child: TextFormField(
                        controller: _jobApplyProvider.descriptionTextEditing,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
                        minLines: 1,
                        //Normal textInputField will be displayed
                        maxLines: 10,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(2000),
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Description',
                          prefixIcon: Icon(Icons.description),
                        ),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              proData.check == false
                  ? GestureDetector(
                      onTap: () => _jobApplyProvider.checkValue(true),
                      child: RichText(
                        text: TextSpan(
                            text:
                                'If you do not have a resume document, you may write your brief professional profile ',
                            style: TextStyle(
                                color: Colors.black,
                                wordSpacing: 1,
                                height: 1.2),
                            children: [
                              TextSpan(
                                text: "Click Here",
                                style: TextStyle(color: PrimaryColor),
                              )
                            ]),
                      ),
                    )
                  : GestureDetector(
                      onTap: () => _jobApplyProvider.checkValue(false),
                      child: RichText(
                        text: TextSpan(
                            text:
                                'If you do not have a resume document, you may write your brief professional profile ',
                            style: TextStyle(
                                color: Colors.black,
                                wordSpacing: 1,
                                height: 1.2),
                            children: [
                              TextSpan(
                                text: "Click Here",
                                style: TextStyle(color: PrimaryColor),
                              )
                            ]),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),

              roleName.toString().toUpperCase() == "DRIVER"
                  ? DocumentDisplayPage()
                  : SizedBox(), //C
              Row(
                children: [
                  Expanded(
                    child: CommanButtonWidget(
                      title: AppLocalizations.instance.text("Cancel"),
                      buttonColor: PrimaryColor,
                      titleColor: APP_BG,
                      onDoneFuction: () {
                        Navigator.pop(context);
                      },
                      loder: false,
                    ),
                  ),
                  Expanded(
                      child: CommanButtonWidget(
                    title: AppLocalizations.instance.text("Update"),
                    buttonColor: PrimaryColor,
                    titleColor: APP_BG,
                    onDoneFuction: () {
                      Navigator.pop(context);
                      _jobApplyProvider.uploadDocument
                          .add(_jobApplyProvider.driverMap);
                      _jobApplyProvider.uploadDocument
                          .add(_jobApplyProvider.addtionDocumentMap);
                      _jobApplyProvider.uploadDocument
                          .add(_jobApplyProvider.medicalCertificateMap);
                      _jobApplyProvider.hitApplyJob(
                        id,
                        userId,
                        companyId,
                        title,
                      );
                    },
                    loder: proData.applyLoder,
                  )),
                ],
              ),
            ]);
          }),
        )),
  );

// show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// child: SingleChildScrollView(
// child: Selector<JobApplyProvider, bool>(
// selector: (_, provider) => provider.check,
// builder: (context, paginationLoading, child) {
// return Column(children: [
// Text(
// "Resume is  the most important document recruiters look for.Recruiters generally do not look at profiles without resumes."),
// SizedBox(
// height: 20,
// ),
// paginationLoading == false
// ? InputTextField(
// child: TextFormField(
// controller: _jobApplyProvider.pdfTextEditing,
// readOnly: true,
// autovalidateMode:
// AutovalidateMode.onUserInteraction,
// inputFormatters: [
// FilteringTextInputFormatter.deny(' ')
// ],
// decoration: InputDecoration(
// border: InputBorder.none,
// hintText: 'Resume',
// prefixIcon: Icon(Icons.upload_file),
// ),
// onTap: () async {
// var status = await Permission.storage.status;
// print(await Permission.contacts
//     .request()
//     .isGranted);
// if (await Permission.storage
//     .request()
//     .isGranted) {
// _jobApplyProvider.getFile();
// }
// },
// ),
// )
//     : InputTextField(
// child: TextFormField(
// controller:
// _jobApplyProvider.descriptionTextEditing,
// keyboardType: TextInputType.multiline,
// textInputAction: TextInputAction.done,
// minLines: 1,
// //Normal textInputField will be displayed
// maxLines: 10,
// autovalidateMode:
// AutovalidateMode.onUserInteraction,
// inputFormatters: <TextInputFormatter>[
// LengthLimitingTextInputFormatter(2000),
// ],
// decoration: InputDecoration(
// border: InputBorder.none,
// hintText: 'Description',
// prefixIcon: Icon(Icons.description),
// ),
// ),
// ),
// SizedBox(
// height: 20,
// ),
// paginationLoading == false
// ? GestureDetector(
// onTap: () => _jobApplyProvider.checkValue(true),
// child: RichText(
// text: TextSpan(
// text:
// 'If you do not have a resume document, you may write your brief professional profile ',
// style: TextStyle(
// color: Colors.black,
// wordSpacing: 1,
// height: 1.2),
// children: [
// TextSpan(
// text: "Click Here",
// style: TextStyle(color: PrimaryColor),
// )
// ]),
// ),
// )
//     : GestureDetector(
// onTap: () => _jobApplyProvider.checkValue(false),
// child: RichText(
// text: TextSpan(
// text:
// 'If you do not have a resume document, you may write your brief professional profile ',
// style: TextStyle(
// color: Colors.black,
// wordSpacing: 1,
// height: 1.2),
// children: [
// TextSpan(
// text: "Click Here",
// style: TextStyle(color: PrimaryColor),
// )
// ]),
// ),
// ),
// SizedBox(
// height: 20,
// ),
//
// roleName.toString().toUpperCase() == "DRIVER"
// ? DocumentDisplayPage()
//     : SizedBox(), //C
// Row(
// children: [
// Expanded(
// child: CommanButtonWidget(
// title: "Cancel",
// buttonColor: PrimaryColor,
// titleColor: APP_BG,
// onDoneFuction: () {
// Navigator.pop(context);
// },
// loder: false,
// ),
// ),
// Selector<JobApplyProvider, bool>(
// selector: (_, provider) => provider.loading,
// builder: (context, loder, child) {
// return Expanded(
// child: CommanButtonWidget(
// title: "Update",
// buttonColor: PrimaryColor,
// titleColor: APP_BG,
// onDoneFuction: () {
// Navigator.pop(context);
// _jobApplyProvider.uploadDocument
//     .add(_jobApplyProvider.driverMap);
// _jobApplyProvider.uploadDocument
//     .add(_jobApplyProvider.addtionDocumentMap);
// _jobApplyProvider.uploadDocument
//     .add(_jobApplyProvider.medicalCertificateMap);
// _jobApplyProvider.hitApplyJob(
// id,
// userId,
// companyId,
// title,
// );
// },
// loder:loder,
// ),
// );
// }
// ),
// ],
// ),
// ]);
// }),
// )),
