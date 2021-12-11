import 'package:flutter/material.dart';

class kNoData extends StatelessWidget {
  final String? text;
  final Color? color;
  const kNoData({Key? key, this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(Icons.info_outline, color: color, size: 40),
          Text(
            text!,
            style: TextStyle(
              color: color,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
