import 'dart:convert';
import 'dart:io';
// ادراج المكتبه التي نضع بها قيم ثابته على مستوى المشروع
import '../helper/const.dart';
// قمنا بادراج حزمة المكتبة التي سوف تساعدنا في طلب البيانات من ال api و اعطينها اسم مختصر http
import 'package:http/http.dart' as http;
// الكلاس الذي سيقوم بتحويل ضيغة تقرير الحضور من Json الى Object تفهما لغة Dart
import 'absence.dart';

class AbsenceAndLateServices {
  // طلب تقرير الغياب خلال اليوم الحالي
  Future<List<Absence>> getAbsencesTodayReport(int departmentId) async {
    // طلب التقرير من السيرفر
    final response = await http
        .get('$ApiURL/Attendances/GetAbsencesToday?departmentId=$departmentId',
            // البيانات التي يرجعها الطلب تكون بصيغة json
            headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    // رقم 200 معناه بانه تم الاتصال بالسيرفر وجلب التقرير بنجاح
    if (response.statusCode == 200) {
      // تحويل النص الى Object من نوع Json من أجل تسهيل استخراج البيانات ( اسم الموظف و التاريخ)
      Iterable data = json.decode(response.body);
      // ربط البيانات القادمه من قاعدة البيانات على السيرفر و تحويلها الى قائمة Object من  نوع Absence
      return data.map((model) => Absence.fromJson(model)).toList();
    } else {
      return null;
    }
  }

  // طلب تقرير المتأخرين خلال اليوم الحالي
  Future<List<Absence>> getLateEmployeesTodayReport(int departmentId) async {
    // طلب التقرير من السيرفر
    final response = await http.get(
        '$ApiURL/Attendances/GetLateEmployeesToday?departmentId=$departmentId',
        // البيانات التي يرجعها الطلب تكون بصيغة json
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    // رقم 200 معناه بانه تم الاتصال بالسيرفر وجلب التقرير بنجاح
    if (response.statusCode == 200) {
      // تحويل النص الى Object من نوع Json من أجل تسهيل استخراج البيانات ( اسم الموظف و التاريخ)
      Iterable data = json.decode(response.body);
      // ربط البيانات القادمه من قاعدة البيانات على السيرفر و تحويلها الى قائمة Object من  نوع Absence
      return data.map((model) => Absence.fromJson(model)).toList();
    } else {
      return null;
    }
  }

  // طلب تقرير الغياب خلال الأسبوع الحالي
  Future<List<Absence>> getAbsencesThisWeekReport(int departmentId) async {
    // طلب التقرير من السيرفر
    final response = await http.get(
        '$ApiURL/Attendances/GetAbsencesThisWeek?departmentId=$departmentId',
        // البيانات التي يرجعها الطلب تكون بصيغة json
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    // رقم 200 معناه بانه تم الاتصال بالسيرفر وجلب التقرير بنجاح
    if (response.statusCode == 200) {
      // تحويل النص الى Object من نوع Json من أجل تسهيل استخراج البيانات ( اسم الموظف و التاريخ)
      Iterable data = json.decode(response.body);
      // ربط البيانات القادمه من قاعدة البيانات على السيرفر و تحويلها الى قائمة Object من  نوع Absence
      return data.map((model) => Absence.fromJson(model)).toList();
    } else {
      return null;
    }
  }

  // طلب تقرير المتأخرين خلال الأسبوع الحالي
  Future<List<Absence>> getLateEmployeesThisWeekReport(int departmentId) async {
    // طلب التقرير من السيرفر
    final response = await http.get(
        '$ApiURL/Attendances/GetLateEmployeesThisWeek?departmentId=$departmentId',
        // البيانات التي يرجعها الطلب تكون بصيغة json
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    // رقم 200 معناه بانه تم الاتصال بالسيرفر وجلب التقرير بنجاح
    if (response.statusCode == 200) {
      // تحويل النص الى Object من نوع Json من أجل تسهيل استخراج البيانات ( اسم الموظف و التاريخ)
      Iterable data = json.decode(response.body);
      // ربط البيانات القادمه من قاعدة البيانات على السيرفر و تحويلها الى قائمة Object من  نوع Absence
      return data.map((model) => Absence.fromJson(model)).toList();
    } else {
      return null;
    }
  }

  // طلب تقرير الغياب خلال الشهر الحالي
  Future<List<Absence>> getAbsencesThisMonthReport(int departmentId) async {
    // طلب التقرير من السيرفر
    final response = await http.get(
        '$ApiURL/Attendances/GetAbsencesThisMonth?departmentId=$departmentId',
        // البيانات التي يرجعها الطلب تكون بصيغة json
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    // رقم 200 معناه بانه تم الاتصال بالسيرفر وجلب التقرير بنجاح
    if (response.statusCode == 200) {
      // تحويل النص الى Object من نوع Json من أجل تسهيل استخراج البيانات ( اسم الموظف و التاريخ)
      Iterable data = json.decode(response.body);
      // ربط البيانات القادمه من قاعدة البيانات على السيرفر و تحويلها الى قائمة Object من  نوع Absence
      return data.map((model) => Absence.fromJson(model)).toList();
    } else {
      return null;
    }
  }

  // طلب تقرير المتأخرين خلال الشهر الحالي
  Future<List<Absence>> getLateEmployeesThisMonthReport(
      int departmentId) async {
    // طلب التقرير من السيرفر
    final response = await http.get(
        '$ApiURL/Attendances/GetLateEmployeesThisMonth?departmentId=$departmentId',
        // البيانات التي يرجعها الطلب تكون بصيغة json
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    // رقم 200 معناه بانه تم الاتصال بالسيرفر وجلب التقرير بنجاح
    if (response.statusCode == 200) {
      // تحويل النص الى Object من نوع Json من أجل تسهيل استخراج البيانات ( اسم الموظف و التاريخ)
      Iterable data = json.decode(response.body);
      // ربط البيانات القادمه من قاعدة البيانات على السيرفر و تحويلها الى قائمة Object من  نوع Absence
      return data.map((model) => Absence.fromJson(model)).toList();
    } else {
      return null;
    }
  }
}
