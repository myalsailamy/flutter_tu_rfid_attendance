import 'package:flutter/material.dart';
import '../screens/employees_list_screen.dart';
import '../helper/project_theme.dart';
import '../screens/about_us_screen.dart';
import '../screens/login_screen.dart';
import '../services/user_info.dart';

import 'absences_report_screen.dart';
import 'create_employee_screen.dart';
import 'home_screen.dart';
import 'user_info_screen.dart';

// عرفنا في هذه ويدجت جديده ستكون القائمة الجانبيه للتطبيق
class NavigationDrawer extends StatelessWidget {
  // عرفنا متغير عام لتنسيق نص عناصر القائمة الجانبية
  final _menutextcolor = TextStyle(
    // لون النص
    color: Colors.black,
    // حجم الخط
    fontSize: 20.0,
    // نوع الخط
    fontFamily: 'JFFlat',
    // وزن الخط
    fontWeight: FontWeight.w500,
  );
  // عرفنا متغير عامل لاستايل لون الأيقونات الجانبيه من أجل تغيير لون الأيقونات
  final _iconcolor = new IconThemeData(
    // حجم الأيقونة
    size: 50,
    // لون الأيقونه
    color: Color(0xff757575),
  );

  // متغير سوف يخزن بيانات المستخدم بعد تسجيل دخوله
  final UserInfo currentUserInfo;
  NavigationDrawer({Key key, this.currentUserInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        UserAccountsDrawerHeader(
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(
            image: DecorationImage(
                // وصعنا الصورة الأساسية للقائمة من ملف الصور
                image: AssetImage("assets/images/header.jpg"),
                // جعلنا مقاس الصورة يناسب مقاس القائمة
                fit: BoxFit.cover),
          ),
        ),
        Ink(
          color: gold,
          child: ListTile(
            title: Text(this.currentUserInfo.name,
                style: _menutextcolor.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25)),
            onTap: () {},
          ),
        ),
        Divider(
          height: 10.0,
        ),
        ListTile(
          leading: IconTheme(
            data: _iconcolor,
            child: Icon(Icons.home),
          ),
          title: Text("الرئيسية", style: _menutextcolor),
          selected: true,
          onTap: () {
            // الانتقال للشاشة عند الضغط على الزر
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomePage(currentUserInfo: currentUserInfo);
            }));
          },
        ),
        ListTile(
          leading: IconTheme(
            data: _iconcolor,
            child: Icon(Icons.account_circle),
          ),
          title: Text("الملف الشخصي", style: _menutextcolor),
          selected: true,
          onTap: () {
            // الانتقال للشاشة عند الضغط على الزر
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return UserInfoScreen(
                  title: 'بياناتي', currentUserInfo: currentUserInfo);
            }));
          },
        ),
        Divider(),
        Visibility(
          child: ListTile(
            leading: IconTheme(
              data: _iconcolor,
              child: Icon(Icons.add),
            ),
            title: Text("إضافة موظف", style: _menutextcolor),
            onTap: () {
              // الانتقال للشاشة عند الضغط على الزر
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CreateEmployeeScreen(
                  currentUserInfo: currentUserInfo,
                );
              }));
            },
          ),
          // فحص صلاحية المستخدم الحالي إذا يملك حساب إدارة يسمح بإظهار هذا الخيار في القائمة
          visible: (this.currentUserInfo.role == 'manager') ? true : false,
        ),
        Visibility(
          child: ListTile(
            leading: IconTheme(
              data: _iconcolor,
              child: Icon(Icons.supervised_user_circle),
            ),
            title: Text("معلومات الموظفين", style: _menutextcolor),
            onTap: () {
              // الانتقال للشاشة عند الضغط على الزر
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EmployeesListScreen(
                  title: currentUserInfo.department,
                  departmentId: currentUserInfo.departmentId,
                );
              }));
            },
          ),
          // فحص صلاحية المستخدم الحالي إذا يملك حساب إدارة يسمح بإظهار هذا الخيار في القائمة
          visible: (this.currentUserInfo.role == 'manager') ? true : false,
        ),
        Visibility(
          child: Divider(),
          visible: (this.currentUserInfo.role == 'manager') ? true : false,
        ),
        Visibility(
          child: ListTile(
            leading: IconTheme(
              data: _iconcolor,
              child: Icon(Icons.assessment),
            ),
            title: Text("تقرير الغياب", style: _menutextcolor),
            onTap: () {
              // الانتقال للشاشة عند الضغط على الزر
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AbsencesReportScreen(
                  currentUserInfo: currentUserInfo,
                );
              }));
            },
          ),
          // فحص صلاحية المستخدم الحالي إذا يملك حساب إدارة يسمح بإظهار هذا الخيار في القائمة
          visible: (this.currentUserInfo.role == 'manager') ? true : false,
        ),
        ListTile(
          leading: IconTheme(
            data: _iconcolor,
            child: Icon(Icons.error_outline),
          ),
          title: Text("عن التطبيق", style: _menutextcolor),
          onTap: () {
            // الانتقال للشاشة عند الضغط على الزر
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AboutUs()));
          },
        ),
        Divider(
          height: 50.0,
        ),
        ListTile(
          leading: IconTheme(
            data: _iconcolor,
            child: Icon(Icons.exit_to_app),
          ),
          title: Text("تسجيل الخروج", style: _menutextcolor),
          onTap: () {
            // الانتقال للشاشة عند الضغط على الزر
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return LoginScreen();
            }));
          },
        ),
      ],
    );
  }
}
