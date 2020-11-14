import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedindex = 0;
  final List<String> categories = ["Messages", "Online", "Groups", "Settings"];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedindex = index;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 20.0,
              ),
              child: Text(categories[index],
                  style: TextStyle(
                    color:
                        index == selectedindex ? Colors.white : Colors.white70,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    fontSize: 26.0,
                  )),
            ),
          );
        },
      ),
    );
  }
}
