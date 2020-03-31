import 'dart:convert';
import 'dart:io';
// ادراج المكتبه التي نضع بها قيم ثابته على مستوى المشروع
import '../helper/const.dart';
// الكلاس الذي سيقوم بتحويل نص بيانات الموظف من Json الى Object تفهما لغة Dart
import '../services/employee_info.dart';
// قمنا بادراج حزمة المكتبة التي سوف تساعدنا في طلب البيانات من ال api و اعطينها اسم مختصر http
import 'package:http/http.dart' as http;

class EmployeesServices {
  // تحميل قائمة موظفين الإدارة
  Future<List<EmployeeInfo>> loadEmployeesList(int departmentId) async {
    // طلب قائمة أسماء الموظفين من السيرفر
    final response =
        await http.get('$ApiURL/Employees?departmentId=$departmentId',
            // البيانات التي يرجعها الطلب تكون بصيغة json
            headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    // رقم 200 معناه بانه تم الاتصال بالسيرفر وجلب قائمة بيانات الموظفين بنجاح
    if (response.statusCode == 200) {
      // تحويل النص الى Object من نوع Json من أجل تسهيل استخراج البيانات مثل رقم الموظف و اسمه
      Iterable data = json.decode(response.body);
      // ربط البيانات القادمه من قاعدة البيانات على السيرفر و تحويلها الى قائمة Object
      return data.map((model) => EmployeeInfo.fromJson(model)).toList();
    } else {
      return null;
    }
  }
}
