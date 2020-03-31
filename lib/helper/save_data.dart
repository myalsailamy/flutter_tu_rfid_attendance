// ادراج المكتبه التي ستقوم بحفظ و تخزين البيانات على الجهاز الحالي
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tu_rfid_attendance/services/user_info.dart';

//حفظ و تذكر الاسم الخاص بالمستخدم على الجهاز
Future<bool> saveUserNamePreference(String userName) async {
  // عرفنا كائن الذي سيقوم بحفظ معلومات المستخدم الحالي على الجهاز
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // أخذنا اسم المستخدم الذي قام المستخدم بكتابته و خزناه بمفتاح user_name من أجل أن نستطيع لاحقاً استدعائه
  prefs.setString('user_name', userName);
  // ارجاع بنجاح العملية
  return true;
}

// عند تشغيل التطبيق لأول مره يتم الاستعلام اذا كان اسم المستخدم محفوظ بالجهاز و عرضه في خانة اسم المستخدم
Future<String> getUserNamePreference() async {
  // عرفنا كائن الذي سيقوم بحفظ معلومات المستخدم الحالي على الجهاز
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // user_name باسترجاع اسم المستخدم بالمفتاح الذي عرفناه
  return prefs.getString('user_name') ?? "";
}

// تخزين بيانات المستخدم الحالي لاستخدامها في مكان في التطبيق
Future<bool> saveUserInfoAsJson(String userInfoJson) async {
  // عرفنا كائن الذي سيقوم بحفظ معلومات المستخدم الحالي على الجهاز
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('save_user_info_json', userInfoJson);
  return true;
}

// استرجاع بيانات المستخدم الحالي من رقم وظيفي أو ايميل أو جوال لاستخدامها في التطبيق
Future<UserInfo> getUserInfoAsObject() async {
  // عرفنا كائن الذي سيقوم بحفظ معلومات المستخدم الحالي على الجهاز
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // save_user_info_json باسترجاع بيانات المستخدم بالمفتاح الذي عرفناه
  String dataJson = prefs.getString('save_user_info_json') ?? "";
  if (dataJson != null)
    return userInfoFromJson(dataJson);
  else
    return null;
}
