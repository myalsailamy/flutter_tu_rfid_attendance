import 'package:flutter/material.dart';

import '../ProjectTheme.dart';

class LoginScreen extends StatelessWidget {
  final Color primaryColor;

  LoginScreen({Key key, this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              // رسم مربع منحني من أسفل من أجل وضع شعار التطبيق بأعلى
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      // صورة صفحة تسجيل الدخول التي بالأعلى
                      image: AssetImage("assets/Images/Header.jpg"),
                      // جعل مقاس الصوره تغطي المربع المرسوم
                      fit: BoxFit.fill,
                    ),
                  ),
                  // المحاذاه بالمنتصف
                  alignment: Alignment.center,
                  // تحديد مساحة المربع من أعلى  و من أسفل
                  padding: EdgeInsets.only(top: 150.0, bottom: 100.0),
                ),
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
                        autofocus: true,
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
                  value: false,
                  activeColor: gold,
                  onChanged: (value) {},
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
                        onPressed: () => {},
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
                        onPressed: () => {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.85);
    p.arcToPoint(
      Offset(0.0, size.height * 0.85),
      radius: const Radius.elliptical(50.0, 10.0),
      rotation: 0.0,
    );
    p.lineTo(0.0, 0.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
