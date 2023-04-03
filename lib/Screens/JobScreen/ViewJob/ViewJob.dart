import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customapp.dart';
import 'package:provider/provider.dart';
import '../../Language_Screen/application_localizations.dart';
import 'Component/JobLowerPart.dart';
import 'Provider/JobviewProvider.dart';

class ViewJob extends StatefulWidget {
String jobId;
  bool isAppiled;
  ViewJob(this. jobId, this.isAppiled);

  @override
  State<ViewJob> createState() => _ViewJobState();
}

class _ViewJobState extends State<ViewJob> {
  var  rolename;

  late JobViewProvider _jobViewProvider;
 @override
  void initState() {
   _jobViewProvider = Provider.of<JobViewProvider>(context, listen: false);

     _jobViewProvider.hitCompanyDetail(context, widget.jobId);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  CustomAppBar(
      title:AppLocalizations.instance.text('Job View'),
      visual: false,
      child:

      Consumer<JobViewProvider>(builder: (_, proData, __)
    {
       if(proData.loading ) return Column(
      children: [

        SizedBox(height: 300,),
        Center(child: CircularProgressIndicator()),
      ],
      );
       else if(proData.jobModel==null)
          return Column(
         children: [

           SizedBox(height: 300,),
           Center(child: CircularProgressIndicator()),
         ],
       ) ;
       else
       return SingleChildScrollView(
         child: Column(
         children: [
           // JobHeadPart(),
           SizedBox(height: 110,),

           JobLowerPart(proData,widget.isAppiled)
         ],
         ),
       );
    }
      )
    );
  }
}
