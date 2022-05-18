
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_fullter_app/screens/add-user.dart';
import 'package:my_fullter_app/screens/list-users.dart';
import 'components/loading-screen.dart';
import 'firebase_options.dart';
import 'screens/home-page.dart';
import 'screens/login.dart';
import 'screens/signin.dart';

class UserApp extends StatelessWidget {
  final Future<FirebaseApp> _init = Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final String title = 'User App';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _init,
        builder: (context, snapshot)
    {
      // Check for errors
      if (snapshot.hasError) {
        print("Has error");
        return LoadingKit();
      }

      if (snapshot.connectionState == ConnectionState.done) {
        return MaterialApp(
          title: title,
          theme: ThemeData(

            primarySwatch: Colors.blue,
          ),
          home: const HomePage(title: 'User App'),
          initialRoute: HomePage.id,
          routes: {
            Login.id: (context) => const Login(),
            Users.id: (context) => Users(),
            Signin.id: (context) => Signin(),
            AddUser.id: (context) => const AddUser(),
            HomePage.id: (context) => HomePage(title: title),
          });
      }
      return LoadingKit();
    });
  }
}
