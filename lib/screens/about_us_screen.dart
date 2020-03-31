import 'package:flutter/material.dart';
import '../helper/information_card.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('عن التطبيق'),
        // زر الرجوع
        leading: IconButton(
          // أيقونة الرجوع
          icon: Icon(Icons.arrow_back, color: Colors.black),
          // عند الضغط على زر الرجزع فإنه يرجع للصفحة السابقة
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      // محتوى صفحة معلومات عن التطبيق
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // مسافة بين الصورة و الشريط العلوي
            SizedBox(height: 20.0),
            // صورة المستخدم
            Image(
              image: AssetImage('assets/images/logo.jpg'),
              height: 300,
            ),

            SizedBox(
              height: 20,
            ),
            getInfoCard('إصدار التطبيق', '1.0.2', Icons.settings_applications),
            // كرت المعلومات قمنا بانشاء عنصر جديد وارسلنا له البيانات
            getInfoCard('المطورون', 'طالبات د.صالح', Icons.person),
            getInfoCard('بريد التواصل', 'tu_developers@gmail.com', Icons.email),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
