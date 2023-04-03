  import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Network/network_page/network_provider.dart';

import 'normal_response.dart';

class GroupInvitationModel
  {
    GroupInvitationModel({
      this.code,
      this.message,
      this.data,
      this.totalCount,

    });
    int? code;
    String? message;
    List<GroupInfo>? data;

    int? totalCount;
    factory GroupInvitationModel.fromJson(Map<String, dynamic> json) => GroupInvitationModel(
      code: json["code"],
      message: json["message"],
      data: List<GroupInfo>.from(json["data"].map((x) => GroupInfo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
      "code": code,
      "message": message,
      "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
  }

  class GroupInfo extends ChangeNotifier {
    GroupInfo({
      this.id,
      this.groupId,
      this.groupName,
      this.personName,
      this.groupImage,
      this.invitedBy,
    });

    String ?id;
    String ?groupId;
    String ?groupName;
    String ?personName;
    String ?groupImage;
    String ?invitedBy;

    factory GroupInfo.fromJson(Map<String, dynamic> json) =>
        GroupInfo(
          id: json["_id"],
          groupId: json["groupId"],
          groupName: json["groupName"],
          personName: json["personName"],
          groupImage: json["groupImage"]??'',
            invitedBy:json["invitedBy"]
        );

    Map<String, dynamic> toJson() =>
        {
          "_id": id,
          "groupId": groupId,
          "groupName": groupName,
          "personName": personName,
          "groupImage": groupImage,
          "invitedBy":invitedBy,
        };

    bool loading = false;

    connectUser(Map<String, dynamic> map, BuildContext context,
        NetworkProvider provider) async {
      print(map);
      loading = true;
      notifyListeners();
      try {
        var getid = await getUserId();
        ResponseModel model = await hitConnectPeople(map);
        showMessage(model.message.toString(), );


        loading = false;
        notifyListeners();
      } on Exception catch (e) {
        var message = e.toString().replaceAll('Exception:', '');
        showMessage(message, );
        print(e.toString());
        loading = false;
        notifyListeners();
      }
    }

  }
