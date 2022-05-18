import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'list-users.dart';

class Login extends StatefulWidget {
  static const String id = "Login";
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ///********************** VARIABLES **************************/
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  late bool _submitted = true;
  ///********************** METHODS **************************/
  String? get _emailErrorText {
    final text = _email.value.text;
    if (text.isEmpty) {
      return 'Enter a valid email';
    }
    return null;
  }
//**********************************************
  String? get _passwordErrorText {
    final text = _password.value.text;
    if (text.isEmpty || text.length < 6) {
      return 'Enter a valid password. It should be at least 6 characters long';
    }
    return null;
  }

  @override
  void dispose(){
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade200,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("User App",style: TextStyle(fontSize: 50,color: Colors.white70)),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ValueListenableBuilder(
                      builder: (BuildContext context, value, Widget? child) {
                        return TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                            helperText: "Email",
                            errorText: _submitted ? null : _emailErrorText,
                            icon: const Icon(Icons.mail,color: Colors.white),
                          ),
                        );
                      }, valueListenable: _email,
                    ),
                    ValueListenableBuilder(
                      builder: (BuildContext context, value, Widget? child) {
                        return TextFormField(
                          controller: _password,
                          decoration: InputDecoration(
                            helperText: "Password",
                            errorText: _submitted ? null : _passwordErrorText,
                            icon: const Icon(Icons.password,color: Colors.white),
                          ),
                          obscureText: true,
                        );
                      }, valueListenable: _password,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {

                          if(_emailErrorText == null && _passwordErrorText == null){
                            _submitted = true;
                            () async {
                              try {
                                Future<UserCredential> userCred = _auth.signInWithEmailAndPassword(
                                    email: _email.text,
                                    password: _password.text);

                                userCred.then((value) => {
                                  if(value.user != null){
                                    Navigator.pushNamed(context, Users.id)
                                  }
                                });
                              } catch(error){
                                print(error);
                              }
                            }();
                          } else {
                            _submitted = false;
                          }

                        });
                      },
                      child: const Text("Login"),
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(Colors.lightBlue.shade200),
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
