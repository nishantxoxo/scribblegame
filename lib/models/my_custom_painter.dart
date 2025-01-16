import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:scribble_guesser_app/models/touchpoints.dart';

class MyCustomPainter extends CustomPainter {
  MyCustomPainter({required this.pointslist});
  List<Touchpoints> pointslist;
  List<Offset> offsetPoints = [];
  
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}