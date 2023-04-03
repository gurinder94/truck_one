import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/AddCartScreen/provider/promo_code_provider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Custom_App_Bar_Widget.dart';
import 'package:provider/provider.dart';

import '../../Model/SubscriptionPlanModel/promo_code_model.dart';
import '../Language_Screen/application_localizations.dart';

class PromoCodePage extends StatelessWidget {
  late PromoCodeProvider _provider;
  var value;

  PromoCodePage(this.value);

  @override
  Widget build(BuildContext context) {
    _provider = context.read<PromoCodeProvider>();
    _provider.hitGetPromoCodeList();
    return CustomAppBarWidget(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back)),
      child: Consumer<PromoCodeProvider>(builder: (_, proData, __) {
        if (proData.loading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (proData.promoCodeModel == null)
          return Center(
              child: Text(AppLocalizations.instance.text("Network issue")));
        else if (proData.promoCodeModel!.data!.isEmpty)
          return Center(
              child: Text(AppLocalizations.instance.text("No Record Found")));
        else
          return ListView.builder(
              itemCount: proData.promoCodeModel!.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var promoCode = proData.promoCodeModel!.data![index];
                return ChangeNotifierProvider<Datum>.value(
                    value:proData.promoCodeModel!.data![index],
                    child: PromoCodeItem ());
              });
      }),


      title: "PromoCode",
      actions: SizedBox(),
      floatingActionWidget: SizedBox(),
    );
  }
}

class PromoCodeItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var promocode=context.watch<Datum>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ListTile(
            trailing:promocode.ApplyPromoLoading==true?SizedBox(
                width: 35,
                height: 35,
                child: CircularProgressIndicator()):   GestureDetector(
              onTap: () {
                if (promocode.isApplied == true) {
                  promocode.hitRemovePromo();
                } else {
                  promocode.hitApplyPromoCode(
                      promocode.code!,
                      promocode);
                }

                // Navigator.pop(
                //     context, proData.promoCodeModel!.data![index]);
              },
              child: Text(
                promocode.isApplied ==
                    true
                    ? "Applied"
                    : "Apply",
                style: TextStyle(
                    color: promocode.isApplied ==
                        true
                        ? Colors.green
                        : Colors.red,
                    fontSize: 12),
              ),
            ),
            subtitle: Text(
              promocode.title.toString(),
              style: TextStyle(fontSize: 12),
            ),
            title: Text(promocode.code.toString())),
        decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.white,
                  blurRadius: 5,
                  offset: Offset(-5, -5)),
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 1,
                  offset: Offset(5, 5)),
            ]),
      ),
    );
  }
}
