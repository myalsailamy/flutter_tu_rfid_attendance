import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/Images/Header.jpg"),
                fit: BoxFit.cover),
          ),
        ),
        ListTile(
          title: Text("رهام المالكي", style: _menutextcolor),
          onTap: () {},
        ),
        Divider(
          height: 10.0,
        ),
        ListTile(
          leading: IconTheme(
            data: _iconcolor,
            child: Icon(Icons.account_circle),
          ),
          title: Text("الملف الشخصي", style: _menutextcolor),
          selected: true,
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: IconTheme(
            data: _iconcolor,
            child: Icon(Icons.add),
          ),
          title: Text("إضافة موظف", style: _menutextcolor),
          onTap: () {},
        ),
        ListTile(
          leading: IconTheme(
            data: _iconcolor,
            child: Icon(Icons.supervised_user_circle),
          ),
          title: Text("معلومات الموظفين", style: _menutextcolor),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: IconTheme(
            data: _iconcolor,
            child: Icon(Icons.assessment),
          ),
          title: Text("تقرير الغياب", style: _menutextcolor),
          onTap: () {},
        ),
        ListTile(
          leading: IconTheme(
            data: _iconcolor,
            child: Icon(Icons.error_outline),
          ),
          title: Text("عن التطبيق", style: _menutextcolor),
          onTap: () {},
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
          onTap: () {},
        ),
      ],
    );
  }
}
