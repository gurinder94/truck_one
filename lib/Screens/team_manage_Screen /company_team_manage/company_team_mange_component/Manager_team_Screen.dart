import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/JobList/CompanyJob/Component/PDFViewerFromUrl.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/OutsideButton.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_rich_text.dart';
import 'package:provider/provider.dart';
import '../../../../AppUtils/UserInfo.dart';
import '../../../Language_Screen/application_localizations.dart';
import '../../Provider/_invite_member_provider.dart';
import '../Provider/team_manger_provider.dart';

class ManageTeam extends StatelessWidget {
  ManagerTeamProvider managerTeamProvider;

  ManageTeam(this.managerTeamProvider);

  List<String> documentName = [];
  int pagee = 1;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ManagerTeamProvider>(builder: (_, proData, __) {
        if (proData.loading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (proData.CompanyManageList.length == 0)
          return Center(
              child: Text(AppLocalizations.instance.text('No Record Found')));
        else
          return ListView.builder(
              itemCount: proData.CompanyManageList.length,
              controller: proData.scrollController,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                capitalize(proData
                                    .CompanyManageList[index].personName
                                    .toString()),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),

                            // checkButtonCondation(proData, index, context),
                            proData.CompanyManageList[index].accessLevel ==
                                    "DRIVER"
                                ? proData.inviteStatus != "Accepted"
                                    ? SizedBox()
                                    : OutsideButton(
                                        Icon: GestureDetector(
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onTap: () {
                                          proData.paginationLoder = false;
                                          delete(
                                              context,
                                              proData.CompanyManageList[index]
                                                  .driverId
                                                  .toString(),
                                              index,
                                              proData);
                                        },
                                      ))
                                : SizedBox(),

                            proData.CompanyManageList[index].isAccepted ==
                                    "decline"
                                ? GestureDetector(
                                    onTap: () async {
                                      proData.paginationLoder = false;
                                      var getId = await getUserId();
                                      var companyId = await getCompanyId();
                                      var roleName = await getRoleInfo();
                                      proData.pagee = 1;
                                      proData.sendInviteMember({
                                        "accessLevel": proData.valueItemSelected
                                            .toString()
                                            .toUpperCase(),
                                        "companyId":
                                            companyId == '' ? getId : companyId,
                                        "constName": proData
                                                    .valueItemSelected ==
                                                "Driver"
                                            ? 'NOOFDRIVERS'
                                            : proData.valueItemSelected == "HR"
                                                ? 'NOOFHR'
                                                : "NOOFDISPATCHER",
                                        "createdById": getId,
                                        "email": proData
                                            .CompanyManageList[index].email,
                                        "lastName": proData
                                            .CompanyManageList[index].lastName,
                                        "firstName": proData
                                            .CompanyManageList[index].firstName,
                                        "mobileNumber": proData
                                            .CompanyManageList[index]
                                            .mobileNumber,
                                        "planTitle": "TRIPPLAN",
                                        "roleTitle":
                                            roleName.toString().toUpperCase()
                                      });
                                    },
                                    child: Icon(
                                      Icons.outgoing_mail,
                                      weight: 10,
                                      size: 30,
                                    ))
                                : proData.CompanyManageList[index].isAccepted ==
                                        "pending"
                                    ? GestureDetector(
                                        onTap: () async {
                                          proData.pagee = 1;
                                          proData.paginationLoder = false;
                                          proData.hitDeleteByCompany(proData
                                              .CompanyManageList[index].email
                                              .toString());
                                        },
                                        child: Icon(
                                          Icons.cancel_outlined,
                                          weight: 10,
                                          size: 30,
                                        ))
                                    : SizedBox()
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: CommonRichText(
                              richText1:
                                  AppLocalizations.instance.text('Email'),
                              style1: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  height: 1.4,
                                  color: Colors.black),
                              richText2:
                                  '\n${proData.CompanyManageList[index].email.toString()}',
                              style2: TextStyle(fontWeight: FontWeight.normal),
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 1,
                                child: CommonRichText(
                                  richText1: AppLocalizations.instance
                                      .text('Phone Number'),
                                  style1: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      height: 1.4,
                                      color: Colors.black),
                                  richText2:
                                      '\n${proData.CompanyManageList[index].mobileNumber.toString()}',
                                  style2:
                                      TextStyle(fontWeight: FontWeight.normal),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: CommonRichText(
                              richText1:
                                  AppLocalizations.instance.text('Access'),
                              style1: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  height: 1.4,
                                  color: Colors.black),
                              richText2:
                                  '\n${proData.CompanyManageList[index].accessLevel.toString()}',
                              style2: TextStyle(fontWeight: FontWeight.normal),
                            )),
                            proData.valueItemSelected != "Accepted"
                                ? SizedBox()
                                : Expanded(
                                    child: CommonRichText(
                                    richText1: AppLocalizations.instance
                                        .text('Joining Date'),
                                    style1: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        height: 1.4,
                                        color: Colors.black),
                                    richText2: proData.CompanyManageList[index]
                                                .dateOfJoining ==
                                            null
                                        ? '\n'
                                        : '\n${formatterDate(proData.CompanyManageList[index].dateOfJoining)}',
                                    style2: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  )),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        for (int i = 0;
                            i <
                                proData
                                    .CompanyManageList[index].documents!.length;
                            i++)
                          GestureDetector(
                            child: Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  proData.CompanyManageList[index].documents![i]
                                              .name ==
                                          null
                                      ? ''
                                      : proData.CompanyManageList[index]
                                          .documents![i].name
                                          .toString(),
                                  style: TextStyle(color: PrimaryColor),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PDFViewerFromUrl(
                                            url: document_Pdf_URl +
                                                proData.CompanyManageList[index]
                                                    .documents![i].fileName
                                                    .toString(),
                                            title: proData
                                                .CompanyManageList[index]
                                                .documents![i]
                                                .name
                                                .toString(),
                                          )));
                            },
                          ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(5, 5)),
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 4,
                              offset: Offset(-5, -5))
                        ]),
                  ),
                );
              });
      }),
    );
  }
}

getCovert(String value) {
  DateTime dt = DateTime.parse(value); // 2020-01-02 03:04:05.000

  String formattedDate = DateFormat('yyyy-MM-dd').format(dt);

  return formattedDate;
}

delete(BuildContext context, String driverId, int index,
    ManagerTeamProvider proData) {
  return DialogUtils.showMyDialog(
    context,
    onDoneFunction: () async {
      proData.hitDeleteCompanyManageTeam(
        driverId,
        index,
        proData,
      );
      Navigator.of(context).pop();
    },
    oncancelFunction: () => Navigator.pop(context),
    title: 'Manage Team !',
    alertTitle: 'Manage Team Remove Message',
    btnText: "Yes",
  );
}
