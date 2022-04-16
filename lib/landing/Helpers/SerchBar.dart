import 'package:aigolive/pre-login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:aigolive/account-setting/screens/NotificationsScreen.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.blue[600],
                  size: 22,
                ),
                border: _searchBorder(),
                focusedBorder: _searchBorder(),
                enabledBorder: _searchBorder(),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsScreen()),
              );
            },
            child: Container(
              child: Icon(
                Icons.notifications_none,
                color: Colors.grey[700],
                size: 32,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Container(
              child: Icon(
                Icons.lock,
                color: Colors.grey[700],
                size: 32,
              ),
            ),
          )
        ],
      ),
    );
  }

  OutlineInputBorder _searchBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blue[600],
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
    );
  }
}
