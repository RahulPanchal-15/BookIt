import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

class GooglePixel51 extends StatelessWidget {
  GooglePixel51();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(size: 226.0, middle: 0.4551),
            Pin(size: 132.0, middle: 0.2017),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff121f3d),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(start: 91.0, end: 91.0),
            Pin(size: 66.0, middle: 0.5427),
            child: Text(
              'hello Flutter\n',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 25,
                color: const Color(0xff707070),
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
