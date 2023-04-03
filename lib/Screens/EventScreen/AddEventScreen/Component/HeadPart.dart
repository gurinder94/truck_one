import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/AddEventScreen/Provider/AddEventProvider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customLoder.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';
import 'package:provider/provider.dart';

class HeadPart extends StatelessWidget {
  String? type;
  AddEventProvider? _addEventProvider;

  @override
  Widget build(BuildContext context) {

    _addEventProvider = Provider.of<AddEventProvider>(context);
    return Container(
      height: 300,
      width: double.infinity,
      child: Stack(children: [
        SizedBox(
            height: 270,
            width: double.infinity,
            child:_addEventProvider!.imagebackground == null
                ? CustomImage(image:  '' , width: double.infinity, boxFit:BoxFit.cover,  height: 500,)

                :_addEventProvider!.bannerLoad==true? CustomLoder():Image.network(
                    SERVER_URL +
                        "/uploads/event/image//" +
                        _addEventProvider!.imagebackground.toString(),
                    fit: BoxFit.cover,
                  )),
        Positioned(
          bottom: 75,
          right: 10,
          child: GestureDetector(
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Color(0xFF1A62A9),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10)],
              ),
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
            onTap: () {
              type = "BANNERIMAGE";

              _addEventProvider!.getFromGallery(type!,context);
            },
          ),
        ),
        Positioned(
            left: 20,
            bottom: 5,
            child: _addEventProvider!.imageLogo==null? CustomImageProfile(

               image: '', height: 80, width: 80,boxFit:BoxFit.cover ,
            ):_addEventProvider!.imageLoad==true? CustomLoder():CustomImageProfile(

              image:  SERVER_URL + "/uploads/event/brand_logo/" +
                  _addEventProvider!.imageLogo.toString(), height: 80, width: 80,boxFit:BoxFit.cover ,
            )



        ),
        Positioned(
          bottom: 1,
          left: 80,
          child: GestureDetector(
            child: Container(
              height: 33,
              width: 33,
              decoration: BoxDecoration(
                color: Color(0xFF1A62A9),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10)],
              ),
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 19,
              ),
            ),
            onTap: () {
              type = "BRANDLOGO";
              _addEventProvider!.getFromGallery(type!,context);
            },
          ),
        ),
      ]),
    );
  }
}

