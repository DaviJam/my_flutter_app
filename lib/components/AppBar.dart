import 'package:flutter/material.dart';

enum Menu { List, Login, SignIn }

AppBar UserAppBar(BuildContext context,String title ,Function itemSelected) {
  return AppBar(
    centerTitle: true,
    // Here we take the value from the MyHomePage object that was created by
    // the App.build method, and use it to set our appbar title.
    leading:
    PopupMenuButton<Menu>(
      // Callback that sets the selected popup menu item.
        onSelected: (Menu item) {
          itemSelected(item);
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
          const PopupMenuItem<Menu>(
            value: Menu.List,
            child: Text('List users'),
          ),
          const PopupMenuItem<Menu>(
            value: Menu.Login,
            child: Text('Login'),
          ),
          const PopupMenuItem<Menu>(
            value: Menu.SignIn,
            child: Text('Sign in'),
          ),
        ]),
    title: Text(title),
    actions: <Widget>[

      IconButton(
        icon: Icon(Icons.exit_to_app),
        onPressed: () {
          //Implement logout functionality
          // _auth.signOut();
          // Navigator.pop(context);
        },),
    ],
  );
}


