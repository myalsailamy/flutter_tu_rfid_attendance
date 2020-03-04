import 'dart:io';

import 'package:flutter/material.dart';

// ادراج المكتبه التي نضع بها قيم ثابته على مستوى المشروع
import '../helper/const.dart';
// ادراج الكلاس الذي قمنا بتحديد ثيم التطبيق الخاص بنا من خطوط و ألوان ...الخ
import '../helper/project_theme.dart';
// قمنا بادراج حزمة المكتبة التي سوف تساعدنا في طلب البيانات من ال api و اعطينها اسم مختصر http
import 'package:http/http.dart' as http;
import '../services/user_info.dart';
import '../services/employee_info.dart';
import 'home_screen.dart';

class EditEmployeeInfo extends StatefulWidget {
  // قمنا بتعريف key كإسم للصفحة تعديل معلومات المستخدم من أجل استدعاء الشاشه للانتقال اليها
  static const id = "edit_employee_info";
  // متغير سوف يخزن بيانات المستخدم الحالية
  final String title;
  final UserInfo selectedUserInfo;
  EditEmployeeInfo({this.title, this.selectedUserInfo});

  @override
  _EditEmployeeInfoState createState() => _EditEmployeeInfoState();
}

class _EditEmployeeInfoState extends State<EditEmployeeInfo> {
// بيانات الموظف المستهدف تعديل بياناته
  EmployeeInfo selectedEmployee = EmployeeInfo();

  // قمنا بتعريف كنترول لحقل الايميل من أجل تسهيل أخذ البيانات من الحقل
  final empNoController = TextEditingController();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final rfCardIdController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  String _selectedGenderRadio = 'ذكر';
  // متغير لتخزين تاريخ الميلاد
  DateTime selectedDate = DateTime.now().add(Duration(days: -8000));
  bool sending = false;

  // عند بداية تشغيل شاشة التعديل
  @override
  void initState() {
    super.initState();
    // طلب بيانات الموظف المستهدف تعديل بياناته عن طريق البحث برقمه
    getEmployeeData(widget.selectedUserInfo.id);
  }

  // فكشن سوف تتواصل مع قاعدة البيانات لحذف الموظف
  Future<void> deleteEmployee(int employeeId) async {
    // تعريف طلب لرابط ال api
    //  البحث عن الموظف عن طريق رقمه في قاعدة البيانات
    final response = await http.delete('$ApiURL/Employees?id=$employeeId',
        // البيانات التي ترجع من الطلب تكون بصيغة json
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    print(response.statusCode);
    // رقم 200 معناه بانه تم الاتصال بنجاح و تم حذف الموظف
    if (response.statusCode == 200) {
      // الرجوع الى الرئيسيه بعد حذف الموظف
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      AppUtils.showSnackBar(
          message: "حصل خطأ غير متوقع، أو أن الهاتف غير متصل الشبكة",
          context: context,
          color: Colors.red);
    }
  }

  // فكشن سوف تتواصل مع قاعدة البيانات للاستعلام عن بيانات موظف
  Future<bool> getEmployeeData(int employeeId) async {
    // تعريف طلب لرابط ال api
    //  البحث عن الموظف عن طريق رقمه في قاعدة البيانات
    final response = await http.get('$ApiURL/Employees/$employeeId',
        // البيانات التي ترجع من الطلب تكون بصيغة json
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});

    // رقم 200 معناه بانه تم الاتصال بنجاح و تم الحصول على بيانات الموظف
    if (response.statusCode == 200) {
      selectedEmployee = employeeFromJson(response.body);
      // عرضنا البيانات في الحقول من أجل تعديلها
      setState(() {
        empNoController.text = selectedEmployee.empNo;
        phoneController.text = selectedEmployee.phone;
        fNameController.text = selectedEmployee.fName;
        lNameController.text = selectedEmployee.lName;
        _selectedGenderRadio = selectedEmployee.gender;
        userNameController.text = selectedEmployee.userName;
        passwordController.text = selectedEmployee.password;
        emailController.text = selectedEmployee.email;
        rfCardIdController.text = selectedEmployee.rfCardId;
        selectedDate = selectedEmployee.bod;
      });
      return true;
    } else {
      return false;
    }
  }

  // فكشن سوف ترسل بيانات الموظف التي تم تعديلها
  Future<bool> updateEmployeeData() async {
    setState(() {
      sending = true;
      AppUtils.showProgressDialog(context, "يتم حفظ التعديلات ...");
    });

    // اضافة البيانات التي تم عرضها للتعديل مره أخرى لبيانات الموظف لإرسالها الى السيرفر
    selectedEmployee.empNo = empNoController.text;
    selectedEmployee.phone = phoneController.text;
    selectedEmployee.fName = fNameController.text;
    selectedEmployee.lName = lNameController.text;
    selectedEmployee.gender = _selectedGenderRadio;
    selectedEmployee.userName = userNameController.text;
    selectedEmployee.password = passwordController.text;
    selectedEmployee.email = emailController.text;
    selectedEmployee.rfCardId = rfCardIdController.text;
    selectedEmployee.bod = selectedDate;

    // تعريف طلب لرابط ال api
    final response = await http.put('$ApiURL/Employees',
        // البيانات التي ترجع من الطلب تكون بصيغة json
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        //  ,تحويل كائن الموظف الى نص من نوع Json و نرسله مع الطلب في ال body
        body: employeeToJson(selectedEmployee));

    print(response.statusCode);

    Navigator.pop(context);
    // رقم 200 معناه بانه تم الاتصال بنجاح و تم اضافة الموظف الجديد
    if (response.statusCode == 200) {
      // الرجوع الى الرئيسيه بعد تعديل الموظف
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete_forever,
                color: Colors.black,
              ),
              onPressed: () async {
                await deleteEmployee(widget.selectedUserInfo.id);
              },
            )
          ],
          // زر الرجوع
          leading: IconButton(
            // أيقونة الرجوع
            icon: Icon(Icons.arrow_back, color: Colors.black),
            // عند الضغط على زر الرجوع فإنه يرجع للصفحة السابقة
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        // محتوى صفحة معلومات عن التطبيق
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Visibility(
                    visible: !sending,
                    child: Column(
                      children: <Widget>[
                        // مسافة بين الصورة التي بالأعلى و باقي الحقول
                        SizedBox(height: 10),
                        // حقل ادخال الإيميل
                        TextField(
                          controller: empNoController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(),
                            hintText: '12345',
                            labelText: 'الرقم الوظيفي',
                            prefixIcon: Icon(Icons.work, color: gold, size: 35),
                          ),
                        ),
                        // مسافة بين الحقول
                        SizedBox(height: 5),
                        TextField(
                          controller: rfCardIdController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(),
                            hintText: 'XXXXXXXXXXX3424',
                            labelText: 'رقم البطاقة RFID',
                            prefixIcon:
                                Icon(Icons.credit_card, color: gold, size: 35),
                          ),
                        ), // مسافة بين الحقول
                        // مسافة بين الحقول
                        SizedBox(height: 20),
                        TextField(
                          controller: fNameController,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            hintText: 'الاسم الأول فقط',
                            labelText: 'اسم الموظف الأول',
                            prefixIcon:
                                Icon(Icons.person, color: gold, size: 35),
                          ),
                        ),
                        SizedBox(height: 5),
                        TextField(
                          controller: lNameController,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(),
                            hintText: 'الاسم الاخير فقط',
                            labelText: 'اسم العائلة',
                            prefixIcon:
                                Icon(Icons.person, color: gold, size: 35),
                          ),
                        ),
                        SizedBox(height: 5),
                        FormField(
                          builder: (FormFieldState state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 10.0),
                                labelText: 'الجنس',
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Radio(
                                    value: 'ذكر',
                                    activeColor: gold,
                                    groupValue: _selectedGenderRadio,
                                    onChanged: (newValue) => setState(
                                        () => _selectedGenderRadio = newValue),
                                  ),
                                  Text('ذكر',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black)),
                                  SizedBox(width: 20),
                                  Radio(
                                    value: 'أنثى',
                                    activeColor: gold,
                                    groupValue: _selectedGenderRadio,
                                    onChanged: (newValue) => setState(
                                        () => _selectedGenderRadio = newValue),
                                  ),
                                  Text(
                                    'أنثى',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: FormField(
                            builder: (FormFieldState state) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 10.0),
                                  prefixIcon: Icon(Icons.calendar_today,
                                      color: gold, size: 35),
                                  labelText: 'تاريخ الميلاد',
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                        "${selectedDate.toLocal()}"
                                            .split(' ')[0],
                                        style: TextStyle(fontSize: 18)),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        // مسافة بين الحقول
                        SizedBox(height: 20),
                        TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                          decoration: InputDecoration(
                            counterText: '',
                            counterStyle: TextStyle(fontSize: 0),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(),
                            hintText: '055XXXXXXXX',
                            labelText: 'الجوال',
                            prefixIcon:
                                Icon(Icons.phone, color: gold, size: 35),
                          ),
                        ),
                        // مسافة بين الحقول
                        SizedBox(height: 5),
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(),
                            hintText: 'example@gmail.com',
                            labelText: 'البريد الإلكتروني',
                            prefixIcon:
                                Icon(Icons.email, color: gold, size: 35),
                          ),
                        ),

                        SizedBox(height: 20),
                        TextField(
                          controller: userNameController,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(),
                            hintText: ' (تسجيل الدخول)',
                            labelText: 'اسم المستخدم',
                            prefixIcon: Icon(Icons.account_circle,
                                color: gold, size: 35),
                          ),
                        ),
                        // مسافة بين الحقول
                        SizedBox(height: 5),
                        TextField(
                          controller: passwordController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(),
                            hintText: ' (تسجيل الدخول)',
                            labelText: 'كلمة المرور',
                            prefixIcon: Icon(Icons.lock, color: gold, size: 35),
                          ),
                        ),
                        // مسافة بين الحقول
                        SizedBox(height: 15),
                        // زر  كلمة المرور
                        RaisedButton(
                          child: Text(
                            "تحديث البيانات",
                            style: TextStyle(fontSize: 25),
                          ),
                          onPressed: () async {
                            if (await updateEmployeeData() == true) {
                              setState(() {
                                AppUtils.showSnackBar(
                                    message: 'تم تعديل بيانات الموظف بنجاح',
                                    context: context,
                                    color: Colors.green);
                                sending = false;
                              });
                            } else {
                              setState(() {
                                AppUtils.showSnackBar(
                                    message:
                                        "حصل خطأ غير متوقع، أو أن الهاتف غير متصل الشبكة",
                                    context: context,
                                    color: Colors.red);
                                sending = false;
                              });
                            }
                          },
                          color: gold,
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 60),
                          textColor: Colors.white,
                          splashColor: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }

  // فكشن استدعاء اداة اختيار التاريخ
  Future<Null> _selectDate(BuildContext context) async {
    // استدعاء اداة اختيار التاريخ
    final DateTime picked = await showDatePicker(
        context: context,
        // القيمة الافتراضيه عند العرض لأول مره يتم اخذها من المتغير selectedDate
        initialDate: selectedDate,
        // يبدأ من سنة 1950
        firstDate: DateTime(1950),
        // حتى اليوم الحالي
        lastDate: DateTime.now());
    // في حالة تم اغلاق نافذة التاريخ ولم يتم اختيار أي تاريخ لا يتم تغيير أي شيء بالشاشة
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
