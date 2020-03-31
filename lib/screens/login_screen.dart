import 'dart:io';
import 'package:flutter/material.dart';
// مكتبة أنزلناها من الانترنت لإظهار رسالة على الشاشة
import 'package:fluttertoast/fluttertoast.dart';
// كلاس قمنا بكتابته يخزن القيم في الجهاز و يسترجعها لنستخدمها في تطبيقنا
import '../helper/save_data.dart';
import '../screens/home_screen.dart';
// Object بيانات المستخدم و الذي سيحول من Json الى Object  و العكس
import '../services/user_info.dart';
// ادراج الكلاس الي قمنا بتوليده من
import '../services/login_user.dart';
// ادراج المكتبه التي نضع بها قيم ثابته على مستوى المشروع
import '../helper/const.dart';
// ادراج الكلاس الذي قمنا بتحديد ثيم التطبيق الخاص بنا من خطوط و ألوان ...الخ
import '../helper/project_theme.dart';
// قمنا بادراج حزمة المكتبة التي سوف تساعدنا في طلب البيانات من ال api و اعطينها اسم مختصر http
import 'package:http/http.dart' as http;

import 'forgot_password_screen.dart';

// شاشة تسجيل الدخول
class LoginScreen extends StatefulWidget {
  // قمنا بتعريف key كإسم للصفحة من أجل استدعاء الشاشاه للانتقال اليها
  static const id = "login_screen";

  LoginScreen();
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // قمنا بتعريف كنترول لحقل الاسم من أجل تسهيل أخذ البيانات من الحقل
  final userNameController = TextEditingController();
  // قمنا بتعريف كنترول لحقل الرقم السري من أجل تسهيل أخذ البيانات من الحقل
  final passwordController = TextEditingController();
  // متغير يحفظ بيانات المستخدم الحالي في حالة قام بوضع صح على تذكرني
  bool rememberMe = false;

  // عند بداية تشغيل شاشة تسجيل الدخول
  @override
  void initState() {
    super.initState();
    // جلب اسم المستخدم اذا كان سجل دخوله من قبل على التطبيق
    // ووضعه في حقل اسم المستخدم
    getUserNamePreference().then((String userName) {
      userNameController.text = userName;
    });
  }

  // فكشن سوف تتواصل مع قاعدة البيانات لتسجيل الدخول
  Future<UserInfo> login() async {
    showToastMessage("جاري تسجيل الدخول");
    // عرفنا كائن تسجيل دخول سوف يحوي اسم المستخدم و كلمة المرور من أجل ارسالها لل api
    LoginUser loginUser = LoginUser(
        userName: userNameController.text, password: passwordController.text);
    // تعريف طلب لرابط ال api
    final response = await http.post('$ApiURL/Users',
        // البيانات التي يتضمنها الطلب تكون بصيغة json
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        //  ,تحويل كائن المستخدم الى نص من نوع Json و نضعه في ال body
        body: loginUserToJson(loginUser));
    // رقم 200 معناه بانه تم التسجيل بنجاح ورجع ببيانات الموظف
    if (response.statusCode == 200) {
      saveUserInfoAsJson(response.body);
      // userInfo ارجاع بيانات المستخدم الذي سجل الدخول و تحويلها من بيانات بصيغة Json  الى كائن من نوع
      var userInfo = userInfoFromJson(response.body);

      // يسجل اسم المستخدم من أجل عدم كتابته كل مره
      saveUserNamePreference(loginUser.userName);

      // بعد نجاح تسجيل الدخول يتم توجيه المستخدم للشاشة الرئيسية
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        //  ارسال بيانات المستخدم الذي سجل دخوله الى كود الواجهه الأساسية
        return HomePage(currentUserInfo: userInfo);
      }));
    } else if (response.statusCode == 404) {
      showToastMessage("اسم المستخدم أو كلمة المرور غير صحيحه");
    } else {
      showToastMessage("فضلاً تحقق من الشبكة");
    }
    return null;
  }

// فكشن تقوم باظهار الرسائل على الشاشة مثل رسالة خطأ او تم تسجيل الدخول
  void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1);
  }

  // هيكل شاشة تسجيل الدخول مثل اسم المستخدم و كلمة المرور
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // محتوى الصفحة سيكون شاشة تقبل التحريك للأسفل Scroll لانه عند ادخال النص سوف تظهر لوحة الحروف و تتحرك الشاشة لأعلى
        body: Builder(
      builder: (context) => SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            // جعل عناصر ال Column تبدأ ترتيب المحتوى من أعلى الشاشة
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              // رسم مربع من أجل وضع شعار التطبيق بأعلى
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    // صورة صفحة تسجيل الدخول التي بالأعلى
                    image: AssetImage("assets/images/header.jpg"),
                    // جعل مقاس الصوره تغطي المربع المرسوم
                    fit: BoxFit.fill,
                  ),
                ),
                // المحاذاه بالمنتصف
                alignment: Alignment.center,
                // تحديد مساحة المربع من أعلى  و من أسفل
                padding: EdgeInsets.only(top: 150.0, bottom: 100.0),
              ),
              // مسافه بين صورة الشعار بالأعلى و حقول تسجيل الدخول
              Padding(
                padding: EdgeInsets.only(right: 40.0, top: 40.0),
              ),
              // حاوية لاسم المستخدم مع تنسقات النص و الحقل
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.5),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: <Widget>[
                    // وضع ايقونة اسم المستخدم
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      child: Icon(Icons.person_outline, color: Colors.grey),
                    ),
                    // خط فاصل بين الأيقونه و حقل النص الذي سندخل به اسم المستخدم
                    Container(
                      height: 30.0,
                      width: 1.0,
                      color: Colors.grey.withOpacity(0.5),
                      margin: EdgeInsets.only(left: 10.0, right: 0.0),
                    ),
                    // حقل النص الذي سنطلب من المستخدم ادخال اسم المستخدم به
                    Expanded(
                      child: TextField(
                        // ربطنا الكنترولر الذي عرفناه ببداية الكلاس بالحقل النص
                        controller: userNameController,
                        // قمنا بعمل ديكور لشكل الحقل النصي
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'ادخل اسم المستخدم',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // حاوية لحقل كلمة المرور
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.5), width: 1.0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                child: Row(
                  children: <Widget>[
                    // وضع ايقونة كلمة المرور
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      child: Icon(Icons.lock_open, color: Colors.grey),
                    ),
                    // خط فاصل بين الأيقونه و حقل النص الذي سندخل به كلمة المرور
                    Container(
                      height: 30.0,
                      width: 1.0,
                      color: Colors.grey.withOpacity(0.5),
                      margin: EdgeInsets.only(left: 10.0, right: 0.0),
                    ),
                    Expanded(
                      // حقل النص الذي سنطلب من المستخدم ادخال كلمة المرور به
                      child: TextField(
                        // لجعل كلمة المرور تظهر نجمات بدلاً من نص
                        obscureText: true,
                        // ربطنا الكنترولر الذي عرفناه ببداية الكلاس بالحقل النص
                        controller: passwordController,
                        // قمنا بعمل ديكور لشكل الحقل النصي
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'ادخل كلمة المرور',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // تذكرني
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CheckboxListTile(
                  value: rememberMe,
                  activeColor: gold,
                  onChanged: (value) {
                    setState(() {
                      rememberMe = value;
                    });
                  },
                  title: Text("تذكرني"),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              // زر تسجيل الدخول
              Container(
                margin: EdgeInsets.only(top: 20.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        splashColor: gold,
                        color: gold,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Text(
                                "تسجيل الدخول",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Transform.translate(
                              offset: Offset(-10.0, 0.0),
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(28.0)),
                                  splashColor: Colors.white,
                                  color: Colors.white,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: gold,
                                  ),
                                  onPressed: () => {},
                                ),
                              ),
                            )
                          ],
                        ),
                        // عند الضغط على زر تسجيل الدخول
                        onPressed: () async {
                          await login();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // تنسيق زر نسيت كلمة المرور
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.only(right: 20.0),
                          alignment: Alignment.center,
                          child: Text(
                            "نسيت كلمة المرور ؟",
                            style: TextStyle(color: gold, fontSize: 17),
                          ),
                        ),
                        onPressed: () => {
                          // فتح شاشة استعادة كلمة المرور
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ForgotPasswordScreen();
                          })),
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
