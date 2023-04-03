import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/ViewJob/Provider/JobviewProvider.dart';
import 'package:provider/provider.dart';
class JobDetails extends StatelessWidget {
  @override
  late JobViewProvider _jobViewProvider;

  Widget build(BuildContext context) {
    _jobViewProvider = context.watch<JobViewProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text("Job Highlights",style: TextStyle(color: Color(0xFF044a87), fontSize: 20,fontWeight: FontWeight.w700),),

                JobHighLights('${_jobViewProvider.jobModel.data![0].maximumExperience.toString()}-${_jobViewProvider.jobModel.data![0].maximumExperience.toString()} Years'),
                JobHighLights('${_jobViewProvider.jobModel.data![0].vacancy.toString()} Vacancy'),
                JobHighLights(_jobViewProvider.jobModel.data![0].address.toString()),
                // JobHighLights(
                //     _jobViewProvider.jobModel.industry!.roles.toString()),
                SizedBox(
                  height: 30,
                ),
              ],
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
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text("Job Description",style: TextStyle(color: Color(0xFF044a87), fontSize: 20,fontWeight: FontWeight.w700),),
                  JobDescription(
                      _jobViewProvider.jobModel.data![0].description.toString()),
                  SizedBox(
                    height: 10,
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
        )
      ],
    );
  }

  JobHighLights(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(title.toString()),
    );
  }

  JobDescription(String description) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(description.toString()),
    );
  }
}
