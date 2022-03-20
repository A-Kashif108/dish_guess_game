import 'dart:async';
import 'package:flutter/material.dart';

class CorrectAnimation extends StatefulWidget {
  const CorrectAnimation({Key? key}) : super(key: key);

  @override
  _CorrectAnimationState createState() => _CorrectAnimationState();
}

class _CorrectAnimationState extends State<CorrectAnimation> {
    bool check = false;


  @override
  Widget build(BuildContext context) {
    Timer(const Duration(milliseconds: 200), (){
      setState(() {
        check=true;
      });

    });
    return AnimatedPositioned(
        top: check?10:480,
        left: 100,
        duration: const Duration(seconds: 2),
        curve: Curves.fastLinearToSlowEaseIn,
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                color: Colors.transparent,
                height: 80,
                width: 80,
                child: Image(image: AssetImage('assets/victory.png'))),
            Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                color: Colors.transparent,
                height: 70,
                width: 70,
                child: Image(image: AssetImage('assets/victory.png'))),
            Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                color: Colors.transparent,
                height: 80,
                width: 80,
                child: Image(image: AssetImage('assets/victory.png'))),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
                color: Colors.transparent,
                height: 80,
                width: 80,
                child: Image(image: AssetImage('assets/victory.png'))),
            Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                color: Colors.transparent,
                height: 80,
                width: 80,
                child: Image(image: AssetImage('assets/victory.png'))),
            Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                color: Colors.transparent,
                height: 70,
                width: 70,
                child: Image(image: AssetImage('assets/victory.png'))),
            Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                color: Colors.transparent,
                height: 80,
                width: 80,
                child: Image(image: AssetImage('assets/victory.png'))),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
                color: Colors.transparent,
                height: 80,
                width: 80,
                child: Image(image: AssetImage('assets/victory.png'))),
            Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                color: Colors.transparent,
                height: 80,
                width: 80,
                child: Image(image: AssetImage('assets/victory.png'))),
            Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                color: Colors.transparent,
                height: 70,
                width: 70,
                child: Image(image: AssetImage('assets/victory.png'))),
            Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                color: Colors.transparent,
                height: 80,
                width: 80,
                child: Image(image: AssetImage('assets/victory.png'))),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
                color: Colors.transparent,
                height: 80,
                width: 80,
                child: Image(image: AssetImage('assets/victory.png'))),
            Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                color: Colors.transparent,
                height: 80,
                width: 80,
                child: Image(image: AssetImage('assets/victory.png'))),
            Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                color: Colors.transparent,
                height: 70,
                width: 70,
                child: Image(image: AssetImage('assets/victory.png'))),
            Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                color: Colors.transparent,
                height: 80,
                width: 80,
                child: Image(image: AssetImage('assets/victory.png'))),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
                color: Colors.transparent,
                height: 80,
                width: 80,
                child: Image(image: AssetImage('assets/victory.png'))),

          ],
        ),
    );
  }
}
