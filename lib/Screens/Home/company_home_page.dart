import 'dart:async';

import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import '../../AppUtils/constants.dart';
import '../commanWidget/pop_menu_Widget.dart';
import 'Component/appbar_with_search.dart';
import 'Component/description_txt.dart';
import 'Component/image_video_component.dart';
import 'Component/post_box_component.dart';
import 'Component/user_posts_list.dart';
import 'Provider/home_page_list_provider.dart';
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
                    //StoryPage('https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                    SizedBox(
                      height: 10,
                    ),
                    UserPostList(),
                    // PaginationWidget()
                  ],
                ),
              ),
            ],
          ),
        ));
  }


}
