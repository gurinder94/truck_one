import 'package:flutter/material.dart';

import '../../Language_Screen/application_localizations.dart';
import '../e_commerce_Product_List/Provider/ecommerce_product_list_provider.dart';

class SelectModel extends StatefulWidget {
  ProductListProvider productListProvider;
  SelectModel(this.productListProvider);



  @override
  State<SelectModel> createState() => _SelectModelState(productListProvider);
}

class _SelectModelState extends State<SelectModel> {
  @override
  var value;
  late ProductListProvider productListProvider;

  _SelectModelState(this. productListProvider);


  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
        SizedBox(height: 2,),

        Center(child: Text(AppLocalizations.instance.text("Select Model"),style: TextStyle(color: Colors.black,fontSize: 18),)),
        SizedBox(height: 5,),
        Divider(),
        SizedBox(height: 15,),


          Expanded(
            child: ListView.builder(
                itemCount: productListProvider.modelList.data!.length,

                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: Container(
                        width: 20,
                        child: RadioListTile<String>(
                          value:  productListProvider.modelList.data![index].id.toString(),
                          groupValue: productListProvider.valueModel,
                          onChanged: (val) => setState(()
                          {

                            productListProvider.valueModel=val;

                          }),

                        ),
                      ),
                    title: Text(productListProvider.modelList.data![index].title.toString(),),
                  );
                }),
          )
        ],
      ),
    );
  }
}
