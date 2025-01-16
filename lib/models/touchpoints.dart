import 'package:flutter/material.dart';

class Touchpoints {
  Paint paint;
  Offset points;
  Touchpoints({required this.points, required this.paint});


  Map<String, dynamic> toJson(){
    return {
      'point': {
        'dx': "${points.dx}",
        'dy': '${points.dy}'
      }

    };
  }
}