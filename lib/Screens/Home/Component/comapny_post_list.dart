import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';

import '../../../AppUtils/data_items.dart';


class CompanyPostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context, i) => postWidget(i));
  }

  postWidget(int i) {
    return Container(
      width: 100,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          listTopWidget(),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth > 600) {
                return postImageWidget(300,i);
              } else {
                return postImageWidget(300,i);
              }
            },
          ),
          bottomWidget()
        ],
      ),
    );
  }

  listTopWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.network(
              'https://dynamic.brandcrowd.com/asset/logo/12353001-c718-4da3-b721-f045b8791ae1/logo?v=4',
              fit: BoxFit.cover,
              height: 50,
              width: 50,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GHUMAAN TRUCKING INC',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                /*Text('MIRACLE PLACEMENT HUB PRIVATE LIMITED',
                    style: TextStyle(
                      fontSize: 14,
                    )),*/
                   Text('Lathrop, CA ',style: TextStyle(color: Colors.grey),)
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
         /* Text(
            '+  Follow',
            style: TextStyle(color: PrimaryColor, fontWeight: FontWeight.bold),
          ),*/
          Image.asset(
            'assets/post_menu_ic.png',
            scale: 10,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }


  bottomWidget() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/like_ic.png',
                scale: 30,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '1,770',
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.grey[600]),
              ),
              Expanded(
                  child: Text(
                '31 Comments',
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.grey[600]),
              ))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 1,
            color: Colors.grey[300],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/gray_like_ic.png',
                scale: 3,
              ),
              Image.asset(
                'assets/gray_comment_ic.png',
                scale: 3,
              ),
              Image.asset(
                'assets/gray_share_ic.png',
                scale: 3,
              ),
              Image.asset(
                'assets/gray_send_ic.png',
                scale: 3,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  postImageWidget(double hei, int i) {
    return Image.asset(
      companyIMG[i],
      fit: BoxFit.cover,
      height: hei,
      width: double.infinity,
    );
  }
}
