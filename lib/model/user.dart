import 'package:flutter/material.dart';

class CustomUser {
  final String username;
  final String email;
  final String password;

  const CustomUser(this.username, this.email, this.password, {Key? key});

  CustomUser.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        email = json['email'],
        password = "";

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'password':password
  };
}