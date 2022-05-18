import 'package:flutter/material.dart';
import 'package:my_fullter_app/components/AppBar.dart';
import 'package:my_fullter_app/components/google-sign-in-button.dart';
import 'package:my_fullter_app/screens/login.dart';
import 'package:my_fullter_app/screens/signin.dart';
import 'list-users.dart';

class HomePage extends StatefulWidget {
  static const String id = "HomePage";
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  late Menu selectedMenu = Menu.List;
  void appBarFunction(Menu item) {
    setState(() {
      selectedMenu = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Center(
              child: Text(
                "Welcome to \n \n User App",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "RobotoMono",
                    color: Colors.blueAccent),
              ),
            ),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blueAccent),
                    onPressed: () => {
                          Navigator.pushNamed(context, Login.id),
                        },
                    child: Text("Login")),
                SizedBox(width: 5),
                TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blueAccent),
                    onPressed: () => {
                          Navigator.pushNamed(context, Signin.id),
                        },
                    child: Text("Sign in")),
              ],
            ),
            SizedBox(width: 2),
            GoogleSignInButton()
          ],
        ),
      ),
    );
  }
}
