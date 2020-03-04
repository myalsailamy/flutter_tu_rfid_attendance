import 'package:flutter/material.dart';
import 'package:tu_rfid_attendance/helper/project_theme.dart';
import 'package:tu_rfid_attendance/services/user_info.dart';

import 'navigation_drawer.dart';

class HomePage extends StatefulWidget {
  // قمنا بتعريف key كإسم للصفحة الرئيسية من أجل استدعاء الشاشاه للانتقال اليها
  static const id = "MyHomePage_screen";
  // متغير سوف يخزن بيانات المستخدم بعد تسجيل دخوله
  final UserInfo currentUserInfo;

  HomePage({this.currentUserInfo});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: NavigationDrawer(currentUserInfo: widget.currentUserInfo)),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                width: double.infinity,
                child: Text(
                  widget.currentUserInfo.name,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              background: Image.asset(
                'assets/images/header_home.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          // If the main content is a list, use SliverList instead.
          SliverFillRemaining(
            child: Column(
              children: <Widget>[
                Center(child: Text("Hello")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
