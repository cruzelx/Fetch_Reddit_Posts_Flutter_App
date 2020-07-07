import 'package:flutter/material.dart';
import 'dart:math';

Color generateRandomColor() {
  final List<Color> colors = [
    Color(0xff076620),
    Color(0xff37756c),
    Color(0xff033454),
    Color(0xff031459),
    Color(0xff590348),
    Color(0xff8c0b4a),
    Color(0xff8c0b1c),
    Color(0xffa32218),
    Color(0xff02705e)
  ];

  Random randomNumber = new Random();
  Color randomColor = colors[randomNumber.nextInt(colors.length)];
  return randomColor;
}
