import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

class GraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    final now = DateTime.now();

    Map<DateTime, double> data = {
      now.add(Duration(days: -6)) : 22,
      now.add(Duration(days: -5)) : 40,
      now.add(Duration(days: -4)) : 12,
      now.add(Duration(days: -3)) : 30004,
      now.add(Duration(days: -2)) : 67,
      now.add(Duration(days: -1)) : 54,
      now : 3,
    };

    int dataLength = data.length - 1;
    int horizontalLine = 5;
    int topScaleNumber = 0;

    double padding = 50;
    double graphWidth = size.width - 2 * padding ;
    double graphHeight = size.height - 2 * padding - 30;

    int calcTopScaleNumber() {
      double maxValue = data.values.toList().reduce(max);
      if(maxValue < 10) {
        topScaleNumber = 10;
      } else {
        int multiTen = 1;
        for(int i = 1; i < maxValue.round().toString().length; i++) {
          multiTen = multiTen * 10;
        }
        topScaleNumber = (maxValue ~/ multiTen + 1) * multiTen;
      }
      return topScaleNumber;
    }
    topScaleNumber = calcTopScaleNumber();

    for(int i = 0; i <= dataLength; i++) {
      canvas.drawLine(
          Offset(graphWidth / dataLength * i + padding, 50),
          Offset(graphWidth / dataLength * i + padding, size.height - 50),
          Paint()
            ..strokeWidth = 1
            ..color = Colors.white
      );
      TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: DateFormat('M/d').format(data.keys.toList()[i]),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12
          )
        )
      )
        ..layout()
        ..paint(canvas, Offset(
            graphWidth / dataLength * i + padding - 10, size.height - 50 + 10)
      );
    }
    for(int i = 0; i <= horizontalLine; i++) {
      canvas.drawLine(
          Offset(padding - 10, size.height - padding - graphHeight / horizontalLine * i),
          Offset(size.width - padding + 10, size.height - padding - graphHeight / horizontalLine * i),
          Paint()..color = Colors.white
      );

      TextPainter(
          textDirection: TextDirection.ltr,
          text: TextSpan(
              text: (topScaleNumber / horizontalLine * i).round().toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12
              )
          )
      )
        ..layout()
        ..paint(canvas, Offset(
            padding - 27, size.height - padding - graphHeight / horizontalLine * i - 6)
        );
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}