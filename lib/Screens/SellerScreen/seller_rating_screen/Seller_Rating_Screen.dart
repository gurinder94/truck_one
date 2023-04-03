import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';
import 'package:provider/provider.dart';

import '../../commanWidget/Custom_App_Bar_Widget.dart';
import 'Provider/seller_rating_provider.dart';

class SelleRating extends StatelessWidget {
  late SellerRatingProvider _sellerRatingProvider;

  @override
  Widget build(BuildContext context) {
    print("sdlkklds");
    _sellerRatingProvider = context.read<SellerRatingProvider>();
    _sellerRatingProvider.resetList();
    _sellerRatingProvider.getSellerRatingGivenCustomer();
    return CustomAppBarWidget(
      leading: SizedBox(),
      floatingActionWidget: SizedBox(),
      actions: SizedBox(),
      title: AppLocalizations.instance.text('My Rating'),
      child: Consumer<SellerRatingProvider>(builder: (_, proData, __) {
        if (proData.loading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (proData.givenByCustomerModel.data!.length == 0)
          return Center(child: Text(AppLocalizations.instance.text('No Record Found')));
        else
          return ListView.builder(
              itemCount: proData.sellerRatingList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.all(7.0),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          child: CustomImageProfile(
                            image: IMG_URL +
                                proData.sellerRatingList[index].image
                                    .toString(),
                            width: 50,
                            boxFit: BoxFit.cover,
                            height: 50,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(proData.sellerRatingList[index].personName
                                  .toString()),
                              SizedBox(
                                height: 10,
                              ),
                              Text(proData.sellerRatingList[index].email
                                  .toString()),
                              Divider(
                                color: Colors.black,
                                height: 1,
                                thickness: 1.0,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              reviewRating(proData
                                  .sellerRatingList[index].rating!
                                  .toInt()),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
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

reviewRating(int value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List.generate(5, (index) {
      return Icon(
        index < value ? Icons.star : Icons.star_border,
        color: index < value ? Colors.amberAccent : Colors.black,
        size: index < value ? 28 : 24,
      );
    }),
  );
}
