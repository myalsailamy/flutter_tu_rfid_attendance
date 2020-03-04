// To parse this JSON data, do
//
//     final changePassword = changePasswordFromJson(jsonString);

import 'dart:convert';

ChangePassword changePasswordFromJson(String str) =>
    ChangePassword.fromJson(json.decode(str));

String changePasswordToJson(ChangePassword data) => json.encode(data.toJson());

class ChangePassword {
  final String email;
  final String newPassword;

  ChangePassword({
    this.email,
    this.newPassword,
  });

  factory ChangePassword.fromJson(Map<String, dynamic> json) => ChangePassword(
        email: json["email"] == null ? null : json["email"],
        newPassword: json["newPassword"] == null ? null : json["newPassword"],
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "newPassword": newPassword == null ? null : newPassword,
      };
}
