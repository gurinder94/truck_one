import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/recomments_model.dart';
import 'package:my_truck_dot_one/Screens/Home/Edit_Recomment_Screen/edit_recomment_provider.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/recomments_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_button_widget.dart';
import 'package:provider/provider.dart';

class EditRecommentScreen extends StatefulWidget {
  RecommentModel recommentlist;
  String commetId, postId;
  List<RecommentModel> list;
  int i;
  ReCommentsProvider provider;

  EditRecommentScreen(this.recommentlist, this.commetId, this.postId, this.list,
      this.i, this.provider);

  @override
  State<EditRecommentScreen> createState() => _EditRecommentScreenState();
}

class _EditRecommentScreenState extends State<EditRecommentScreen> {
  TextEditingController _controller = TextEditingController();
  late EditRecommentProvider _editRecommentProvider;

  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = widget.recommentlist.comment.toString();
    _editRecommentProvider = context.read<EditRecommentProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        height: MediaQuery.of(context).size.height / 4.5,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 4, offset: Offset(-5, -5)),
              BoxShadow(
                  color: Colors.white, blurRadius: 4, offset: Offset(-5, -5))
            ]),
        child: Column(children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Image.network(
                    IMG_URL + widget.recommentlist.image.toString(),
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : CircularProgressIndicator.adaptive();
                    },
                    errorBuilder: (a, b, c) =>
                        Center(child: Image.asset('assets/user_ic.png')),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InputTextField(
                    child: TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.multiline,
                      controller: _controller,
                      minLines: 1,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: 'Write something here...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 14),
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CommanButtonWidget(
                  title: AppLocalizations.instance.text("Cancel"),
                  titleColor: Colors.white,
                  buttonColor: PrimaryColor,
                  onDoneFuction: () {
                    Navigator.pop(context);
                  },
                  loder: false),
              CommanButtonWidget(
                  title: AppLocalizations.instance.text("Save"),
                  titleColor: Colors.white,
                  buttonColor: PrimaryColor,
                  onDoneFuction: () async {
                    var getId = await getUserId();

                    _editRecommentProvider.hitupdateCommnet({
                      "userId": getId,
                      "postId": widget.postId,
                      "commentId": widget.recommentlist.id,
                      "comment": _controller.text
                    }, widget.list, widget.i, widget.provider, _controller.text,
                        widget.recommentlist.id);
                  },
                  loder: false),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ]));
  }
}
