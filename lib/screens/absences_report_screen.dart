import 'package:flutter/material.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:tu_rfid_attendance/helper/project_theme.dart';

import '../services/absences_service.dart';
import '../services/absence.dart';

import '../services/user_info.dart';
import 'absences_report_widget.dart';
import 'late_employee_report_widget.dart';
import 'navigation_drawer.dart';

enum AbsencesReportType { today, thisWeek, thisMonth }

class AbsencesReportScreen extends StatefulWidget {
  // قمنا بتعريف key كإسم للصفحة تقرير الغياب و التأخير من أجل استدعاء الشاشه للانتقال اليها
  static const id = "absences_report_screen";
  // عنوان الصفحة
  final String title;
  // متغير سوف يخزن بيانات المستخدم بعد تسجيل دخوله
  final UserInfo currentUserInfo;
  AbsencesReportScreen({this.title, @required this.currentUserInfo}) : super();

  @override
  _AbsencesReportScreenState createState() => _AbsencesReportScreenState();
}

class _AbsencesReportScreenState extends State<AbsencesReportScreen> {
  // عرفنا متغير سيحوي تقرير الغياب حسب اليوم أو الأسبوع أو الشهر
  var _absencesReport;
  // عرفنا متغير سيحوي تقرير التأخير حسب اليوم أو الأسبوع أو الشهر
  var _lateEmployeeReport;
  // عرفنا متغير يحدد لنا نوع التقرير الذي أختاره مدير القسم هل تقرير اليوم أو الأسبوع أو الشهر
  AbsencesReportType reportType;
  // عنوان التقرير بتحديد الفتره (اليوم - هذا الأسبوع - هذا الشهر)
  String reportTitle = "";

  // عند بداية تشغيل الشاشة الرئيسية
  @override
  void initState() {
    super.initState();
    // عند الدخول لشاشة تقرير الغياب يفحص اذا تم اختيار نوع التقرير أو يضع بشكل افتراض التقرير حسب اليوم الحالي
    if (reportType == null) {
      reportTitle = "هذا اليوم :";
      reportType = AbsencesReportType.today;
    }
    // طلب تحميل التقارير و التأخيرات
    getAbsencesAndLateReport();
  }

// فكشن نطلب من خلالها قوائم التقارير الخاصه بالغياب و التاخير وتحديد الفتره خلال اليوم الحالي أو الأسبوع أو الشهر
  Future<List> getAbsencesAndLateReport() async {
    // متغير سيحوي قائمة الموظفين المتغيبين
    var absencesResult;
    // متغير سيحوي قائمة الموظفين المتأخرين
    var employeesLateResult;
    switch (reportType) {
      // إذا لم اختار المستخدم تقرير الأسبوع الحالي
      case AbsencesReportType.thisWeek:
        // طلب بيانات التقرير الغياب
        absencesResult = AbsenceAndLateServices()
            .getAbsencesThisWeekReport(widget.currentUserInfo.departmentId);
        // طلب تقرير المتأخرين
        employeesLateResult = AbsenceAndLateServices()
            .getLateEmployeesThisWeekReport(
                widget.currentUserInfo.departmentId);
        break;
      // إذا لم اختار المستخدم تقرير الشهر الحالي
      case AbsencesReportType.thisMonth:
        // طلب بيانات التقرير الغياب
        absencesResult = AbsenceAndLateServices()
            .getAbsencesThisMonthReport(widget.currentUserInfo.departmentId);
        // طلب تقرير المتأخرين
        employeesLateResult = AbsenceAndLateServices()
            .getLateEmployeesThisMonthReport(
                widget.currentUserInfo.departmentId);
        break;
      // إذا لم يختر المستخدم أي شيء سيظهر تقرير اليوم الحالي
      default:
        // طلب بيانات التقرير الغياب
        absencesResult = AbsenceAndLateServices()
            .getAbsencesTodayReport(widget.currentUserInfo.departmentId);
        // طلب تقرير المتأخرين
        employeesLateResult = AbsenceAndLateServices()
            .getLateEmployeesTodayReport(widget.currentUserInfo.departmentId);
        break;
    }

    // تحديث الشاشة و عرض قوائم الغياب و التأخير
    setState(() {
      // نقل قائمة الغياب الى المتغير العام حتى تستطيع أن تقرأه الشاشه
      _absencesReport = absencesResult;
      // نقل قائمة المتأخرين الى المتغير العام حتى تستطيع أن تقرأه الشاشه
      _lateEmployeeReport = employeesLateResult;
    });

    return absencesResult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: NavigationDrawer(currentUserInfo: widget.currentUserInfo)),
        body: RefreshIndicator(
          color: Colors.blue,
          onRefresh: () {
            return getAbsencesAndLateReport(); // EDITED
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
                      Stack(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  FlatButton(
                                      onPressed: () {
                                        // اختار المدير تقرير خلال فترة اليوم الحالي
                                        reportType = AbsencesReportType.today;
                                        // تحديث القوائم خلال الفترة المحدده
                                        getAbsencesAndLateReport();
                                        setState(() {
                                          reportTitle = "هذا اليوم :";
                                        });
                                      },
                                      child: Text('اليوم')),
                                  FlatButton(
                                      onPressed: () {
                                        // اختار المدير تقرير خلال الأسبوع الحالي
                                        reportType =
                                            AbsencesReportType.thisWeek;
                                        // تحديث القوائم خلال الفترة المحدده
                                        getAbsencesAndLateReport();
                                        setState(() {
                                          reportTitle = "هذا الأسبوع :";
                                        });
                                      },
                                      child: Text('الأسبوع')),
                                  FlatButton(
                                      onPressed: () {
                                        // اختار المدير تقرير خلال الشهر الحالي
                                        reportType =
                                            AbsencesReportType.thisMonth;
                                        // تحديث القوائم خلال الفترة المحدده
                                        getAbsencesAndLateReport();
                                        setState(() {
                                          reportTitle = "هذا الشهر :";
                                        });
                                      },
                                      child: Text('الشهر')),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      FutureBuilder<List<Absence>>(
                          // طلب تحميل تقرير الغياب
                          future: _absencesReport,
                          // بناؤ الواجهه الشاشة خلال فترة طلب التقرير
                          builder: (c, snapshot) {
                            switch (snapshot.connectionState) {
                              // عند فتح الشاشة لأول مره
                              // في حالة الاتصال بقاعدة البيانات فانه يظهر حركة بأنه يتم التحميل
                              case ConnectionState.none:
                              case ConnectionState.active:
                              case ConnectionState.waiting:
                                return PKCardPageSkeleton();
                              // في حال انتهاء جلب البيانات الموظفين
                              case ConnectionState.done:
                                // اذا ظهر خطأ فانه يظهر الخطأ في الشاشة
                                if (snapshot.hasError)
                                  return Text('Error: ${snapshot.error}');
                                if (snapshot.data == null)
                                  return Text("لا يوجد غياب في الفترة المحدده");
                                // في حالة وجد تقرير بأيام الغياب يظهر القائمة
                                if (snapshot.hasData)
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Text(
                                          // عرض عنوان التقرير بتحديد الفتره (اليوم - هذا الأسبوع - هذا الشهر)
                                          reportTitle ?? "",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: gold,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "غياب :",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // كلاس أنشأناه يعرض تقرير ايام الغياب
                                        absencesReportWidget(snapshot.data),
                                      ],
                                    ),
                                  );
                                else
                                  return Center(
                                      child: Text(
                                          "لا يوجد غياب في الفترة المحدده"));
                                break;
                              default:
                                return null;
                            }
                          }),
                      FutureBuilder<List<Absence>>(
                          // طلب تحميل تقرير أيام التأخير
                          future: _lateEmployeeReport,
                          builder: (c, snapshot) {
                            switch (snapshot.connectionState) {
                              // عند فتح الشاشة لأول مره
                              // في حالة الاتصال بقاعدة البيانات فانه يظهر حركة بأنه يتم التحميل
                              case ConnectionState.none:
                              case ConnectionState.active:
                              case ConnectionState.waiting:
                                return PKCardPageSkeleton();
                              // في حال انتهاء جلب البيانات الموظفين
                              case ConnectionState.done:
                                // اذا ظهر خطأ فانه يظهر الخطأ في الشاشة
                                if (snapshot.hasError)
                                  return Text('Error: ${snapshot.error}');
                                if (snapshot.data == null)
                                  return Text("لا يوجد غياب في الفترة المحدده");
                                // في حالة وجد أسماء موظفين يعرضهم بالقائمة
                                if (snapshot.hasData)
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Text(
                                          "تأخير :",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // كلاس أنشأناه يعرض تقرير ايام التأخير
                                        lateEmployeeReportWidget(snapshot.data),
                                      ],
                                    ),
                                  );
                                else
                                  return Center(child: Text("لا يوجد متأخرين"));
                                break;
                              default:
                                return null;
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
