import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/EditEventScreen/Provider/EditProvider.dart';
import 'package:provider/provider.dart';

import '../../../commanWidget/custom_image_network_profile.dart';

class HeadEditPart extends StatelessWidget {
  String? type;

  EditEventProvider editEventProvider;

  HeadEditPart(this.editEventProvider);

  Widget build(BuildContext context) {



    return Container(
      height: 300,
      width: double.infinity,
      child: Stack(children: [

        Container(
          width: double.infinity,
          height: 250,
          child: editEventProvider.imagebackground == null
              ? Image.network(
            SERVER_URL +
                "/uploads/event/image/thumbnail/" +
                editEventProvider.eventModel.bannerImage.toString(),
            width: double.infinity,

            height: 250,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                  alignment: Alignment.center,
                  child:

                  Image.asset(
                    'icons/productimage.png',
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                  ));
            },
          )
              : Image.network(
            SERVER_URL +
                "/uploads/event/image/thumbnail/" +
                editEventProvider.imagebackground.toString(),
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              return progress == null
                  ? child
                  : Center(child: CircularProgressIndicator.adaptive());
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'icons/productimage.png',
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                  ));
            },
          ),
        ),

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
              editEventProvider.getFromGallery(type!, context);
            },
          ),
        ),


        Positioned(
          left: 20,
          bottom: 10,
          child: editEventProvider.imageLogo==null? CustomImageProfile(
            image:   editEventProvider.eventModel.brandLogo == null
                ? ''
                : Event_logo_Url +
                editEventProvider.eventModel.brandLogo.toString(),
            width: 100,
            boxFit: BoxFit.cover,
            height: 100,
          ):
          CustomImageProfile(
            image:   Event_logo_Url +
                editEventProvider.imageLogo
                    .toString(), // this image doesn't exist

            height: 100,
            width: 100, boxFit: BoxFit.cover,
          )
          // Image.network(
          // Event_logo_Url +
          //     _editEventProvider!.imageLogo
          //         .toString(), // this image doesn't exist
          // fit: BoxFit.cover,
          // height: 100,
          // width: 100,
          //
          // errorBuilder: (context, error, stackTrace) {
          //   return Container(
          //       height: 100,
          //       width: 100,
          //       clipBehavior: Clip.none,
          //       child: Image.asset(
          //         'icons/bannerProfile.png',
          //         fit: BoxFit.cover,
          //         height: 100,
          //         width: 100,
          //       ));
          // },
          // ),
        ),
        Positioned(
          bottom: 5,
          left: 85,
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
              type = "BRANDLOGO";
              editEventProvider.getFromGallery(type!, context);
            },
          ),
        ),
      ]),
    );
  }
}
