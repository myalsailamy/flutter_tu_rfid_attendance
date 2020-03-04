import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// هذا الاستايل العامل للتطبيق أو الثيم
// سيتم تطبيقه على مستوى المشروع كاملاً مثل الألزان و الخطوط
getMainTheme() {
  return ThemeData(
      // استخدمنا اللون الذهبي كلون أساسي لمشروعنا
      primarySwatch: gold,
      accentColor: Colors.amber,
      // استخدمنا الخط الموجود في مجلد الخطوط
      // Assets/fonts
      fontFamily: 'JFFlat',
      primaryColor: gold,
      textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'JFFlat',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
      appBarTheme: AppBarTheme(
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'JFFlat',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      ));
}

// عرفنا درجات اللون الذهبي الذي سنستخدمه في مشروعنا
const MaterialColor gold = const MaterialColor(
  0xffA2834D,
  const <int, Color>{
    50: const Color(0xffA2834D),
    100: const Color(0xffA2834D),
    200: const Color(0xffA2834D),
    300: const Color(0xffA2834D),
    400: const Color(0xffA2834D),
    500: const Color(0xffA2834D),
    600: const Color(0xffA2834D),
    700: const Color(0xffA2834D),
    800: const Color(0xffA2834D),
    900: const Color(0xffA2834D),
  },
);

const employeeNameStyle = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.bold,
  color: gold,
  fontFamily: 'JFFlat',
);

const end2subtitle = TextStyle(
  fontSize: 12.0,
  color: Colors.grey,
  fontWeight: FontWeight.bold,
  fontFamily: 'JFFlat',
);

const spaceH5 = SizedBox(height: 5);
const spaceH10 = SizedBox(height: 10);
