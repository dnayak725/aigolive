import 'package:flutter/material.dart';

class AppDrawerHelp extends StatefulWidget {
  @override
  _AppDrawerHelpState createState() => _AppDrawerHelpState();
}

class _AppDrawerHelpState extends State<AppDrawerHelp> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(color: Colors.blueAccent),
          ),
          ListTile(
            title: Text('Log in'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Sign up'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Page 2'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => AllCategories()),
              // );
            },
          ),
          ListTile(
            title: Text('Page 3'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => CategoriesByDay()),
              // );
            },
          ),
        ],
      ),
    );
  }
}
