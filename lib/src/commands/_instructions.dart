import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../painter.dart';
import '../turtle_commands.dart';

class DrawLineInstruction implements Instruction {
  final Offset begin;
  final Offset end;

  DrawLineInstruction(this.begin, this.end);

  @override
  exec(PaintContext context) {
    final beginOffset = context.center + begin;
    final endOffset = context.center + end;
    context.canvas.drawLine(beginOffset, endOffset, context.paint);
  }
}

class DrawTextInstruction implements Instruction {
  final String text;
  final Offset position;
  final double degrees;
  final double labelHeight;
  final Color color;

  DrawTextInstruction({
    this.text,
    this.position,
    this.labelHeight,
    this.degrees,
    this.color,
  });

  @override
  exec(PaintContext context) {
    context.canvas.save();
    context.canvas.translate(
      position.dx + context.center.dx,
      position.dy + context.center.dy,
    );
    context.canvas.rotate(math.pi * degrees / 180.0);

    final span = TextSpan(
        style: TextStyle(color: color, fontSize: labelHeight), text: text);
    final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(context.canvas, new Offset(0.0, 0.0));
    context.canvas.restore();
  }
}

class SetColorInstruction implements Instruction {
  final Color color;

  SetColorInstruction(this.color);

  @override
  exec(PaintContext context) {
    context.paint.color = color;
  }
}

class SetStrokeWidthInstruction implements Instruction {
  final double strokeWidth;

  SetStrokeWidthInstruction(this.strokeWidth);

  @override
  exec(PaintContext context) {
    context.paint.strokeWidth = strokeWidth;
  }
}
