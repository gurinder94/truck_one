import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Button.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customapp.dart';
import 'package:provider/provider.dart';
import 'JobList/CompanyJob/Provider/JobListProvider.dart';

class JobSearch extends StatelessWidget {
  @override
  late JobListProvider _jobListProvider;
  Widget build(BuildContext context) {
    _jobListProvider = Provider.of<JobListProvider>(context, listen: false);
    return CustomAppBar(
        title: 'Search For Your Job',
        visual: false,
        child: SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10,top: 30),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        InputTextField(
                          child: TextFormField(
                            controller: _jobListProvider.searchEditingController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search by Title,Skills Or Company ',
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InputTextField(
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'City,State or Zip Code ',
                              prefixIcon: Icon(Icons.location_on_outlined),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          child: Button(
                            text: 'Search Jobs',
                            Textcolor: Colors.white,
                            colorcode: Color(0xFF1A62A9),
                          ),
                          onTap: ()
                          {
                            // getSearchJob(context);
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(color: Color(0xFFEEEEEE), boxShadow: [
                    BoxShadow(
                      color: Color(0xFFD9D8D8),
                      offset: Offset(5.0, 5.0),
                      blurRadius: 7,
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(.4),
                      offset: Offset(-5.0, -5.0),
                      blurRadius: 10,
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ));

  }

}
