import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/JobModel/JobModel 2.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/JobList/UserComponent/Provider/UserJobProvider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/InsideButton.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/OutsideButton.dart';
import 'package:provider/src/provider.dart';

import '../../../../commanWidget/custom_image_network.dart';

class JobSaveItem extends StatelessWidget {
  int index;
  UserJobProvider proData;

  JobSaveItem(
    this.index,
    this.proData,
  );

  @override
  Widget build(BuildContext context) {
    var data = context.watch<JobModel>();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment,
            children: [
              Container(
                padding: EdgeInsets.all(3),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  child: CustomImage(
                      image: IMG_URL + data.companyImg.toString(),
                      width: 80,
                      boxFit: BoxFit.fill,
                      height: 80),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFEEEEEE),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFD9D8D8),
                        offset: Offset(5.0, 5.0),
                        blurRadius: 3,
                      ),
                      BoxShadow(
                        color: Colors.white.withOpacity(.5),
                        blurRadius: 4,
                      ),
                    ]),
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(data.title.toString(),
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                      SizedBox(
                        height: 5,
                      ),
                      Text(data.companyName.toString(),
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        data.fullAddress.toString(),
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data.postedAt.toString(),
                              style:
                                  TextStyle(color: PrimaryColor, fontSize: 16),
                            ),
                            GestureDetector(
                              child: data.isSaved == true
                                  ? InsiderButton(
                                      Icon: Icon(
                                        Icons.save,
                                        color: PrimaryColor,
                                        size: 20,
                                      ),
                                    )
                                  : OutsideButton(
                                      Icon: Icon(
                                        Icons.save,
                                        size: 20,
                                        color: Colors.black54,
                                      ),
                                    ),
                              onTap: () async {
                                print(data.isSaved);

                                data.isSaved == true
                                    ? data.removeSaveJob(data.id.toString(),
                                        false, '', context, index, proData)
                                    : data.addSave(
                                        data.id.toString(), true, '', context);
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFD9D8D8),
                offset: Offset(5.0, 5.0),
                blurRadius: 2,
              ),
              BoxShadow(
                color: Colors.white.withOpacity(.4),
                offset: Offset(-5.0, -5.0),
                blurRadius: 10,
              ),
            ]),
      ),
    );
  }
}
