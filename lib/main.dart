import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tu_rfid_attendance/Screens/LoginScreen.dart';

import 'ProjectTheme.dart';
import 'Screens/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      // قمنا بتركيب الثيم الذهبي على تطبيقنا من هنا
      theme: getMainTheme(),

      // تغيير اللغة من أجل جعل تصميم الإستايل يكون من اليمين لليسار
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      // يدعم تنسيقات اللغة العربي و الموقع السعودية
      supportedLocales: [Locale("ar", "SA")],
      locale: Locale("ar", "SA"), // OR Locale('ar', 'AE') OR Other RTL locales,

      // الصفحة الرئيسية في التطبيق
      home: LoginScreen(primaryColor: Color(0xFF4aa0d5)),
      // initialRoute: HomePage.id,
      // رسم خريطة الموقع من أجل التنقل بين صفحات التطبيق
      routes: {
        HomePage.id: (context) => HomePage(),
//        '/first': (context) => Screen1(),
//        '/second': (context) => Screen2(),
      },
    );
  }
}
