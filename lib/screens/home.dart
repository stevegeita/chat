import 'package:chat/models/message.dart';
import 'package:chat/screens/login.dart';
import 'package:chat/widgets/circular.dart';

import 'package:flutter/material.dart';
import 'package:chat/models/fav.dart';
import 'package:chat/widgets/categoryselector.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 40,
            color: Colors.white,
            onPressed: null,
            alignment: Alignment.centerRight,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          height:
              orientation == Orientation.portrait ? size.height : size.width,
          width: size.width,
          child: Column(
            children: <Widget>[
              CategorySelector(),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Favorite Contacts",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.redAccent,
                            ),
                            onPressed: null,
                            iconSize: 15,
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Barua(),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100,
                            color: Colors.white70,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.only(left: 10.0),
                                itemCount: favorites.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Circular(
                                            width: 50,
                                            height: 50,
                                            image: images[index]),
                                        SizedBox(height: 8.0),
                                        Text(
                                          favorites[index],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ClipRect(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                                // bottomLeft: Radius.circular(20.0),
                                // bottomRight: Radius.circular(20.0),
                              ),
                            ),
                            child: ListView.builder(
                                itemCount: favorites.length,
                                physics: ScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomRight:
                                                  Radius.circular(20))),
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Circular(
                                                width: 70,
                                                height: 70,
                                                image: images[index]),
                                          ),
                                          Spacer(flex: 1),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                favorites[index],
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => LoginPage(),
                                                  ),
                                                ),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.65,
                                                  child: Text(
                                                    "Hello there I'm Steve and I live in Nyeri and I like sushi",
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(flex: 3),
                                          Column(
                                            children: <Widget>[
                                              Text("02:20 "),
                                              Text(
                                                "New",
                                                style: TextStyle(
                                                    backgroundColor:
                                                        Colors.red),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
