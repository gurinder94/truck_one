import 'package:flutter/material.dart';

import '../Language_Screen/application_localizations.dart';
import 'input_shape.dart';


class CommanDrop extends StatelessWidget {
 var   itemsList;
 Function onChangedFunction;
 var    selectValue;
 String  title;

 CommanDrop({ required this.onChangedFunction,this.selectValue ,this.itemsList,required this.title});
  @override
  Widget build(BuildContext context) {
    return   InputShape(
          child: DropdownButton(
            hint:  Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(title),
            ),
            isExpanded: true,
            underline: Container(),
            value: selectValue,
            onChanged: (  value )
            {
              onChangedFunction(value);
            }
            ,
            items: itemsList
          ),

        );

  }
}


