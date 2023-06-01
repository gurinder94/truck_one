import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_truck_dot_one/Model/ActivityLogModel.dart';
import 'package:my_truck_dot_one/Model/ChatModel/CreateSingleConversationModel.dart';
import 'package:my_truck_dot_one/Model/ChatModel/NewConversationList.dart';
import 'package:my_truck_dot_one/Model/ChatModel/group_friend_List.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/BrandListModel.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/Seller_rating_given_by_customer_Model.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/add_seller_rating_model.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/ecommerce_category_model.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/ecommerce_product_list_model.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/modelList.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/product_view_model.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/question_answer_model.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/seller_product_List_model.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/seller_question_answer_model.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/seller_rating_model.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/similar_product_model.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/sub_category_list.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/view_question_answer_model.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/wish_list_model.dart';
import 'package:my_truck_dot_one/Model/EventListModel.dart';
import 'package:my_truck_dot_one/Model/EventModel 2.dart';
import 'package:my_truck_dot_one/Model/Fleet_manager_model/fleet_manager_detail_model.dart';
import 'package:my_truck_dot_one/Model/Fleet_manager_model/fleet_manager_list_model.dart';
import 'package:my_truck_dot_one/Model/JobModel/Applicant.dart';
import 'package:my_truck_dot_one/Model/JobModel/Industry_list_model.dart';
import 'package:my_truck_dot_one/Model/JobModel/JobListModel.dart';
import 'package:my_truck_dot_one/Model/JobModel/JobViewList.dart';
import 'package:my_truck_dot_one/Model/LoginListModel.dart';
import 'package:my_truck_dot_one/Model/ManageTeamModel/company_mange_team_model.dart';
import 'package:my_truck_dot_one/Model/ManageTeamModel/manage_team_model 2.dart';
import 'package:my_truck_dot_one/Model/ManageTeamModel/seller_manage_team_model.dart';
import 'package:my_truck_dot_one/Model/ManageTeamModel/user_left_company_model 2.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/GroupMenberListModel.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/comments_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_detail_list.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_invitation_model 2.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_invite_menber_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/invited_connections_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/job_invitation_model 2.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/like_list_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/like_post_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/my_frinds_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/my_groups_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/post_list_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/post_upload_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/recommandation_model 2.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/recomments_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/user_detail_model.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/CompanyProfile.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/CountryModel.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/PostalCodeModel 2.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/ServiceModel.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/SkillModel.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/UserModel.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/company_leave_model.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/qualificationModel.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/seller_profile_model.dart';
import 'package:my_truck_dot_one/Model/ResetForgetModel.dart';
import 'package:my_truck_dot_one/Model/ServiceModel/ServiceListModel.dart';
import 'package:my_truck_dot_one/Model/ServiceModel/view_service_List.dart';
import 'package:my_truck_dot_one/Model/TimezoneModel.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/DriverDetailListModel.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/DriverModelList.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/GetServiceMarker.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/OtherDriverListModel.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/RouteModel.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TrailerListModel.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TripPlannerListModel.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TripViewDetails.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TruckDetailListModel.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TruckListModel.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/ViewMarkerList.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/WazeModel.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/get_all_waze_marker_model.dart';
import 'package:my_truck_dot_one/Model/WeatherModel/forecast_weather_model.dart';
import 'package:my_truck_dot_one/Model/WeatherModel/preciptaion_waether_model.dart';
import 'package:my_truck_dot_one/Model/WeatherModel/snow_weather_model.dart';
import 'package:my_truck_dot_one/Model/WeatherModel/thunder_weather_model.dart';
import 'package:my_truck_dot_one/Model/constant_model.dart';
import 'package:my_truck_dot_one/Model/isReadedModel.dart';
import 'package:my_truck_dot_one/Model/privacy_policy_model.dart';
import 'package:my_truck_dot_one/Model/switch_user_model.dart';
import 'package:my_truck_dot_one/Model/weather_model.dart';

import '../Model/Apply_PromoCode_model.dart';
import '../Model/ChatModel/ChatConversationModelDetail.dart';
import '../Model/ChatModel/ChatGroupViewModel.dart';
import '../Model/ChatModel/ConversationListModel.dart';
import '../Model/ChatModel/GroupViewAddMemberList.dart';
import '../Model/ChatModel/MessagesListModel.dart';
import '../Model/CountCartItemModel.dart';
import '../Model/MyPlanModel.dart';
import '../Model/NotificationModel/NotificationModel.dart';
import '../Model/PlanUpgradeSuccessModel.dart';
import '../Model/SubscriptionPlanModel/Add_to_cart_model.dart';
import '../Model/SubscriptionPlanModel/Subscription_payment_successful_model.dart';
import '../Model/SubscriptionPlanModel/promo_code_model 2.dart';
import '../Model/TripPlannerModel/trip_history_model.dart';
import '../Model/VINModel.dart';
import '../Model/account_detail_Model.dart';
import '../Model/sellerDashBoardModel 2.dart';
import '../PaymentSuccessModel.dart';
import 'baseService.dart';

hitLoginApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/user/login', map);
    if (response.statusCode == 200) {
      print('Resfdsfdfdsfdsdfsonse body: ${response.body}');
      var parseData = json.decode(response.body);

      switch (parseData['code']) {
        case 200:
          print('Response body: ${response.body}');
          return LoginListModel.fromJson(parseData);
        case 400:
          throw Exception(parseData['message']);
        case 401:
          throw Exception(parseData['message']);
        case 404:
          throw Exception(parseData['message']);
        case 403:
          // print('Response body: ${response.body}');
          return LoginListModel.fromJson(parseData);
        case 407:
          // print('Response body: ${response.body}');
          return LoginListModel.fromJson(parseData);
        case 555:
          throw Exception(parseData['message']);

        default:
          throw Exception(parseData['message']);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitSwitchUserApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/user/switchUser', map);
    if (response.statusCode == 200) {
      print('Response body:api/v1/user/switchUser ${response.body}');
      var parseData = json.decode(response.body);

      switch (parseData['code']) {
        case 200:
          // print('Response body: ${response.body}');
          return SwitchUserModel.fromJson(parseData);
        case 400:
          throw Exception(parseData['message']);
        case 401:
          throw Exception(parseData['message']);
        case 404:
          throw Exception(parseData['message']);
        case 403:
          throw Exception(parseData['message']);
        case 555:
          // print('Response body: ${response.body}');
          return SwitchUserModel.fromJson(parseData);
        default:
          throw Exception(parseData['message']);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitAcceptPoliciesApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/mobile/user/acceptPolicies', map);
    if (response.statusCode == 200) {
      print('/api/mobile/user/acceptPolicies ${response.body}');
      // var parseData = json.decode(response.body);
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        var parseData = json.decode(response.body);
        if (parseData['code'] != 200)
          throw Exception(parseData['message']);
        else
          return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitforgetPasswordAPI(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/mobile/user/forgotPassword', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResetModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitAddEventApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/event/createEvent', map);
    // var parseData = json.decode(response.body);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return parseData;
    }
    // if (response.statusCode == 200) {
    //   print('Response body: ${response.boody}');
    //   var parseData = json.decode(response.body);
    //   if (parseData['code'] != 200)
    //     throw Exception(parseData['message']);
    //   else
    //     return parseData;
    // }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitEventViewIdApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/event/viewEvent', map);
    if (response.statusCode == 200) {
      print(response.body);
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return EventModel.fromJson(parseData['data']);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitDeleteEventIdApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/event/deleteEvent', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return response.body;
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitUserAPI(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/user/register', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return parseData;
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitCompanyApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/user/register', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return parseData;
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitEventsListAPI(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/event/eventList', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return EventListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitUserEventsListAPI(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/event/allEvents', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return EventListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitEventInterestedAPI(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/event/interestList', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return EventListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitEventFavouriteApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/mobile/event/favouriteList', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return EventListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitEventUpdateApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/event/updateEvent', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitAddEventBookNowApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/event/addBooked', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return parseData['message'];
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitEventBookNowListApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/mobile/event/getBookedEvents', map);
    if (response.statusCode == 200) {
      print('BookedEents: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return EventListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitEventBookListApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/event/bookedEvent', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return EventListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitViewApplicantsApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/applicant/list', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return Applicant.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

addFavouriteApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/event/addFavourite', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return parseData['message'];
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitRemoveFavouriteApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/mobile/event/removeFavourite', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return parseData['message'];
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitAddInterestedApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/event/addInterest', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitRemoveInterestedApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/mobile/event/removeInterest', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return parseData['message'];
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitTimeZoneApi() async {
  try {
    var response = await baseServiceGet(
      '/api/v1/timezone/list',
    );
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return parseData;
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitCompanyJobListApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/job/list', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return JobListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitReadedApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/applicant/isReaded', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return IsReaded.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitJobCompanyDetailApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/job/details', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return JobListDetailModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitApplyJobApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/applicant/add', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitJobSaveApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/savedjob/add', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        return parseData['message']; // throw Exception(parseData['message']);
      else
        return parseData['message'];
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitJobRemoveApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/savedjob/remove', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        return parseData['message']; // throw Exception(parseData['message']);
      else
        return parseData['message'];
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitJobSaveListApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/savedjob/list', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        return parseData['message']; // throw Exception(parseData['message']);
      else
        return JobListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitJobAppliedJobsListApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/jobapplied/list', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        return parseData['message']; // throw Exception(parseData['message']);
      else
        return JobListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

//companyprofile Api
hitCompanyProfileApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/company/details', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        return parseData['message']; // throw Exception(parseData['message']);
      else
        return CompanyDetail.fromJson(parseData['data']);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitCountryApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/mobile/country/getAllCountry', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        return parseData['message']; // throw Exception(parseData['message']);
      else
        return CountryModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitServiceListApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/service/list', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        return parseData['message']; // throw Exception(parseData['message']);
      else
        return ServiceModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitCompanyProfileUpdateApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/company/update', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        return parseData['message']; // throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitUserProfileApi(Map<String, dynamic> map) async {
  try {
    print(map);
    var response = await baseServicePost('/api/v1/endUser/details', map);
    log('Response body:userProfile ${response.body}');
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return UserModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitPostcodeApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/user/findCityByZipcode', map);

    var parseData = json.decode(response.body);
    switch (parseData['code']) {
      case 200:
        // print('Response body: ${response.body}');
        return PostalCodeModel.fromJson(parseData);
      case 400:
        throw Exception(parseData['message']);
      case 401:
        throw Exception(parseData['message']);
      case 404:
        throw Exception(parseData['message']);
      case 403:
        throw Exception(parseData['message']);
      case 500:
        throw Exception(parseData['message']);
      default:
        throw Exception(parseData['message']);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetQualificationApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/qualification/list', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        return parseData['message']; // throw Exception(parseData['message']);
      else
        return QualificationModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetSkillApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/skill/list', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        return parseData['message']; // throw Exception(parseData['message']);
      else
        return SkillModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitUserProfileUpdateApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/endUser/update', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        return parseData['message']; // throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

//tripApi
hitTripPlannerListApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/trip/list', map);
    if (response.statusCode == 200) {
      log('Response brij: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        return parseData['message']; // throw Exception(parseData['message']);
      else
        return TripPlannerList.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitTripPlannerDetailApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/trip/details', map);
    if (response.statusCode == 200) {
      log('ResponseResponseResponse body000: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        return parseData['message']; // throw Exception(parseData['message']);
      else
        return TripViewDetails.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitTrackMapDetail(Map<String, dynamic> map, sourceLat, sourceLng,
    destinationLat, destinationLng) async {
  try {
    var response = await TomServiceGet(
        "https://api.tomtom.com/routing/1/calculateRoute/$sourceLat,$sourceLng,:$destinationLat,$destinationLng/json?",
        map);
    var parseData = json.decode(response.body);
    return RouteModel.fromJson(parseData);
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetPosts(Map<String, dynamic> map) async {
  try {
    print(map);
    var response =
        await baseServicePost('/api/mobile/post/homePagePostList', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return PostListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitUploadPost(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/post/add', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return PostUploadModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitPostUpdate(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/post/update', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitLikeDislike(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/like/add', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return LikePostModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetComments(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/comment/list', map);
    if (response.statusCode == 200) {
      print('/api/mobile/comment/list: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return CommentsModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetReComments(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/comment/list', map);
    if (response.statusCode == 200) {
      print('ReComments body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ReCommentsListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitPostComment(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/comment/add', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return response;
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitPostReComment(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/reComment/add', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitDeletePost(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/post/delete', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitPostReport(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/post/report', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitSharePost(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/post/share', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

//Posted

hitResetotpPassword(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/user/resetPassword', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitRegistionOtp(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/user/verify_otp', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return parseData;
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitTimezoneApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/timezone/list', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return TimezoneModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitCheckToken(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/user/checkToken', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return parseData;
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitResendOpt(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/user/resendOTP', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return response;
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitViewStoppage(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/trip/getHosStoppageList', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ViewMarkerModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitAddStoppage(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/trip/addStoppage', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return response;
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitgetStoppageApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/trip/getStopages', map);
    if (response.statusCode == 200) {
      print('/api/mobile/trip/getStopage body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return GetServiceMarkerModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitgetRemoveMarkerApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/trip/removeMarker', map);
    if (response.statusCode == 200) {
      return response;
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitgetDriverApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/driver/searchDriverByName', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return DriverListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitgetOtherDriverApi(Map<String, dynamic> map) async {
  print(map);
  try {
    var response =
        await baseServicePost('/api/v1/driver/searchAnotherDriverByName', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return OtherDriverListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetTruckApi(Map<String, dynamic> map) async {
  print(map);
  try {
    var response = await baseServicePost('/api/v1/truck/list', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return TruckListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetTrailerApi(Map<String, dynamic> map) async {
  print(map);
  try {
    var response = await baseServicePost('/api/v1/truck/list', map);
    if (response.statusCode == 200) {
      print('Response trail;er body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return TrailerListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetDriverDeatilApi(Map<String, dynamic> map) async {
  print(map);
  try {
    var response = await baseServicePost('/api/v1/endUser/details', map);
    if (response.statusCode == 200) {
      print('Response trail;er body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return DriverDetailListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetTruckDeatilApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/truck/details', map);
    if (response.statusCode == 200) {
      print(' ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return TruckDetailListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitCreateTripPlannerAPi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/trip/create', map);
    if (response.statusCode == 200) {
      print(' ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return response;
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetRecommendations(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/mobile/user/getSuggestion/getInvites', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return RecommendationModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetJobInvitationApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/endUser/jobInvite', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return JobInvitationModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetGroupInvitationApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/mobile/user/getSuggestion/getInvites', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return GroupInvitationModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetInvitedConnections(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/invite/list', map);

    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return InvitedConnectionsModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetGroupInvitedConnections(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/mobile/group/memberInvite/list', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return GroupInviteMenberModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitPostGroupInvitedConnections(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/group/sendInvite', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetRemoveInvitedConnections(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/group/removeMember', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetMyGroups(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/group/list', map);

    var parseData = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        // print('Response body: ${response.body}');

        // print('Response body: ${response.body}');
        return MyGroupsModel.fromJson(parseData);
      case 400:
        throw Exception(parseData['message']);
      case 401:
        return GroupModel.fromJson(parseData);

      case 404:
        return MyGroupsModel.fromJson(parseData);
      case 403:
        throw Exception(parseData['message']);
      case 500:
      default:
        throw Exception(parseData['message']);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetMyFriends(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/mobile/invite/myConnectionList', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return MyFriendsModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetSalesPersonList(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/chat/salesPersonList', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return NewConversationList.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetGroupFriend(Map<String, dynamic> map) async {
  try {
    print(map);
    var response = await baseServicePost('/api/v1/chat/salesPersonList', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return GroupFriendList.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetUserDetail(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/mobile/user/profileWithPost', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return UserDetailModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitConnectPeople(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/invite/sendInvite', map);

    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitRemoveInvited(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/invite/decline', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitRemoveGroup(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/group/removeMember', map);

    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitRemoveFriend(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/groupinvite/removeConnection', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitCreateGroup(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/group/add', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitUpdateGroup(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/group/update', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGroupDetail(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/group/detail', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return GroupDetailsList.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitOpenGroup(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/mobile/group/detailsWithPost', map);
    var parseData = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        print('Response body: ${response.body}');

        // print('Response body: ${response.body}');
        return GroupModel.fromJson(parseData);
      case 400:
        throw Exception(parseData['message']);
      case 401:
        return GroupModel.fromJson(parseData);
      case 403:
        throw Exception(parseData['message']);
      case 500:
      default:
        throw Exception(parseData['message']);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitPostInGroup(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/post/add', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitSendInviteMember(
  Map<String, dynamic> map,
) async {
  try {
    var response = await baseServicePost('/api/v1/invitation/company', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);

      switch (parseData['code']) {
        case 200:
          return ResponseModel.fromJson(parseData);

        case 401:
          return ResponseModel.fromJson(parseData);
        case 404:
          return ResponseModel.fromJson(parseData);
        default:
          return throw Exception(parseData['message']);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitDeleteByCom(
  Map<String, dynamic> map,
) async {
  try {
    var response = await baseServicePost(
        '/api/v1/invitation/invitationDeleteByCompany', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);

      switch (parseData['code']) {
        case 200:
          return ResponseModel.fromJson(parseData);
        case 401:
          return ResponseModel.fromJson(parseData);
        case 404:
          return ResponseModel.fromJson(parseData);
        default:
          return throw Exception(parseData['message']);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitLikeList(
  Map<String, dynamic> map,
) async {
  try {
    var response = await baseServicePost('/api/mobile/like/list', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return LikeListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitInviteAcceptApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/invite/accept', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitAcceptJobOfferApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/endUser/acceptOffer', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitRejectOfferApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/endUser/rejectOffer', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitAcceptOfferApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/endUser/jobInvite', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitInviteDeclineApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/invite/decline', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGroupMemberList(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/group/memberList', map);

    var parseData = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        // print('Response body: ${response.body}');
        return GroupMemberListModel.fromJson(parseData);
      case 400:
        throw Exception(parseData['message']);
      case 401:
        throw Exception(parseData['message']);
      case 403:
        throw Exception(parseData['message']);

      case 404:
        return GroupMemberListModel.fromJson(parseData);
      case 500:
      default:
        throw Exception(parseData['message']);
    }

    // }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

// hitGroupRemoveMember(Map<String, dynamic> map) async {
//   try {
//     var response =
//     await baseServicePost('/api/mobile/group/removeMember', map);
//     if (response.statusCode == 200) {
//       print('Response body: ${response.body}');
//       var parseData = json.decode(response.body);
//       if (parseData['code'] != 200)
//         throw Exception(parseData['message']);
//       else
//         return ResponseModel.fromJson(parseData);
//     }
//   } on SocketException {
//     throw Exception('Network Issue !!');
//   }
// }

hitGroupRemoveMember(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/group/removeMember', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

Future<WeatherModel> hitWeather(double lat, double lon) async {
  //String url = 'https://api.openweathermap.org/data/2.5/find?units=imperial&lat=$lat&lon=$lon&cnt=50&appid=a24ba550dd13b1b2b0c0752ed2a9e7df';
  String url =
      'https://api.weatherapi.com/v1/forecast.json?key=2ce76fc3d0f2418eb33221421222104&q=$lat,$lon&days=14&aqi=yes&alerts=yes&hour=0';
  //print(url);
  var response = await http.get(Uri.parse(url));
  print('Response body: ${response.body}');
  var parseData = json.decode(response.body);
  return WeatherModel.fromJson(parseData);
}

hitServiceList(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/service/list', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ServiceListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitViewServiceList(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/service/details', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ViewServiceList.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitUserServiceList(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/service/serviceListData', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ServiceListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitChangePassword(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/user/changePassword', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetWazeMap(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/markericon/markerIcons', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return WazeModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitAddMarkerWazeMap(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/markericon/addWazeIcon', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetAllMarkerWazeMap(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/markericon/wazeIconList', map);
    if (response.statusCode == 200) {
      print('____________Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return GetWazeMarker.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}
// E-commerce_Api

hitGetCategoryApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/category/list', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return EcommerceCategoryModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetProductListApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/product/list', map);
    if (response.statusCode == 200) {
      print('Response body Truck: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ProductListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitAddWishlist(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/wishlist/addWishlist', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitRemoveWishlist(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/mobile/wishlist/removeWishlist', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitBrandListApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/brand/list', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return BrandListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitModelListApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/model/list', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ModelList.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitSubCategoryApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/category/subCategoryList', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return SubCategoryList.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitWazeMarkerActionApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/markericon/wazeMarkerAction', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitProductViewApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/product/details', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ProductView.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitQuestionAnswerApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/review/questionAnswerlist', map);
    if (response.statusCode == 200) {
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return QuestionAnswerModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitSellerRatingApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/product/overAllSellerRating', map);
    if (response.statusCode == 200) {
      print('Response overAllSellerRating: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return SellerRatingModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitSimilarProductApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/product/similerProduct', map);
    if (response.statusCode == 200) {
      print('similar body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return SimilarProduct.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitWishListApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/wishlist/list', map);
    if (response.statusCode == 200) {
      print('similar body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return WishListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitQuestionApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/review/addQuestions', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

///Activity

hitActivityLogApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/user/loginHistory', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ActivityLog.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitRemoveDocumentApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/endUser/deleteDriverDocs', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitCompanyLeaveListApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/leftreason/list', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ReasonLeaveListModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitCompanyLeaveApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/userleft/leftUser', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hituploadDocumentApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/endUser/uploadDocs', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitReasonListApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/leftreason/ReasonList', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ReasonLeaveListModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitReasonCancelApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/trip/cancelTrip', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitManageTeanApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/trip/companyDriverList', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ManageTeam.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitCompanyTeamApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/endUser/list', map);
    if (response.statusCode == 200) {
      log('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return CompanyManageTeamModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitRemoveManageTeamApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/userleft/leftUser', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitUserLeftCompanyApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/userleft/leftUserList', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return UserLeftCompanyModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitFleetManagerListApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/truck/list', map);
    if (response.statusCode == 200) {
      log('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return FleetManagerModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitFleetManagerDetailApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/truck/details', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return FleetManagerDetailModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitSellerProductListApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/product/productListAdmin', map);
    if (response.statusCode == 200) {
      print('Response body00000: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return SellerProductList.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

SellerQuestionAnswerApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/mobile/review/questionList', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return SellerQuestionAnswerModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

SellerViewQuestionAnswerApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/review/questionDetail', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ViewQuestionAnswerModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

AnsweredBySellerApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/review/AnsweredBySeller', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

SellerRatingGivenByCustomerApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost(
        '/api/v1/product/sellerRatingGivenByCustomer', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return SellerRatingGivenByCustomerModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

SellerQyestionDeleteApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/mobile/review/questionDelete', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

SellerManageTeamModelApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/endUser/salesPersonlist', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return SellerManageTeamModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

SellerRatingTokenApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/product/sellerRatingToken', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return AddSellerRatingModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

SnowWeatherApi(Map<String, dynamic> map, String days) async {
  try {
    var response = await baseServicePost('/api/v1/forecast/snowDay$days', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return SnowModelList.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

ThunderWeatherApi(Map<String, dynamic> map, String days) async {
  try {
    var response =
        await baseServicePost('/api/v1/forecast/thunderDay$days', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ThunderModelList.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

ForecastWeatherApi(Map<String, dynamic> map, String days) async {
  try {
    var response = await baseServicePost('/api/v1/forecast/TempDay$days', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ForecastWeatherModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

PrecipitationtWeatherApi(Map<String, dynamic> map, String days) async {
  try {
    var response = await baseServicePost('/api/v1/forecast/precoDay$days', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return PrecipitationtWeatherModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

IndustryListApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/industry/list', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return IndustryList.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

SellerProfileApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/user/sellerDetails', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return SellerProfileModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

sharPostGroupApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/post/add', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

contactUsFormApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/otherservices/savecontactusdata', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

commentDelete(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/comment/delete', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

commentEditApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/comment/edit', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

JoinGroupApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/group/join', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

groupActionApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/mobile/group/requestRespond', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

groupPrivateRequestApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/mobile/group/requestAdmin', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

SellerDashBordApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/review/numberOfQuestion', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return SellerDashBoardModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

NotificationModelApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/notification/list', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);

      switch (parseData['code']) {
        case 200:
          // print('Response body: ${response.body}');
          return NotificationModel.fromJson(parseData);
        case 400:
        // throw Exception(parseData['message']);
        case 401:
        // throw Exception(parseData['message']);
        case 404:
        // throw Exception(parseData['message']);
        case 403:
        // print('Response body: ${response.body}');
        // throw Exception(parseData['message']);
        case 555:
          throw Exception(parseData['message']);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

readAllNotification(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/notification/readAll', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

// readAllNotification(Map<String, dynamic> map) async {
//   try {
//     var response = await baseServicePost('/api/v1/notification/readAll', map);
//     if (response.statusCode == 200) {
//       print('Response body: ${response.body}');
//       var parseData = json.decode(response.body);
//       if (parseData['code'] != 200)
//         throw Exception(parseData['message']);
//       else {
//         return NotificationModel.fromJson(parseData);
//       }
//     }
//   } on SocketException {
//     throw Exception('Network Issue !!');
//   }
// }

hitAccountInformationApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/user/accountInfo', map);
    if (response.statusCode == 200) {
      var parseData = json.decode(response.body);
      print("7978787787878787878${response.body}");
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return AccountDetailsModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitLogoutApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/user/logout', map);
    if (response.statusCode == 200) {
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

///chat/newConversation
hitGetConversations(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/chat/getMyConversations', map);
    if (response.statusCode == 200) {
      print('getMyConversations body 1: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ConversationListModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitDeleteConversations(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/chat/deleteMsg', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitUserBlockApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/chat/blockUser', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitCreateConversationApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/chat/newConversation', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return SingleConversationChatListModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetChatMessageApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/chat/getMessages', map);
    if (response.statusCode == 200) {
      print('getMessage body: ${response.body}');

      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return MessagesListModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetchatCoversationDetails(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/chat/getMyConversationDetails', map);
    if (response.statusCode == 200) {
      print('getMyConversationDetails body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ChatConversationModelDetail.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGetGroupDetailWithMembers(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/chat/getGroupDetailWithMembers', map);
    if (response.statusCode == 200) {
      print('getMyConversationDetails body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ChatGroupViewModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitAdminSettingMessage(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/chat/updateSetting', map);
    if (response.statusCode == 200) {
      print('updateSetting body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitAdminRemoveMember(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/chat/leftOrRemove', map);
    if (response.statusCode == 200) {
      print('updateSetting body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitGroupViewUpdate(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/chat/update', map);
    if (response.statusCode == 200) {
      print('updateSetting body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitAddGroupListMember(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/chat/teamMemberListForGroup', map);
    if (response.statusCode == 200) {
      print('updateSetting body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return GroupViewAddMemberList.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitAddMenber(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/chat/addMember', map);
    if (response.statusCode == 200) {
      print('updateSetting body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitMakeGroupAdmin(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost('/api/v1/chat/adminSetting', map);
    if (response.statusCode == 200) {
      print('updateSetting body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else {
        return ResponseModel.fromJson(parseData);
      }
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitTruckApi(Map<String, dynamic> map) async {
  print(map);
  try {
    var response = await baseServicePost('/api/v1/truck/driverFleetList', map);
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return TruckListModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitTripCreateApi(Map<String, dynamic> map) async {
  print(map);
  try {
    var response = await baseServicePost('/api/v1/trip/addDriverTrip', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitrTripHistoryApi(Map<String, dynamic> map) async {
  print(map);
  try {
    var response = await baseServicePost('/api/v1/trip/driverTripHistory', map);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return TripHistoryModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitTomAPi(
    String date,
    double sourceLatitude,
    double sourceLongitude,
    double destinationLatitude,
    double destinationLongitude,
    String datearrive,
    tomWidth,
    tomWeight,
    tomheight,
    HazmatLoadValue) async {
  try {
    var url =
        "https://api.tomtom.com/routing/1/calculateRoute/${sourceLatitude},${sourceLongitude}:${destinationLatitude},${destinationLongitude}/json?maxAlternatives=1&instructionsType=text&language=en-US&routeRepresentation=polyline&sectionType=travelMode&key=FAwecAoL8qcVNzRyX18RPYKkcfrGTvdB&routeType=eco&traffic=true&${datearrive}&avoid=unpavedRoads&travelMode=truck&vehicleEngineType=combustion&vehicleWeight=${tomWeight}&vehicleWidth=${tomWidth}&vehicleHeight=${tomheight}&vehicleCommercial=true${HazmatLoadValue == null ? '' : '&vehicleLoadType=' "${HazmatLoadValue}"}";
    var response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      var parseData = json.decode(response.body);
      if (response.statusCode != 200)
        throw Exception("Network Issue");
      else
        return RouteModel.fromJson(parseData);
    } else {
      throw Exception("No Route Found");
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitDeactivateAccountApi(Map<String, dynamic> map) async {
  print(map);
  try {
    var response = await baseServicePost('/api/v1/user/deleteUserAccount', map);
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitDefaultLanguageApi(Map<String, dynamic> map) async {
  print(map);
  try {
    var response =
        await baseServicePost('/api/mobile/user/setDefaultLanguage', map);
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

// hitSubscriptionPlan(Map<String, dynamic> map) async {
//   print(map);
//   try {
//     var response = await baseServicePost(
//         '/api/v1/subscriptionplan/getSoloUserPlanList', map);
//
//     if (response.statusCode == 200) {
//       print('getSoloUserPlanList: ${response.body}');
//       var parseData = json.decode(response.body);
//       if (parseData['code'] != 200)
//         throw Exception(parseData['message']);
//       else
//         return SubscriptionPlanModel.fromJson(parseData);
//     }
//   } on SocketException {
//     throw Exception('Network Issue !!');
//   }
// }

hitSubscriptionPlanAddToCart(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/subscriptionplan/planAddToCart', map);
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return AddToCartModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

// hitSubscriptionItemCart(Map<String, dynamic> map) async {
//   try {
//     var response =
//         await baseServicePost('/api/v1/subscriptionplan/itemIntoCart', map);
//
//     if (response.statusCode == 200) {
//       print('/api/v1/subscriptionplan/itemIntoCart: ${response.body}');
//       var parseData = json.decode(response.body);
//       if (parseData['code'] != 200)
//         throw Exception(parseData['message']);
//       else
//         return CartModel.fromJson(parseData);
//     }
//   } on SocketException {
//     throw Exception('Network Issue !!');
//   }
// }

hitRemoveItemCart(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost(
        '/api/v1/subscriptionplan/removeItemFromCart', map);

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitPromoCodeList(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/subscriptionplan/promocodeList', map);

    if (response.statusCode == 200) {
      print('promocodeList: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return PromoCodeModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitPromoCodeApply(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost(
        '/api/v1/subscriptionplan/applyPromocodeOnApp', map);

    if (response.statusCode == 200) {
      print('applyPromocodeOnApp: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ApplyPromoCodeModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitRemovePromoCode(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/subscriptionplan/removePromocode', map);

    if (response.statusCode == 200) {
      print('removePromocode: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitPaymentApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseStripPost('https://api.stripe.com/v1/payment_intents', map);

    if (response.statusCode == 200) {
      var parseData = json.decode(response.body);
      if (parseData['error'] != null)
        throw Exception(parseData['message']);
      else
        return PaymentSuccessModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitCountCartItemApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/subscriptionplan/cartItems', map);

    if (response.statusCode == 200) {
      print('promocodeList: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return CartItemModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitPaymentSuccessApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/subscriptionplan/mobilePayment', map);
    if (response.statusCode == 200) {
      print('subscriptionplan/mobilePayment: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return SubscriptionPaymentSuccessfulModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitMyPlanApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/subscriptionplan/myMobilePlan', map);
    if (response.statusCode == 200) {
      print('sub: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return MyPlanModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitMyPlanCancelApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/subscriptionplan/cancelMobilePlan', map);
    if (response.statusCode == 200) {
      print('sub: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitFreePlanApi(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/subscriptionplan/freePayment', map);
    if (response.statusCode == 200) {
      print('sub: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return SubscriptionPaymentSuccessfulModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

// hitUpgradePlanListApi(Map<String, dynamic> map) async {
//   try {
//     var response =
//         await baseServicePost('/api/v1/subscriptionplan/getMyPlans', map);
//     if (response.statusCode == 200) {
//       print('sub: ${response.body}');
//       var parseData = json.decode(response.body);
//       if (parseData['code'] != 200)
//         throw Exception(parseData['message']);
//       else
//         return PlanUpgradeModel.fromJson(parseData);
//     }
//   } on SocketException {
//     throw Exception('Network Issue !!');
//   }
// }

hitUpgradePlanApi(Map<String, dynamic> map) async {
  try {
    var response = await baseServicePost(
        '/api/v1/subscriptionplan/upgradeMobilePayment', map);
    if (response.statusCode == 200) {
      print('sub: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['code']);
      else
        return PlanUpgradeSuccessModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitValidateReceiptIos(
  Map<String, dynamic> map,
  String url,
) async {
  try {
    print("map>>>>>>  hitValidateReceiptIos  ");
    var response = await baseItunesPost(url, map);
    print("response>> ${response}");
    if (response.statusCode == 200) {
      print('ValidateReceiptIos: ${response.statusCode}');
      var parseData = json.decode(response.body);
      if (response.statusCode != 200)
        throw Exception(parseData['Payment Failed']);
      else
        return response;
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

Future hitSubscriptionPlanPayment(Map<String, dynamic> map) async {
  try {
    log("hitSubscriptionPlanPayment>> $map");
    var response =
        await baseServicePost('/api/mobile/subscriptionplan/payment', map);
    print("0000000000000000000000${response.body}");

    if (response.statusCode == 200) {
      print('sub: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitMyPlan(Map<String, dynamic> map) async {
  try {
    var response =
        await baseServicePost('/api/v1/subscriptionplan/myPlan', map);
    if (response.statusCode == 200) {
      print('myPlan: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ConstantModell.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitPrivacyPolicyModelApi(
  Map<String, dynamic> map,
) async {
  print(map);
  try {
    var response = await baseServicePost('/api/v1/staticPages/getContent', map);
    if (response.statusCode == 200) {
      print('sub: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return PrivacyPolicyModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitAddFleetManagerApi(
  Map<String, dynamic> map,
) async {
  print(map);
  try {
    var response = await baseServicePost('/api/v1/truck/add', map);
    if (response.statusCode == 200) {
      print('sub: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitAddVehiclesApi(
  Map<String, dynamic> map,
  String text,
) async {
  print(map);
  try {
    var response = await baseServicePosts(
        "https://vpic.nhtsa.dot.gov/api/vehicles/decodevinvalues/" +
            text +
            "?format=json",
        map);
    if (response.statusCode == 200) {
      log('sub vin data: ${response.body}');
      var parseData = json.decode(response.body);
      return VinModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitDeleteFleetManagerApi(
  Map<String, dynamic> map,
) async {
  print(map);
  try {
    var response = await baseServicePost('/api/v1/truck/delete', map);
    if (response.statusCode == 200) {
      print('sub: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitUpdateFleetManagerApi(
  Map<String, dynamic> map,
) async {
  print(map);
  try {
    var response = await baseServicePost('/api/v1/truck/update', map);
    if (response.statusCode == 200) {
      print('sub: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}

hitStatusApi(
  Map<String, dynamic> map,
) async {
  print(map);
  try {
    var response = await baseServicePost('/api/v1/truck/status', map);
    if (response.statusCode == 200) {
      print('sub: ${response.body}');
      var parseData = json.decode(response.body);
      if (parseData['code'] != 200)
        throw Exception(parseData['message']);
      else
        return ResponseModel.fromJson(parseData);
    }
  } on SocketException {
    throw Exception('Network Issue !!');
  }
}
