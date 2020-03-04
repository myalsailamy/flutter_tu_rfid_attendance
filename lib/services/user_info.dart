// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  final String userName;
  final int id;
  final String empNo;
  final String name;
  final String gender;
  final DateTime bod;
  final String email;
  final String phone;
  final int departmentId;
  final String department;
  final String role;

  UserInfo({
    this.userName,
    this.id,
    this.empNo,
    this.name,
    this.gender,
    this.bod,
    this.email,
    this.phone,
    this.departmentId,
    this.department,
    this.role,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        userName: json["userName"] == null ? null : json["userName"],
        id: json["id"] == null ? null : json["id"],
        empNo: json["empNo"] == null ? null : json["empNo"],
        name: json["name"] == null ? null : json["name"],
        gender: json["gender"] == null ? null : json["gender"],
        bod: json["bod"] == null ? null : DateTime.parse(json["bod"]),
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        departmentId:
            json["departmentId"] == null ? null : json["departmentId"],
        department: json["department"] == null ? null : json["department"],
        role: json["role"] == null ? null : json["role"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName == null ? null : userName,
        "id": id == null ? null : id,
        "empNo": empNo == null ? null : empNo,
        "name": name == null ? null : name,
        "gender": gender == null ? null : gender,
        "bod": bod == null
            ? null
            : "${bod.year.toString().padLeft(4, '0')}-${bod.month.toString().padLeft(2, '0')}-${bod.day.toString().padLeft(2, '0')}",
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "departmentId": departmentId == null ? null : departmentId,
        "department": department == null ? null : department,
        "role": role == null ? null : role,
      };
}
