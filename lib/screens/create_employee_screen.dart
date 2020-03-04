import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/employee_info.dart';
import '../services/user_info.dart';
// ادراج المكتبه التي نضع بها قيم ثابته على مستوى المشروع
import '../helper/const.dart';
// ادراج الكلاس الذي قمنا بتحديد ثيم التطبيق الخاص بنا من خطوط و ألوان ...الخ
import '../helper/project_theme.dart';
// قمنا بادراج حزمة المكتبة التي سوف تساعدنا في طلب البيانات من ال api و اعطينها اسم مختصر http
import 'package:http/http.dart' as http;

class CreateEmployeeScreen extends StatefulWidget {
  // متغير سوف يخزن بيانات المستخدم بعد تسجيل دخوله
  final UserInfo currentUserInfo;
  CreateEmployeeScreen({this.currentUserInfo});

  @override
  _CreateEmployeeScreenState createState() => _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends State<CreateEmployeeScreen> {
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
  bool sending = false;

  // فكشن سوف تتواصل مع قاعدة البيانات لطلب اعادة كلمة المرور
  Future<bool> sendNewEmployee() async {
    setState(() {
      sending = true;
      AppUtils.showProgressDialog(context, "يتم اضافة الموظف ...");
    });
    EmployeeInfo newEmployee = EmployeeInfo(
        empNo: empNoController.text,
        phone: phoneController.text,
        departmentId: widget.currentUserInfo.departmentId,
        managerId: widget.currentUserInfo.id,
        fName: fNameController.text,
        lName: lNameController.text,
        gender: _selectedGenderRadio,
        userName: userNameController.text,
        password: passwordController.text,
        email: emailController.text,
        rfCardId: rfCardIdController.text,
        bod: selectedDate);
    // تعريف طلب لرابط ال api
    final response = await http.post('$ApiURL/Employees',
        // البيانات التي ترجع من الطلب تكون بصيغة json
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        //  ,تحويل كائن الموظف الى نص من نوع Json و نرسله مع الطلب في ال body
        body: employeeToJson(newEmployee));
    Navigator.pop(context);
    // رقم 200 معناه بانه تم الاتصال بنجاح و تم اضافة الموظف الجديد
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
      builder: (context) => CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // زر الرجوع
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () => Navigator.pop(context, false),
            ),
            pinned: true,
            expandedHeight: 140.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                child: Text('انشاء موظف جديد', style: TextStyle(fontSize: 13)),
              ),
              background: Image.asset(
                'assets/images/header_home.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          // If the main content is a list, use SliverList instead.
          SliverToBoxAdapter(
            child: Scrollbar(
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
                              prefixIcon:
                                  Icon(Icons.work, color: gold, size: 35),
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
                              prefixIcon: Icon(Icons.credit_card,
                                  color: gold, size: 35),
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
                                      onChanged: (newValue) => setState(() =>
                                          _selectedGenderRadio = newValue),
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
                                      onChanged: (newValue) => setState(() =>
                                          _selectedGenderRadio = newValue),
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
                              prefixIcon:
                                  Icon(Icons.lock, color: gold, size: 35),
                            ),
                          ),
                          // مسافة بين الحقول
                          SizedBox(height: 15),
                          // زر  كلمة المرور
                          RaisedButton(
                            child: Text(
                              "اضافة الموظف",
                              style: TextStyle(fontSize: 25),
                            ),
                            onPressed: () async {
                              if (await sendNewEmployee() == true) {
                                setState(() {
                                  AppUtils.showSnackBar(
                                      message: 'تم اضافة الموظف الجديد بنجاح',
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
            ),
          ),
        ],
      ),
    ));
  }

  // متغير لتخزين تاريخ الميلاد
  // القيمة الافتراضيه قبل 8000 من تاريخ اليوم
  DateTime selectedDate = DateTime.now().add(Duration(days: -8000));
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
