import 'dart:convert';
import 'dart:io';
// ادراج المكتبه التي نضع بها قيم ثابته على مستوى المشروع
import '../helper/const.dart';
// قمنا بادراج حزمة المكتبة التي سوف تساعدنا في طلب البيانات من ال api و اعطينها اسم مختصر http
import 'package:http/http.dart' as http;
// الكلاس الذي سيقوم بتحويل ضيغة تقرير الحضور من Json الى Object تفهما لغة Dart
import 'attendance.dart';

class AttendancesServices {
  // طلب تقرير الحضور خلال اليوم الحالي
  Future<List<Attendance>> getAttendancesReport(int departmentId) async {
    // طلب التقرير من السيرفر
    final response = await http
        .get('$ApiURL/Attendances/GetAttendances?departmentId=$departmentId',
            // البيانات التي يرجعها الطلب تكون بصيغة json
            headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    // رقم 200 معناه بانه تم الاتصال بالسيرفر وجلب التقرير بنجاح
    if (response.statusCode == 200) {
      // تحويل النص الى Object من نوع Json من أجل تسهيل استخراج البيانات مثل رقم الموظف و الوقت و حالة الحضور
      Iterable data = json.decode(response.body);
      // ربط البيانات القادمه من قاعدة البيانات على السيرفر و تحويلها الى قائمة Object
      return data.map((model) => Attendance.fromJson(model)).toList();
    } else {
      return null;
    }
  }

  // طلب تقرير الحضور خلال الشهر الحالي لموظف معين
  Future<List<Attendance>> getEmployeeAttendancesReport(int employeeId) async {
    // طلب التقرير من السيرفر
    final response = await http.get(
        '$ApiURL/Attendances/GetAttendances/Employee?employeeId=$employeeId',
        // البيانات التي يرجعها الطلب تكون بصيغة json
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    // رقم 200 معناه بانه تم الاتصال بالسيرفر وجلب التقرير بنجاح
    if (response.statusCode == 200) {
      // تحويل النص الى Object من نوع Json من أجل تسهيل استخراج البيانات مثل تاريخ اليوم و الوقت و حالة الحضور
      Iterable data = json.decode(response.body);
      // ربط البيانات القادمه من قاعدة البيانات على السيرفر و تحويلها الى قائمة Object
      return data.map((model) => Attendance.fromJson(model)).toList();
    } else {
      return null;
    }
  }

  // طلب تقرير الحضور خلال اليوم الحالي
  Future<Iterable> getAttendancesReportAsJson(int departmentId) async {
    // طلب التقرير من السيرفر
    final response = await http
        .get('$ApiURL/Attendances/GetAttendances?departmentId=$departmentId',
            // البيانات التي يرجعها الطلب تكون بصيغة json
            headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    // رقم 200 معناه بانه تم الاتصال بالسيرفر وجلب التقرير بنجاح
    if (response.statusCode == 200) {
      // تحويل النص الى Object من نوع Json من أجل تسهيل استخراج البيانات مثل رقم الموظف و الوقت و حالة الحضور
      return json.decode(response.body);
    } else {
      return null;
    }
  }
}
