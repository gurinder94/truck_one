import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Component/post_box_component.dart';
import 'Component/user_posts_list.dart';
import 'Provider/post_upload_provider.dart';

class MyHomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFEEEEEE),
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),


              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChangeNotifierProvider(
                      create: (context) => PostUploadProvider(),
                      child: PostBox(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    UserPostList(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }


}
