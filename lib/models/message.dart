import 'package:chat/models/charts.dart';
import 'package:flutter/material.dart';

class Barua extends StatefulWidget {
  @override
  _BaruaState createState() => _BaruaState();
}

class _BaruaState extends State<Barua> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text(
            'Shirtup',
            style: TextStyle(
              color: Color(0xfffffdff),
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          elevation: 0.0,
          actions: [
            IconButton(
                icon: Icon(Icons.more_horiz),
                iconSize: 30,
                color: Colors.white,
                onPressed: null)
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(10),
                  ),
                  child: ListView.builder(
                      padding: EdgeInsets.only(top: 20, left: 30),
                      itemCount: chats.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text("Text test up");
                      }),
                ),
              ),
            ),
          ],
        ));
  }
}
