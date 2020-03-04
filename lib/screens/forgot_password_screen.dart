import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../screens/login_screen.dart';
import '../services/change_password.dart';
import '../helper/const.dart';
import '../helper/project_theme.dart';
// قمنا بادراج حزمة المكتبة التي سوف تساعدنا في طلب البيانات من ال api و اعطينها اسم مختصر http
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // قمنا بتعريف كنترول لحقل الايميل من أجل تسهيل أخذ البيانات من الحقل
  final emailController = TextEditingController();
  // قمنا بتعريف كنترول لحقل كلمة المرور من أجل تسهيل أخذ البيانات من الحقل
  final passwordController = TextEditingController();
  // قمنا بتعريف كنترول لحقل اعادة كلمة المرور من أجل تسهيل أخذ البيانات من الحقل
  final passwordConfirmController = TextEditingController();
  // حقل رمز التفعيل
  final _pinCodeController = TextEditingController();
  // تحقق من أنه المستخدم صاحب الحساب سوف يخزن الرقم الذي سيتم ارساله الى الايميل للمقارنه بين ما يكتبه المستخدم وهذا الرقم
  String checkCode = '';
  // في حال ادخال رقم التفعيل بشكل صحيح يتم اظهار حقل ادخال كلمة المرور الجديدة
  bool _showPasswordReset = false;

  // فكشن سوف تتواصل مع قاعدة البيانات لطلب اعادة كلمة المرور
  Future<bool> resetPasswordByEmail() async {
    checkCode = '';
    _showPasswordReset = false;
    // تعريف طلب لرابط ال api
    final response = await http
        .get('$ApiURL/Users/resetPassword?email=${emailController.text}',
            // البيانات التي ترجع من الطلب تكون بصيغة json
            headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    // رقم 200 معناه بانه تم الاتصال بنجاح و تم ارسال رساله لبريد المستخدم
    if (response.statusCode == 200) {
      // رمز الأمان للسماح بالتغيير و مطابقته لما سيقوم المستخدم بإدخاله
      checkCode = response.body.toString();
      return true;
    } else if (response.statusCode == 404) {
      showToastMessage("لم يتم ايجاد أي حساب بهذا البريد الإلكتروني");
    } else {
      showToastMessage("فضلاً تحقق من الشبكة");
    }
    return false;
  }

  // فكشن سوف تتواصل مع قاعدة البيانات لاعتماد كلمة المرور الجديدة
  Future<void> changePasswordByEmail() async {
    if ((passwordController.text.length < 4) ||
        (passwordController.text != passwordConfirmController.text)) {
      showToastMessage(
          "أدخل كلمة مرور عدد حروفها أكثر من 4 خانات وتأكد من أن كلمات المرور متطابقة");
      return null;
    }

    showToastMessage("جاري حفظ كلمة المرور الجديدة");
    // عرفنا كائن تسجيل دخول سوف يحوي البريد الإلكتروني و كلمة المرور الجديدة من أجل ارسالها لل api
    ChangePassword changePassword = ChangePassword(
        email: emailController.text, newPassword: passwordController.text);
    // تعريف طلب لرابط ال api
    final response = await http.put('$ApiURL/Users',
        // البيانات التي ترجع لنا من الطلب تكون بصيغة json
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        //  ,تحويل كائن طلب تغيير كلمة المرور الى نص من نوع Json و نضعه في ال body
        body: changePasswordToJson(changePassword));
    // رقم 200 معناه بانه تم التسجيل بنجاح ورجع ببيانات الموظف
    if (response.statusCode == 200) {
      // بعد نجاح كلمة المرور يتم توجيه المستخدم للشاشة تسجيل الدخول
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }));
    } else {
      showToastMessage("حصل خطأ غير متوقع، أو ان الشبكة غير متصله.");
    }
  }

// فكشن تقوم باظهار الرسائل على الشاشة مثل رسالة خطأ او اشعار للمستخدم
  void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1);
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
            expandedHeight: 180.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                child: Text('استعادة كلمة المرور بالبريد',
                    style: TextStyle(fontSize: 15)),
              ),
              background: Image.asset(
                'assets/images/header_home.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          // If the main content is a list, use SliverList instead.
          SliverFillRemaining(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    Visibility(
                      visible: (checkCode == '') ? true : false,
                      child: Column(
                        children: <Widget>[
                          // مسافة بين الصورة التي بالأعلى و حقل الايميل
                          SizedBox(height: 15),
                          // حقل ادخال الإيميل
                          TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'example@gmail.com',
                              labelText: 'فضلاً قم بكتابة البريد الخاص بك',
                              prefixIcon:
                                  Icon(Icons.email, color: gold, size: 35),
                            ),
                          ),
                          // مسافة بين حقل الإيميل و زر الارسال
                          SizedBox(height: 15),
                          // زر استعادة كلمة المرور
                          RaisedButton(
                            child: Text(
                              "استعادة كلمة المرور",
                              style: TextStyle(fontSize: 25),
                            ),
                            onPressed: () async {
                              if (await resetPasswordByEmail() == true) {
                                setState(() {
                                  _showSnackBar(
                                      'فضلاً قم بادخال الأربعة أرقام التي تم ارسالها الى البريد الاكتروني الخاص بك',
                                      context);
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
                    Visibility(
                      visible: (checkCode != '' && _showPasswordReset == false)
                          ? true
                          : false,
                      child: Column(
                        children: <Widget>[
                          // مسافة بين الصورة التي بالأعلى و حقل الايميل
                          SizedBox(height: 10),
                          Text(
                            "قم بادخال الأربعة أرقام التي تم ارسالها الى بريدك",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 280,
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: PinCodeTextField(
                                controller: _pinCodeController,
                                autoFocus: true,
                                activeColor: gold,
                                selectedColor: gold,
                                inactiveColor: Colors.black,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                onCompleted: (_value) {
                                  if (_value == checkCode) {
                                    setState(() {
                                      _showPasswordReset = true;
                                    });
                                  } else {
                                    _showSnackBar(
                                        'الرمز الذي أدخلته غير مطابق، فضلاً تاكد من الرقم الصحيح.',
                                        context);
                                    _pinCodeController.clear();
                                    setState(() {});
                                  }
                                },
                                textInputType: TextInputType.number,
                                length: 4,
                                obsecureText: false,
                                animationType: AnimationType.slide,
                                shape: PinCodeFieldShape.box,
                                animationDuration: Duration(milliseconds: 300),
                                borderRadius: BorderRadius.circular(10),
                                fieldHeight: 50,
                                fieldWidth: 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _showPasswordReset,
                      child: Column(
                        children: <Widget>[
                          // مسافة بين الصورة التي بالأعلى و حقول كلمات السر
                          SizedBox(height: 15),
                          // حقل ادخال كلمة المرور
                          TextField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'كلمة المرور الجديدة',
                              prefixIcon:
                                  Icon(Icons.lock_open, color: gold, size: 30),
                            ),
                          ),
                          TextField(
                            controller: passwordConfirmController,
                            keyboardType: TextInputType.visiblePassword,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'إعادة كلمة المرور الجديدة',
                              prefixIcon:
                                  Icon(Icons.lock, color: gold, size: 30),
                            ),
                          ),
                          // مسافة بين حقل الإيميل و زر الارسال
                          SizedBox(height: 15),
                          // زر استعادة كلمة المرور
                          RaisedButton(
                            child: Text(
                              "تغيير",
                              style: TextStyle(fontSize: 25),
                            ),
                            onPressed: () async {
                              await changePasswordByEmail();
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

// الكود الذي يقوم باظهار الرساذل التي تظهر أسفل الشاشة
  void _showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 3),
      content: Container(
          height: 80.0,
          child: Center(
            child: Text(
              message,
              style: TextStyle(fontSize: 25.0),
            ),
          )),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
