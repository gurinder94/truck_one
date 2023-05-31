import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

import 'Provider/profile_view_provider.dart';

class SellerProfile extends StatelessWidget {
  late SellerProfileProvider _sellerProfileProvider;

  @override
  Widget build(BuildContext context) {
    _sellerProfileProvider = context.read<SellerProfileProvider>();
    _sellerProfileProvider.hitSellerProfile(context);
    return Scaffold(
        backgroundColor: APP_BG,
        body: SingleChildScrollView(
          child: Selector<SellerProfileProvider, bool>(
              selector: (_, provider) => provider.loading,
              builder: (context, paginationLoading, child) {
                return paginationLoading == true
                    ? Column(
                        children: [
                          SizedBox(
                            height: 200,
                          ),
                          Center(child: CircularProgressIndicator()),
                        ],
                      )
                    : Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                    )),
                                SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  AppLocalizations.instance.text('Profile'),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Spacer()
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Business Details",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            _sellerProfileProvider.sellerProfileModel.data!
                                        .sellerData!.legalEntity ==
                                    "no"
                                ? Text(
                                    "${"No"}, I manage my business as a sole proprietor or owner.",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600))
                                : Text(
                                    "${"Yes"}, My business is a legal entity",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)),
                            _sellerProfileProvider.sellerProfileModel.data!
                                        .sellerData!.legalEntity ==
                                    "no"
                                ? SizedBox()
                                : SizedBox(
                                    height: 8,
                                  ),
                            _sellerProfileProvider.sellerProfileModel.data!
                                        .sellerData!.legalEntity ==
                                    "no"
                                ? SizedBox()
                                : Text(
                                    _sellerProfileProvider.sellerProfileModel
                                        .data!.sellerData!.legalEntityOption
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400)),
                            // legalEntityOption
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _sellerProfileProvider.sellerProfileModel
                                              .data!.sellerData!.legalEntity ==
                                          "no"
                                      ? SizedBox()
                                      : Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                AppLocalizations.instance
                                                    .text('Company Name'),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    height: 1.4,
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 2),
                                                child: Text(
                                                  _sellerProfileProvider
                                                      .sellerProfileModel
                                                      .data!
                                                      .firstName
                                                      .toString(),
                                                  style: TextStyle(
                                                      height: 1.4,
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  _sellerProfileProvider.sellerProfileModel
                                              .data!.sellerData!.legalEntity ==
                                          "no"
                                      ? SizedBox()
                                      : SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                        ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.instance
                                              .text('First Name'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              height: 1.4,
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 2),
                                          child: Text(
                                            _sellerProfileProvider
                                                .sellerProfileModel
                                                .data!
                                                .firstName
                                                .toString(),
                                            style: TextStyle(
                                                height: 1.4,
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            displayText(
                                "Last Name",
                                _sellerProfileProvider
                                    .sellerProfileModel.data!.lastName
                                    .toString(),
                                "Email Address",
                                _sellerProfileProvider
                                    .sellerProfileModel.data!.email
                                    .toString(),
                                context),
                            Divider(),
                            dateDisplay(
                                "Phone Number",
                                _sellerProfileProvider
                                    .sellerProfileModel.data!.mobileNumber
                                    .toString(),
                                "Date of Birth / Incorporation",
                                _sellerProfileProvider
                                    .sellerProfileModel.data!.dateOfBirth,
                                context),
                            Divider(),
                            Consumer<SellerProfileProvider>(
                              builder: (BuildContext context, value,
                                      Widget? child) =>
                                  Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("SSN or ITIN",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                height: 1.4,
                                                color: Colors.black,
                                                fontSize: 18)),
                                        Row(
                                          children: [
                                            Text(
                                              !value.obscureText
                                                  ? _sellerProfileProvider
                                                  .sellerProfileModel
                                                  .data!
                                                  .sellerData!
                                                  .ssnNumber!.replaceAll(
                                                      RegExp(r'\d'), '*')
                                                  : _sellerProfileProvider
                                                      .sellerProfileModel
                                                      .data!
                                                      .sellerData!
                                                      .ssnNumber
                                                      .toString(),
                                              style: TextStyle(
                                                  height: 1.4,
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                value.obscureText =
                                                    !value.obscureText;
                                                value.notifyListeners();
                                              },
                                              child: Icon(
                                                !value.obscureText
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Country",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                height: 1.4,
                                                color: Colors.black,
                                                fontSize: 18)),
                                        Text(
                                          _sellerProfileProvider
                                              .sellerProfileModel
                                              .data!
                                              .countryName
                                              .toString(),
                                          style: TextStyle(
                                              height: 1.4,
                                              color: Colors.black,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                            displayText(
                                "State",
                                _sellerProfileProvider
                                    .sellerProfileModel.data!.statesName
                                    .toString(),
                                "Postal Code",
                                _sellerProfileProvider
                                    .sellerProfileModel.data!.postalCode
                                    .toString(),
                                context),
                            Divider(),
                            displayText(
                                "City",
                                _sellerProfileProvider
                                    .sellerProfileModel.data!.city
                                    .toString(),
                                "Address",
                                _sellerProfileProvider
                                    .sellerProfileModel.data!.address
                                    .toString(),
                                context),
                            Divider(),
                          ],
                        ),
                      );
              }),
        ));
  }

  displayText(String name2, String value2, String name1, String value1,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.instance.text(name2),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                      color: Colors.black,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(
                    value2,
                    style: TextStyle(
                        height: 1.4, color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.instance.text(name1),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                      color: Colors.black,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(
                    value1,
                    style: TextStyle(
                        height: 1.4, color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  dateDisplay(String name2, String value2, String name1, var value1,
      BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.instance.text(name2),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                    color: Colors.black,
                    fontSize: 18),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(
                  value2,
                  style:
                      TextStyle(height: 1.4, color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.instance.text(name1),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                    color: Colors.black,
                    fontSize: 18),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(
                  formatterDate(value1),
                  style:
                      TextStyle(height: 1.4, color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
// displayText(String name2, String value2, String name1, String value1,
//     BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(
//           color: Colors.black,
//           width: MediaQuery.of(context).size.width / 2.9,
//           child: CommonRichText(
//             richText1: '$name2\n',
//             style1: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 height: 1.4,
//                 color: Colors.black,
//                 fontSize: 18),
//             richText2: value2,
//             style2: TextStyle(fontWeight: FontWeight.normal),
//           ),
//         ),
//         Container(
//           width: MediaQuery.of(context).size.width / 2.9,
//           child: CommonRichText(
//             richText1: '$name1\n',
//             style1: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 height: 1.4,
//                 color: Colors.black,
//                 fontSize: 18),
//             richText2: value1,
//             style2: TextStyle(fontWeight: FontWeight.normal),
//           ),
//         ),
//       ],
//     ),
//   );
// }
