import 'dart:math';

import 'package:chat/widgets/clipper.dart';
import 'package:flutter/material.dart';

class ClipContainer extends StatelessWidget {
  const ClipContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: Transform.rotate(
        angle: -pi / 3.5,
        child: ClipPath(
          clipper: Clipper(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xfffbb448), Color(0xffe46b10)])),
          ),
        ),
      )),
    );
  }
}
