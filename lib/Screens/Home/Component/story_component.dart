import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/AppUtils/data_items.dart';


class StoryPage extends StatelessWidget {
  String path;

  StoryPage(this.path);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 1, left: 12, right: 12),
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Stack(
              children: [
                ClipOval(
                  child: Image.network(
                    path,
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    width: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: PrimaryColor),
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.add,
                      size: 15,
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: dummyImages.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) => ClipOval(
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(left: 10),
                    child: ClipOval(
                      child: Image.network(
                        dummyImages[i],
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
