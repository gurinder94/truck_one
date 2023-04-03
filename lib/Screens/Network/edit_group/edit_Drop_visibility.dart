import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../group_post_edit_page/edit_group_provider.dart';

class EditDropVisibility extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return Consumer<EditGroupProvider>(
      builder: (context, notif, __) {
        return DropdownButton<String>(
          hint: const Text("Visibility"),
          isExpanded: true,
          underline: Container(),
          value: notif.visibility,

          onChanged: (value) {
            notif.setVisiblity(value.toString());
          },

          items: notif.visual.map<DropdownMenuItem<String>>(
                (final String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Center(child: Text(value)),
              );
            },
          ).toList(),

        );
      },
    );
  }
}
