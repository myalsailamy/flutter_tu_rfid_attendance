import 'package:flutter/material.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:tu_rfid_attendance/services/user_info.dart';
import '../helper/project_theme.dart';
import '../screens/user_info_screen.dart';
import '../services/employees_services.dart';
import '../services/employee_info.dart';

class EmployeesListScreen extends StatefulWidget {
  // قمنا بتعريف key كإسم للصفحة عرض معلومات المستخدم من أجل استدعاء الشاشه للانتقال اليها
  static const id = "employees_list_screen";
  final String title;
  final int departmentId;
  EmployeesListScreen({Key key, this.title, @required this.departmentId})
      : super(key: key);
  @override
  _EmployeesListScreenState createState() => _EmployeesListScreenState();
}

class _EmployeesListScreenState extends State<EmployeesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          // زر الرجوع
          leading: IconButton(
            // أيقونة الرجوع
            icon: Icon(Icons.arrow_back, color: Colors.black),
            // عند الضغط على زر الرجوع فإنه يرجع للصفحة السابقة
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        // محتوى صفحة معلومات عن التطبيق
        body: FutureBuilder<List<EmployeeInfo>>(
          future: EmployeesServices().loadEmployeesList(widget.departmentId),
          builder: (c, snapshot) {
            return snapshot.hasData
                ? ListView(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    children: snapshot.data
                        .map((data) => CardEmployee(
                              name: data.fName + ' ' + data.lName,
                              empId: data.empNo,
                              phone: data.phone,
                              // عند الضغط على الموظف يتم عرض بياناته
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserInfoScreen(
                                            title: data.userName,
                                            currentUserInfo: UserInfo(
                                                email: data.email,
                                                userName: data.userName,
                                                gender: data.gender,
                                                departmentId: data.departmentId,
                                                phone: data.phone,
                                                bod: data.bod,
                                                id: data.id,
                                                empNo: data.empNo,
                                                name: data.fName +
                                                    ' ' +
                                                    data.lName,
                                                role: 'employee',
                                                department: ''))));
                              },
                            ))
                        .toList())
                : PKCardListSkeleton(
                    isCircularImage: true,
                    isBottomLinesActive: true,
                    length: 10,
                  );
          },
        ));
  }
}

class CardEmployee extends StatelessWidget {
  CardEmployee({this.empId, this.name, this.phone, this.onTap});
  final String empId, name, phone;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: Card(
          elevation: 0.0,
          child: Container(
            // تزيين بطاقة الموظف باطار من اليمين و اليسار باللون الذهبي
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: gold,
                  width: 5.0,
                ),
                left: BorderSide(
                  color: gold,
                  width: 5.0,
                ),
              ),
            ),
            padding: EdgeInsets.all(3.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  onTap: onTap,
                  trailing: Icon(Icons.aspect_ratio),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Text(
                      name,
                      style: employeeNameStyle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text('الرقم الوظيفي', style: end2subtitle),
                          spaceH5,
                          Text(
                            empId,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text('الجوال', style: end2subtitle),
                          spaceH5,
                          Text(
                            phone,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
