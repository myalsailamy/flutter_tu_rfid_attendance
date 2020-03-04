// To parse this JSON data, do
//
//     final employee = employeeFromJson(jsonString);

import 'dart:convert';

EmployeeInfo employeeFromJson(String str) =>
    EmployeeInfo.fromJson(json.decode(str));
String employeeToJson(EmployeeInfo data) => json.encode(data.toJson());
List<EmployeeInfo> employeesFromJson(String str) => List<EmployeeInfo>.from(
    json.decode(str).map((x) => EmployeeInfo.fromJson(x)));
String employeesToJson(List<EmployeeInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeInfo {
  int id;
  String empNo;
  String fName;
  String lName;
  String gender;
  DateTime bod;
  String email;
  String phone;
  int departmentId;
  int managerId;
  String rfCardId;
  String userName;
  String password;

  EmployeeInfo({
    this.id,
    this.empNo,
    this.fName,
    this.lName,
    this.gender,
    this.bod,
    this.email,
    this.phone,
    this.departmentId,
    this.managerId,
    this.rfCardId,
    this.userName,
    this.password,
  });

  factory EmployeeInfo.fromJson(Map<String, dynamic> json) => EmployeeInfo(
        id: json["id"] == null ? null : json["id"],
        empNo: json["empNo"] == null ? null : json["empNo"],
        fName: json["fName"] == null ? null : json["fName"],
        lName: json["lName"] == null ? null : json["lName"],
        gender: json["gender"] == null ? null : json["gender"],
        bod: json["bod"] == null ? null : DateTime.parse(json["bod"]),
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        departmentId:
            json["departmentId"] == null ? null : json["departmentId"],
        managerId: json["managerId"] == null ? null : json["managerId"],
        rfCardId: json["rfCardId"] == null ? null : json["rfCardId"],
        userName: json["userName"] == null ? null : json["userName"],
        password: json["password"] == null ? null : json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "empNo": empNo == null ? null : empNo,
        "fName": fName == null ? null : fName,
        "lName": lName == null ? null : lName,
        "gender": gender == null ? null : gender,
        "bod": bod == null ? null : bod.toIso8601String(),
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "departmentId": departmentId == null ? null : departmentId,
        "managerId": managerId == null ? null : managerId,
        "rfCardId": rfCardId == null ? null : rfCardId,
        "userName": userName == null ? null : userName,
        "password": password == null ? null : password,
      };
}
