import 'dart:ui';

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
