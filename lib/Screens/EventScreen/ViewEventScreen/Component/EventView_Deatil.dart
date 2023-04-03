import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/ViewEventScreen/Provider/UserViewEventProvider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

class EventViewTabDetail extends StatelessWidget {

  UserEventViewProvider ?_eventViewProvider;

  @override
  Widget build(BuildContext context) {
    _eventViewProvider = Provider.of<UserEventViewProvider>(context,listen: true);
    return Container(
      width: MediaQuery.of(context).size.width,

      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  AppLocalizations.instance.text("About"),
                  style: TextStyle(fontSize: 16),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),

            width: double.infinity,
            decoration: BoxDecoration(color: Color(0xFFEEEEEE), boxShadow: [
              BoxShadow(
                color: Color(0xFFD9D8D8),
                offset: Offset(5.0, 5.0),
                blurRadius: 7,
              ),
              BoxShadow(
                color:Colors.white.withOpacity(.5),
                offset: Offset(-5.0, -5.0),
                blurRadius:7,
              ),
            ]),
             child:  eventDescription( _eventViewProvider!.eventModel!.description.toString()),

          ),
          SizedBox(height: 30,),
        ],
      ),

    );
  }

 eventDescription(String description) {
    return Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 10,
        ),
        child: Html(data: description, style: {
          "body": Style(
            fontSize: FontSize(14.0),
          textAlign: TextAlign.justify
          ),
        }));
  }
}
