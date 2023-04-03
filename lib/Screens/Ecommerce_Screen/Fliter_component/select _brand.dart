import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/e_commerce_Product_List/Provider/ecommerce_product_list_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';


class SelectBrand extends StatefulWidget {
  ProductListProvider productListProvider;
  SelectBrand(this. productListProvider);



  @override
  State<SelectBrand> createState() => _SelectBrandState(productListProvider);
}

class _SelectBrandState extends State<SelectBrand> {
  @override
  ProductListProvider productListProvider;

  _SelectBrandState(this. productListProvider);


  Widget build(BuildContext context) {


    return Container(
      child: Column(

        children: [
          SizedBox(height: 2,),

          Center(child: Text(AppLocalizations.instance.text("Select-Brand"),style: TextStyle(color: Colors.black,fontSize: 18),)),
          SizedBox(height: 5,),
          Divider(),
          SizedBox(height: 15,),

          Expanded(
            child: ListView.builder(
                itemCount: productListProvider.brandListModel.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: Container(
                        width: 20,
                        child:  Checkbox(
                            value:  productListProvider.brandListModel.data![index].check,
                            onChanged: (val) {
                              productListProvider.brandListModel.data![index].check = val!;
                              setState(() {

                                if(productListProvider.brandListModel.data![index].check==true)
                                  productListProvider.valueBrand.add(productListProvider.brandListModel.data![index].id);
                                else
                                  productListProvider.valueBrand.remove(productListProvider.brandListModel.data![index].id);
print(productListProvider.valueBrand);
                              });
                            })
                      ),
                      title: Text(productListProvider.brandListModel.data![index].brand.toString()),);
                }),
          )
        ],
      ),
    );
  }
}
