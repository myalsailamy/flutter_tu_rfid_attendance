import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Screens/login_screen.dart';
import 'Screens/home_screen.dart';
import 'screens/user_info_screen.dart';
import 'helper/project_theme.dart';

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
      home: LoginScreen(),
      // MinitialRoute: HomePage.id,
      // رسم خريطة الموقع من أجل التنقل بين صفحات التطبيق
      routes: {
        HomePage.id: (context) => HomePage(),

        UserInfoScreen.id: (context) => UserInfoScreen(),
//        '/second': (context) => Screen2(),
      },
    );
  }
}
