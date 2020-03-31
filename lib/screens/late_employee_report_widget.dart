import 'package:flutter/material.dart';
// كلاس بيانات التأخير
import '../services/absence.dart';

// فكشن مهمتها نرسل لها تقرير أيام التأخير من قاعدة البيانات وهي تقوم بعرضها و تصميم قائمة في الواجهه
Card lateEmployeeReportWidget(
    //  تقرير أيام التأخير حتى يتم تنسيقه في الواجهه
    List<Absence> lateEmployeeReport) {
  return Card(
    color: Colors.grey[300],
    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
    child: DataTable(
      // إعدادات القوائم جدول تقرير  الحضور
      headingRowHeight: 0.0,
      columns: [
        DataColumn(label: Text('')),
        DataColumn(label: Text('')),
      ],

      // عرض بيانات التحضير
      rows: lateEmployeeReport
          .map(
            (employee) => DataRow(cells: [
              DataCell(
                // اسم الموظف
                Text(employee.empName),
              ),
              DataCell(
                Text(
                  // التاريخ
                  employee.date,
                ),
              ),
            ]),
          )
          .toList(),
    ),
  );
}
