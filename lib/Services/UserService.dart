import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_fullter_app/constants/constants.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

class HttpHandler {

  Future<Response> getUsers() {
    var serverURL = Uri.parse('$serverUrl:$serverPort/$serviceName/$getUsersEndPoint');
    return http.get(serverURL);
  }

  Future<Response> addUser(CustomUser user) {
    var serverURL = Uri.parse('$serverUrl:$serverPort/$serviceName/$postUserEndPoint');
    return http.post(serverURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user)
    );
  }

  void deleteUser(String email) {
    var serverURL = Uri.parse('$serverUrl:$serverPort/$serviceName/$delUserEndPoint/$email');
    http.delete(serverURL);
  }
}
