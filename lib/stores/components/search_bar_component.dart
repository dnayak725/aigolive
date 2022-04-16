import 'package:flutter/material.dart';

class SearchBarComponent extends StatefulWidget{
  @override
  _SearchBarComponentState createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            Icon(
              Icons.notifications_none,
              color: Colors.grey[700],
              size: 32,
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