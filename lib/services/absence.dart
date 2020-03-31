// To parse this JSON data, do
//
//     final absences = absencesFromJson(jsonString);

import 'dart:convert';

List<Absence> absencesFromJson(String str) =>
    List<Absence>.from(json.decode(str).map((x) => Absence.fromJson(x)));
String absencesToJson(List<Absence> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
Absence absenceFromJson(String str) => Absence.fromJson(json.decode(str));
String absenceToJson(Absence data) => json.encode(data.toJson());

class Absence {
  final String empName;
  final String date;

  Absence({
    this.empName,
    this.date,
  });

  factory Absence.fromJson(Map<String, dynamic> json) => Absence(
        empName: json["empName"] == null ? null : json["empName"],
        date: json["date"] == null ? null : json["date"],
      );

  Map<String, dynamic> toJson() => {
        "empName": empName == null ? null : empName,
        "date": date == null ? null : date,
      };
}
