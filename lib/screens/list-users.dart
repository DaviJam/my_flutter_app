import 'dart:convert' as convert;
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:my_fullter_app/Services/UserService.dart';
import 'package:my_fullter_app/Services/authentication.dart';

import 'add-user.dart';
import 'home-page.dart';

class Users extends StatefulWidget {
  static const String id = "Users";

  Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final String title = "List of users";
  final _auth = FirebaseAuth.instance;
  final HttpHandler httpHandler = HttpHandler();


  void onDel(String email) {
    setState(() {
      print("Deleting user $email");
      httpHandler.deleteUser(email);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        Response resp = Response("", HttpStatus.noContent);
        if (!snapshot.hasError) {
          if (snapshot.hasData) {
            resp = snapshot.data as Response;
            print(resp.body);
          }
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("User list"),
            actions: [
              TextButton(
                onPressed: () {
                  setState((){
                    _auth.signOut();
                    Authentication.signOut(context: context);
                    Navigator.pushNamed(context, HomePage.id);
                  });
                },
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.blueGrey,
            onPressed: () {
              setState(() {
                Navigator.pushNamed(context, AddUser.id);
              });
            },
            label: Text("Add user"),
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: Column(
            children: [
              Flexible(
                child: ListView(
                  children: [
                    Builder(builder: (context) {
                      return SizedBox(
                        height: 603.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: widgetHandler(resp.body, onDel),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      future: httpHandler.getUsers(),
    );
  }
}

List<Widget> widgetHandler(dynamic data, Function onDelete) {
  List<Widget> widgetList = <Widget>[];
  if (data.isNotEmpty) {
    List dataList = convert.jsonDecode(data);
    dataList.forEach((element) {
      if (element.isNotEmpty) {
        widgetList.add(buildCard(
            element["username"] ?? "", element["email"] ?? "", onDelete));
      }
    });
  }
  return widgetList;
}

Card buildCard(String name, String email, Function onDelete) {
  return Card(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        children: [
          Expanded(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(name),
              subtitle: Text(email),
            ),
          ),
          TextButton(
            onPressed: () {
              onDelete(email);
            },
            child: Icon(Icons.delete),
          ),
        ],
      )
    ],
  ));
}
