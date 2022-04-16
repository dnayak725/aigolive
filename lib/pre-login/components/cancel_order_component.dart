import 'package:flutter/material.dart';

class CancelOrderComponent extends StatelessWidget{
   var _value = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: Column(
        children: [
          Center(child: Text('Cancel order',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),)),
          SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Row(
                  children: [
                    Text("Order Number:  ",style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('#'+122.toString()),
                  ],
                ),
                Text('Cancel reason: ',style: TextStyle(fontWeight: FontWeight.bold),),
                Column(
                  children: <Widget>[
                    for (int i = 1; i <= 5; i++)
                      ListTile(
                        title: Text(
                          'Radio $i $_value',
                          style: Theme.of(context).textTheme.subtitle1.copyWith(color: i == 5 ? Colors.black38 : Colors.black),
                        ),
                        leading: Radio(
                          value: i,
                          groupValue: _value,
                          activeColor: Color(0xFF6200EE),
                          onChanged: i == 5 ? null : (value) {
                            // setState(() {
                              _value = value;
                              print(_value);
                            // });
                          },
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}