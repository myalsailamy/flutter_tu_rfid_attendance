import 'package:flutter/material.dart';
import '../helper/information_card.dart';
import '../screens/edit_employee_screen.dart';
import '../helper/project_theme.dart';
import '../services/user_info.dart';
import 'package:intl/intl.dart';

class UserInfoScreen extends StatefulWidget {
  // قمنا بتعريف key كإسم للصفحة عرض معلومات المستخدم من أجل استدعاء الشاشه للانتقال اليها
  static const id = "user_info_screen";
  // متغير سوف يخزن بيانات المستخدم بعد تسجيل دخوله
  final UserInfo currentUserInfo;
  final String title;
  UserInfoScreen({Key key, this.title, this.currentUserInfo}) : super(key: key);
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ''),
        // زر الرجوع
        leading: IconButton(
          // أيقونة الرجوع
          icon: Icon(Icons.arrow_back, color: Colors.black),
          // عند الضغط على زر الرجوع فإنه يرجع للصفحة السابقة
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      // محتوى صفحة معلومات المستخدم
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // مسافة بين الصورة و الشريط العلوي
            SizedBox(height: 20.0),
            // صورة المستخدم
            CircleAvatar(
              radius: 70.0,
              backgroundColor: Colors.red,
              backgroundImage: AssetImage('assets/images/header.jpg'),
            ),
            Align(
              alignment: Alignment.center,
              // مسافة بين الصورة و المعلومات
              heightFactor: 2,
              child: Text(
                widget.currentUserInfo?.userName?.toUpperCase(),
                style: TextStyle(
                    fontSize: 30, color: gold, fontWeight: FontWeight.bold),
              ),
            ),

            // كرت المعلومات قمنا بانشاء عنصر جديد وارسلنا له البيانات
            Visibility(
              child: getInfoCard(
                  'الرقم الوظيفي', widget.currentUserInfo?.empNo, Icons.work),
              visible: (widget.currentUserInfo?.empNo != '') ? true : false,
            ),
            getInfoCard('الاسم', widget.currentUserInfo?.name, Icons.person),
            // كرت المعلومات قمنا بانشاء عنصر جديد وارسلنا له البيانات
            getInfoCard('البريد الإلكتروني', widget.currentUserInfo?.email,
                Icons.email),
            getInfoCard(
                'رقم الجوال', widget.currentUserInfo?.phone, Icons.phone),
            Visibility(
              child: getInfoCard('الإدارة', widget.currentUserInfo?.department,
                  Icons.business),
              visible:
                  (widget.currentUserInfo?.department != '') ? true : false,
            ),
            getInfoCard(
                'الجنس', widget.currentUserInfo?.gender, Icons.perm_identity),
            getInfoCard(
                'تاريخ الميلاد',
                DateFormat("yyyy-MM-dd").format(widget.currentUserInfo?.bod),
                Icons.calendar_today),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditEmployeeInfo(
                title: 'تعديل بياناتي',
                selectedUserInfo: widget.currentUserInfo);
          }));
        },
        child: Icon(Icons.edit),
        backgroundColor: gold,
        foregroundColor: Colors.white,
      ),
    );
  }
}
