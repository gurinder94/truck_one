import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/ViewJob/Provider/JobviewProvider.dart';
import 'package:provider/provider.dart';

class JobHeadPart extends StatelessWidget {
  late JobViewProvider jobTabBarProvider;

  Widget build(BuildContext context) {

    jobTabBarProvider = context.watch<JobViewProvider>();

    print(jobTabBarProvider.jobModel.data![0].companyLogo);
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Container(

          padding: EdgeInsets.all(3),
          clipBehavior: Clip.antiAlias,
          child: Container(
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              SERVER_URL +
                  "/uploads/company/banner/" +
                  jobTabBarProvider.jobModel.data![0].bannerImage.toString(),
              fit: BoxFit.cover,
              height: 100,
              width: 100,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                    clipBehavior: Clip.none,
                    child: Image.network(
                      'https://seeklogo.com/images/B/business-company-logo-4A111D4E18-seeklogo.com.png',
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ));
              },
            ),
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
      ),
    );
  }
}
