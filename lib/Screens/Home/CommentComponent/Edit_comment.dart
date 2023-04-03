import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/comments_model.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/CommentEditProvider.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/comments_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_button_widget.dart';
import 'package:provider/src/provider.dart';

class EditComment extends StatefulWidget {
  CommentItemModel data;
  CommentsProvider provider;
  int index;

  EditComment(this.data, this.provider, this.index);

  @override
  State<EditComment> createState() => _EditCommentState();
}

class _EditCommentState extends State<EditComment> {
  late CommentEditProvider _commentEditProvider;

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = widget.data.comment.toString();
    _commentEditProvider = context.read<CommentEditProvider>();
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
                    IMG_URL + widget.data.image.toString(),
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
                  title: AppLocalizations.instance.text('Cancel'),
                  titleColor: Colors.white,
                  buttonColor: PrimaryColor,
                  onDoneFuction: () {
                    Navigator.pop(context);
                  },
                  loder: false),
              CommanButtonWidget(
                  title: AppLocalizations.instance.text('Save'),
                  titleColor: Colors.white,
                  buttonColor: PrimaryColor,
                  onDoneFuction: () async {
                    var getId = await getUserId();
                    _commentEditProvider.hitupdateCommnet({
                      "userId": getId,
                      "postId": widget.provider.postId,
                      "commentId": widget.provider.list[widget.index].id,
                      "comment": _controller.text
                    }, widget.provider, widget.index, _controller.text,
                        widget.provider.list[widget.index].id.toString());
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
