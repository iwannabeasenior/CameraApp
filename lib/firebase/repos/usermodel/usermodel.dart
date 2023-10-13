import 'package:flutter/material.dart';
class UserModel {
    // final String? id;
    // final String fullName;
    final String email;
    // final String phoneNo;
    final String password;
    const UserModel({
      // this.id,
      required this.email,
      required this.password,
      // required this.fullName,
      // required this.phoneNo,
    });
    toJson() {
      return {
        // "FullName": fullName,
        "email": email,
        // "Phone": phoneNo,
        "passWord": password,
      };
    }
}