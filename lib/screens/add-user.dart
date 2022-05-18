
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_fullter_app/screens/list-users.dart';

import '../Services/UserService.dart';
import '../model/user.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);
  static const String id = "AddUser";

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _auth = FirebaseAuth.instance;
  late bool _showSpinner = false;
  late bool _submitted = true;
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  ///********************** METHODS **************************/
  String? get _usernameErrorText {
    final text = _username.value.text;
    if (text.isEmpty) {
      return 'Enter a valid username';
    }
    return null;
  }
//**********************************************
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
//**********************************************
//   Future addNewUserInList(String email, String password) async {
//     return await (
//         email: email, password: password);
//   }
  ///********************** OVERWRITTEN METHODS **************************/
  @override
  void dispose(){
    _username.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    HttpHandler httpHandler = HttpHandler();
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade200,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Add a new user",style: TextStyle(fontSize: 50,color: Colors.white70)),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ValueListenableBuilder(
                        valueListenable: _username,
                        builder: (BuildContext context, value, Widget? child) {
                          return TextFormField(
                            controller: _username,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.blueGrey.shade700),
                              helperText:  'Enter your name',
                              errorText: _submitted ? null : _usernameErrorText,
                              icon: Icon(Icons.person,color: Colors.white),
                            ),
                          );
                        }
                    ),
                    ValueListenableBuilder(
                        valueListenable: _email,
                        builder: (BuildContext context, value, Widget? child) {
                          return TextFormField(
                            controller: _email,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.blueGrey.shade700),
                              helperText:  'Enter your email',
                              errorText: _submitted ? null : _emailErrorText,
                              icon: Icon(Icons.mail,color: Colors.white),
                            ),
                          );
                        }
                    ),
                    ValueListenableBuilder(
                        valueListenable: _password,
                        builder: (BuildContext context, value, Widget? child) {
                          return TextFormField(
                            controller: _password,
                            obscureText: true,
                            decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.blueGrey.shade700),
                                icon: Icon(Icons.password,color: Colors.white),
                                helperText: 'Enter your password',
                                errorText: _submitted ? null : _passwordErrorText
                            ),
                          );
                        }
                    ),
                    ElevatedButton(
                      onPressed: ()  {
                        setState(()  {
                          _showSpinner = true;
                          if(_passwordErrorText == null && _emailErrorText == null) {
                            _submitted = true;
                                () async {
                              try {
                                final response = await httpHandler.addUser(CustomUser(_username.text, _email.text, _password.text)).then(
                                  (value) => {
                                    if (value.statusCode == 201) {
                                      print(_username.text),
                                      print(_email.text),
                                      print(_password.text),
                                      print("USER CREATED"),
                                    //Navigator.pushNamed(context, Login.id);
                                    showDialog(
                                        context: context, builder: _buildPopupDialog),
                                    _showSpinner = false
                                  } else {
                                      print('${value.body}, ${value.statusCode}')
                                    }
                                  },
                                  onError: (error)=> print(error));
                              } catch (e) {
                                print(e);
                              }
                            }();

                          } else {
                            _submitted = false;
                          }

                        });


                      },
                      child: Text("Add"),
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

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Add new user'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text("Successfully done!"),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          // Navigate
          Navigator.pushNamed(context, Users.id);
        },
        child: const Text('Close'),
      ),
    ],
  );
}