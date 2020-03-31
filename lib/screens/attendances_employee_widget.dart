import 'package:flutter/material.dart';
// كلاس تقرير الحضور
import '../services/attendance.dart';

// فكشن مهمتها نرسل لها تقرير الحضور من قاعدة البيانات وهي تقوم بعرضها و تصميم جدول الحضور للموظف خلال شهر واحد في الواجهه
SingleChildScrollView uiAttendancesEmployeeReportWidget(
    //  تقرير الحضور حتى يتم تنسيقه في الواجهه
    List<Attendance> attendancesReport) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        // إعدادات القوائم جدول تقرير  الحضور
        columns: [
          DataColumn(
            label: Text(
              'اليوم',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.black87),
            ),
          ),
          DataColumn(
            label: Text(
              'الوقت',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.black87),
            ),
          ),
          DataColumn(
            label: Text(''),
          )
        ],
        // عرض بيانات التحضير
        rows: attendancesReport
            .map(
              (employee) => DataRow(cells: [
                DataCell(
                  // اليوم
                  Text(employee.date),
                ),
                DataCell(
                  Text(
                    // وقت الحضور
                    employee.time,
                  ),
                ),
                DataCell(IconButton(
                  // أيقونة حالة الحضور
                  icon: employee.isPresent == true
                      // صح اذا حضر
                      ? Icon(Icons.check)
                      // اكس أذا لم يحضر
                      : Icon(Icons.clear),
                ))
              ]),
            )
            .toList(),
      ),
    ),
  );
}
