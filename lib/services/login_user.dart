// To parse this JSON data, do
//
//     final loginUser = loginUserFromJson(jsonString);

import 'dart:convert';

LoginUser loginUserFromJson(String str) => LoginUser.fromJson(json.decode(str));

String loginUserToJson(LoginUser data) => json.encode(data.toJson());

class LoginUser {
  final String userName;
  final String password;

  LoginUser({
    this.userName,
    this.password,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
        userName: json["userName"] == null ? null : json["userName"],
        password: json["password"] == null ? null : json["password"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName == null ? null : userName,
        "password": password == null ? null : password,
      };
}
