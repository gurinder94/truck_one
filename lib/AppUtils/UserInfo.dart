import 'package:shared_preferences/shared_preferences.dart';

setUserInfo(String? id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('id', id!);
}

getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString('id');
}

setRoleInfo(String? rolename) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('roleName', rolename!);
}

setFireBaseToken(String fcmToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('FCM', fcmToken);
}

getFireBaseToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString('FCM');
}

setProfileComplete(bool profileComplete) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('profileComplete', profileComplete);
}

getProfileComplete() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getBool('profileComplete');
}

setCreateEvent(int createEvent) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('CreateEvent', createEvent);
}

setplanDate(bool planDate) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('PlanDate', planDate);
}

getplanDate() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('PlanDate');
}

setEventPlanData(bool planDate) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('EventPlan', planDate);
}

getEventPlanData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('EventPlan');
}

getCreateEvent() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('CreateEvent');
}

getRoleInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString('roleName');
}

setNameInfo(String? name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('name', name!);
}

setPolicyStatus(bool? policyStatus) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('PolicyStatus', policyStatus!);
}

getPolicyStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getBool('PolicyStatus');
}

getNameInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString('name');
}

setprofileInfo(String? ProfileImg) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('ProfileImg', ProfileImg!);
}

setProgressBar(int? ProfileImg) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('progressBar', ProfileImg!);
}

getProgressBar() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getInt('progressBar');
}

getprofileInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString('ProfileImg');
}

setCompanyId(String? CompanyId) async {
  print("asdjkdsakjdsajkadsjkjkldjkdladksjdksakdsajdksaadks${CompanyId}");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('CompanyId', CompanyId!);
}

getCompanyId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString('CompanyId');
}

setManageTeam(int manageTeam) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('ManageTeam', manageTeam);
}

getManageTeam() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString('ManageTeam');
}

setLanguage(String language) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('Language', language);
}

getLanguage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString('Language');
}

removeAllSharedPrefrerencesData() async {
  SharedPreferences prefrences = await SharedPreferences.getInstance();
  await prefrences.clear();
}

setWeatherPlanData(bool planDate) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('WeatherPlan', planDate);
}

getWeatherPlanData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('WeatherPlan');
}

setGpsPlanData(bool planDate) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('GpsPlan', planDate);
}

getGpsPlanData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('GpsPlan');
}

setWeatherValue(int planDate) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('showWeather', planDate);
}

getWeatherValue() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('showWeather');
}

setplanAmount(double value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setDouble("planAmount", value);
}

getplanAmount() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getDouble('planAmount');
}

removeData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('id');
  prefs.remove('planAmount');
  prefs.remove('showWeather');
  prefs.remove('GpsPlan');
  prefs.remove(' PlanDate');
  prefs.remove('EventPlan');
  prefs.remove('WeatherPlan');
  prefs.remove('Language');
  prefs.remove('ManageTeam');
  prefs.remove('CompanyId');
  prefs.remove('ProfileImg');
  prefs.remove('progressBar');
  prefs.remove('name');
  prefs.remove('roleName');
  prefs.remove('CreateEvent');
  prefs.remove('ProfileImg');
  prefs.remove('PolicyStatus');
  prefs.remove('profileComplete');
  prefs.remove('roleName');
  prefs.remove('FCM');
}
