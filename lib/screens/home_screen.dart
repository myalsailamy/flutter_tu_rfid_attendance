import 'package:flutter/material.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:tu_rfid_attendance/helper/project_theme.dart';
import '../services/attendance.dart';
import '../services/attendances_service.dart';
import '../services/user_info.dart';

import 'attendances_employee_widget.dart';
import 'attendances_widget.dart';
import 'navigation_drawer.dart';

enum ReportType { today, thisWeek, thisMonth }

class HomePage extends StatefulWidget {
  // قمنا بتعريف key كإسم للصفحة الرئيسية من أجل استدعاء الشاشاه للانتقال اليها
  static const id = "MyHomePage_screen";
  // متغير سوف يخزن بيانات المستخدم بعد تسجيل دخوله
  final UserInfo currentUserInfo;
  // تمرير بيانات المستخدم الحالي
  HomePage({this.currentUserInfo});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  var _attendancesReport;

  // عند بداية تشغيل الشاشة الرئيسية
  @override
  void initState() {
    super.initState();
    // طلب تقرير الحضور
    getAttendancesReport();
  }

// فكشن تطلب التقرير الحضور
  Future<List<Attendance>> getAttendancesReport() async {
    // عرفنا متغير سنضع تقرير الحضور فيه
    var result;
    // إذا كان المستخدم الحالي مدير فإنه يظهر حضور القسم الخاص به
    if (widget.currentUserInfo.role == 'manager') {
      result = AttendancesServices()
          .getAttendancesReport(widget.currentUserInfo.departmentId);
    } else {
      // اذا كان مستخدم عادي فانه يحضر حضوره خلال الشهر الحالي
      result = AttendancesServices()
          .getEmployeeAttendancesReport(widget.currentUserInfo.id);
    }
    setState(() {
      _attendancesReport = result;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: NavigationDrawer(currentUserInfo: widget.currentUserInfo)),
        body: RefreshIndicator(
          color: Colors.blue,
          onRefresh: () {
            return getAttendancesReport(); // EDITED
          },
          child: CustomScrollView(
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
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    // اظهار اسم الإدارة أعلى التقرير في الشاشة الأساسية
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        (widget.currentUserInfo.role == 'manager'
                            // إذا كان مدير إدارة يظهر اسم الإدارة أعلى التقرير
                            ? widget.currentUserInfo.department
                            // إذا كان مستخدم عادي يظهر النص التالي
                            : "الحضور خلال الشهر الحالي"),
                        style: TextStyle(
                          color: gold,
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    FutureBuilder<List<Attendance>>(
                        future: _attendancesReport,
                        builder: (c, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Center(
                                  child: Text("لم يتم التحضير اليوم"));
                            case ConnectionState.active:
                            case ConnectionState.waiting:
                              return PKCardPageSkeleton();
                            case ConnectionState.done:
                              if (snapshot.hasError)
                                return Text('Error: ${snapshot.error}');
                              if (snapshot.hasData)
                                return (widget.currentUserInfo.role == 'manager'
                                    // إذا كان مدير إدارة يظهر التصميم الخاص بعرض حضور الإدارة
                                    ? uiAttendancesReportWidget(snapshot.data)
                                    // إذا كان مستخدم عادي يظهر التصميم الخاص بعرض حضور الموظف خلال الشهر الحالي
                                    : uiAttendancesEmployeeReportWidget(
                                        snapshot.data));
                              else
                                return Center(
                                    child: Text("لم يتم التحضير اليوم"));
                              break;
                            default:
                              return Center(
                                  child: Text("لم يتم التحضير اليوم"));
                          }
                        }),
                  ],
                )),
              ),
            ],
          ),
        ));
  }
}
