// To parse this JSON data, do
//
//     final attendances = attendancesFromJson(jsonString);

import 'dart:convert';

List<Attendance> attendancesFromJson(String str) =>
    List<Attendance>.from(json.decode(str).map((x) => Attendance.fromJson(x)));

String attendancesToJson(List<Attendance> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Attendance attendanceFromJson(String str) =>
    Attendance.fromJson(json.decode(str));

String attendanceToJson(Attendance data) => json.encode(data.toJson());

class Attendance {
  final String empNo;
  final String date;
  final String time;
  final bool isPresent;

  Attendance({
    this.empNo,
    this.date,
    this.time,
    this.isPresent,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        empNo: json["empNo"] == null ? null : json["empNo"],
        date: json["date"] == null ? null : json["date"],
        time: json["time"] == null ? null : json["time"],
        isPresent: json["isPresent"] == null ? null : json["isPresent"],
      );

  Map<String, dynamic> toJson() => {
        "empNo": empNo == null ? null : empNo,
        "date": date == null ? null : date,
        "time": time == null ? null : time,
        "isPresent": isPresent == null ? null : isPresent,
      };
}
