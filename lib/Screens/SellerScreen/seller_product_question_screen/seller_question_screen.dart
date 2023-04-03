import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/Debouncer.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/SellerScreen/seller_product_question_screen/Seller_Edit_Question_Screen/edit_answer_question_Screen.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/SizeConfig.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/pop_menu_Widget.dart';
import 'package:provider/provider.dart';
import '../../commanWidget/PaginationWidget.dart';
import '../../commanWidget/Search_bar.dart';
import 'Provider/seller_product_question _answer.dart';
import 'Seller_Edit_Question_Screen/provider/seller_edit_question_answer_provider.dart';
import 'View_detail_question/Provider/view_question_answer_provider.dart';
import 'View_detail_question/ViewQuestionDetail.dart';

class SellerQuestionScreen extends StatefulWidget {
  @override
  State<SellerQuestionScreen> createState() => _SellerQuestionScreenState();
}

class _SellerQuestionScreenState extends State<SellerQuestionScreen> {
  @override
  late SellerProductQuestionProvider _sellerProductQuestionProvider;

  String searchText = '';

  String type = "no";

  ScrollController scrollController = new ScrollController();

  int page = 1;

  int? secondPop;



  @override
  void initState() {
    // TODO: implement initState

    page = 1;
    _sellerProductQuestionProvider =
        context.read<SellerProductQuestionProvider>();
    addScrollListener(context);
    _sellerProductQuestionProvider.resetQuestionList();
    _sellerProductQuestionProvider.getQuestionAnswer(type, '', page, false);
    super.initState();
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xFFEEEEEE),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 55,
          title: Text(AppLocalizations.instance.text('Question')),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                color: APP_BAR_BG,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
          ),
          actions: [],
        ),
        body: Column(
          children: [
            SizeConfig.screenHeight! < 1010
                ? SizedBox(
                    height: Platform.isIOS
                        ? SizeConfig.safeBlockVertical! * 15
                        : SizeConfig.safeBlockVertical! * 12, //10 for example
                  )
                : SizedBox(
                    height: Platform.isIOS
                        ? SizeConfig.safeBlockVertical! * 8
                        : SizeConfig.safeBlockVertical! * 9, //10 for example
                  ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: CommanSearchBar(
                      onTextChange: (val) {
                        // _debouncer.run(() {
                        if (!_sellerProductQuestionProvider.loading) {
                          _sellerProductQuestionProvider.getQuestionAnswer(
                              type, val, page, false);
                        }
                        // });
                      },
                      IconName: PopMenuBar(
                        iconsName: Icons.filter_list,
                        val: type == "no" ? 2 : 1,
                        containerDecoration: 1,
                        onDoneFunction: (value) {
                          switch (value) {
                            case 2:
                              type = "no";
                              _sellerProductQuestionProvider
                                  .resetQuestionList();
                              page = 1;
                              _sellerProductQuestionProvider.getQuestionAnswer(
                                  "no", '', 1, false);

                              break;
                            case 1:
                              type = "yes";
                              _sellerProductQuestionProvider
                                  .resetQuestionList();
                              page = 1;
                              _sellerProductQuestionProvider.getQuestionAnswer(
                                  "yes", '', page, false);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => EditQuestionAnswer()));

                              break;
                          }
                        },
                        userMenuItems: [
                          ['Answered', 1],
                          ['UnAnswered', 2],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<SellerProductQuestionProvider>(
                  builder: (_, proData, __) {
                if (proData.loading) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (proData.questionList.length == 0 ||
                    proData.questionAnswerModel.data == null)
                  return Center(
                      child: Text(
                          AppLocalizations.instance.text("No Record Found")));
                else
                  return ListView.builder(
                      itemCount: proData.questionList.length,
                      controller: scrollController,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.all(12.0),
                          child: GestureDetector(
                            onTap: () {
                              type == "yes"
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider(
                                                  create: (_) =>
                                                      ViewQuestionAnswerProvider(),
                                                  child: ViewQuestion(
                                                    index,
                                                    IMG_URL +
                                                        proData
                                                            .questionList[index]
                                                            .image
                                                            .toString(),
                                                    proData.questionList[index]
                                                        .productName
                                                        .toString(),
                                                    proData.questionList[index]
                                                        .personName
                                                        .toString(),
                                                    proData
                                                        .questionList[index].id
                                                        .toString(),
                                                  ))))
                                  : SizedBox();
                            },
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                children: [
                                  Row(children: [
                                    Hero(
                                      tag: index,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          child: CustomImageProfile(
                                            image: proData.questionList[index]
                                                        .image ==
                                                    null
                                                ? ''
                                                : IMG_URL +
                                                    proData.questionList[index]
                                                        .image
                                                        .toString(),
                                            height: 70,
                                            width: 70,
                                            boxFit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          displaySecondText(
                                              "Product Name",
                                              proData.questionList[index]
                                                  .productName
                                                  .toString(),
                                              "Person Name",
                                              proData.questionList[index]
                                                  .personName
                                                  .toString(),
                                              context,
                                              proData,
                                              index,
                                              type),
                                          SizedBox(
                                            height: 6,
                                          ),

                                          displayText(
                                            "Question",
                                            proData.questionList[index].question
                                                .toString(),
                                          ),

                                          //         displayText( "Product Name" ,proData.questionList[index].productName.toString(),"PersonName"  ,"name2",),

                                          // SizedBox(
                                          //   width: 160,
                                          //   child: Text(proData.questionList[index].productName.toString(),
                                          //     overflow: TextOverflow.ellipsis,
                                          //     maxLines: 1,
                                          //     softWrap: false,
                                          //   style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize:18,
                                          //
                                          //   ),),
                                          // ),
                                          // SizedBox(
                                          //   height: 10,
                                          // ),

                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    //   Spacer(),
                                    //   type=="yes"?  SizedBox():       Column(
                                    //     crossAxisAlignment: CrossAxisAlignment.end,
                                    //     children: [
                                    //       Padding(
                                    //         padding: const EdgeInsets.only(right: 10),
                                    //         child: PopMenuBar(
                                    //           containerDecoration: 1,
                                    //           onDoneFunction: (value) {
                                    //             switch (value) {
                                    //               case 2:
                                    //                 DialogUtils.showMyDialog(
                                    //                   context,
                                    //                   onDoneFunction: () {
                                    //                     _sellerProductQuestionProvider.getDeleteQuestionAnswer( proData.questionList[index].id.toString(), _sellerProductQuestionProvider,index);
                                    //
                                    //                     Navigator.pop(context);
                                    //                   },
                                    //                   oncancelFunction: () =>
                                    //                       Navigator.pop(context),
                                    //                   title: 'Delete',
                                    //                   alertTitle:
                                    //                       "Are you sure you want to delete?",
                                    //                   btnText: "Done",
                                    //                 );
                                    //                 break;
                                    //               case 1:
                                    //                 Navigator.push(
                                    //                     context,
                                    //                     MaterialPageRoute(
                                    //                         builder: (context) => ChangeNotifierProvider(
                                    //                             create: (_) =>EditQuestionAnswerProvider (),
                                    //                             child: EditQuestionAnswer(_sellerProductQuestionProvider.questionAnswerModel.data![index].question,
                                    //                                 _sellerProductQuestionProvider.questionAnswerModel.data![index].id))));
                                    //
                                    //             }
                                    //           },
                                    //           userMenuItems: [
                                    //             ['Answered', 1],
                                    //             ['Delete', 2],
                                    //           ],
                                    //         ),
                                    //       ),
                                    //       SizedBox(
                                    //         height: 60,
                                    //       )
                                    //     ],
                                    //   ),
                                    //
                                    // ],
                                  ]),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: APP_BG,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
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
                          ),
                        );
                      });
              }),
            ),
            Selector<SellerProductQuestionProvider, bool>(
                selector: (_, provider) => provider.paginationLoder,
                builder: (context, paginationLoading, child) {
                  return PaginationWidget(paginationLoading);
                }),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }

  displaySecondText(
    String name,
    String value,
    String name2,
    String value2,
    BuildContext context,
    SellerProductQuestionProvider proData,
    int index,
    String type,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.instance.text(name),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              '$value',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        )),
        SizedBox(
          width: 20,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.instance.text(name2),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              '$value2',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        )),
        type == "yes"
            ? SizedBox()
            : Padding(
                padding: const EdgeInsets.only(right: 10),
                child: PopMenuBar(
                  iconsName: Icons.more_vert,
                  val: secondPop,
                  containerDecoration: 1,
                  onDoneFunction: (value) {
                    switch (value) {
                      case 2:
                        secondPop = value;
                        DialogUtils.showMyDialog(
                          context,
                          onDoneFunction: () {
                            _sellerProductQuestionProvider
                                .getDeleteQuestionAnswer(
                                    proData.questionList[index].id.toString(),
                                    _sellerProductQuestionProvider,
                                    index);

                            Navigator.pop(context);
                          },
                          oncancelFunction: () => Navigator.pop(context),
                          title: 'Delete',
                          alertTitle: "Delete Question",
                          btnText: "Done",
                        );
                        break;
                      case 1:
                        secondPop = value;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                    create: (_) => EditQuestionAnswerProvider(),
                                    child: EditQuestionAnswer(
                                        proData.questionList[index].question,
                                        proData.questionList[index].id,
                                        proData.questionList[index]
                                            .customerId)))).then((value) {
                          page = 1;
                          this.type = "no";
                          _sellerProductQuestionProvider =
                              context.read<SellerProductQuestionProvider>();
                          addScrollListener(context);
                          _sellerProductQuestionProvider.resetQuestionList();
                          _sellerProductQuestionProvider.getQuestionAnswer(
                              "no", '', page, false);
                        });
                    }
                  },
                  userMenuItems: [
                    [AppLocalizations.instance.text("Answered"), 1],
                    [AppLocalizations.instance.text("Delete"), 2],
                  ],
                ),
              )
      ],
    );
  }

  displayText(
    String name,
    String value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.instance.text(
                name,
              ),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              '$value',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        )),
        SizedBox(
          width: 24,
        ),
      ],
    );
  }

  void addScrollListener(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (!_sellerProductQuestionProvider.paginationLoder) {
          page = page + 1;
          if (_sellerProductQuestionProvider.questionAnswerModel.data!.length ==
              0) {
          } else {
            pagnationList(context, page);
          }
          // Perform event when user reach at the end of list (e.g. do
        }
      }
    });
  }

  pagnationList(BuildContext context, int pagee) async {
    _sellerProductQuestionProvider.getQuestionAnswer(
        type, searchText, pagee, true);
  }
}
