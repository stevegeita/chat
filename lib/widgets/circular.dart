import 'package:flutter/material.dart';

class Circular extends StatelessWidget {
  final double width, height;
  final String image;
  const Circular(
      {Key key,
      @required this.width,
      @required this.height,
      @required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(image),
        ),
      ),
    );
  }
}
