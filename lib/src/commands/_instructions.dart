import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../painter.dart';
import '../turtle_commands.dart';

/// An instruction that draws a line.
///
/// This class implements the [Instruction] interface and is used to represent a
/// command to draw a line in the turtle graphics system.
@immutable
class DrawLineInstruction implements Instruction {
  /// The starting point of the path instruction.
  ///
  /// This represents the initial point from which a path operation begins. Used
  /// within path instructions to define the starting coordinate for drawing
  /// operations.
  final Offset begin;

  /// The end position (as [Offset]) of the instruction.
  ///
  /// Represents the final point or destination for operations like movement or
  /// drawing lines.
  final Offset end;

  /// Represents a command to draw a line from a starting point to an ending
  /// point.
  ///
  /// The [begin] parameter specifies the starting point of the line. The [end]
  /// parameter specifies the ending point of the line.
  const DrawLineInstruction(this.begin, this.end);

  @override
  exec(PaintContext context) {
    final beginOffset = context.center + begin;
    final endOffset = context.center + end;
    context.canvas.drawLine(beginOffset, endOffset, context.paint);
  }
}

/// Represents an instruction for drawing text on the canvas.
///
/// This instruction is used to render text at the current position of the
/// turtle in the turtle graphics system.
///
/// Implements the [Instruction] interface, which allows it to be executed by
/// the turtle interpreter.
@immutable
class DrawTextInstruction implements Instruction {
  /// The text command or parameter for a turtle operation.
  ///
  /// This property holds a string value that represents a specific instruction
  /// or parameter for the turtle drawing operation. The interpretation of this
  /// text depends on the context in which the command is used.
  final String text;

  /// The current position of the turtle in the Cartesian coordinate system.
  ///
  /// This represents the x and y coordinates of the turtle's position.
  final Offset position;

  /// The angle in degrees to rotate the turtle.
  ///
  /// Positive values rotate the turtle counter-clockwise, while negative values
  /// rotate it clockwise.
  final double degrees;

  /// The height of the label.
  ///
  /// This property determines the vertical space occupied by the label when
  /// rendered.
  final double labelHeight;

  /// Represents the color value to be used for subsequent drawing operations.
  ///
  /// This property is used by various turtle commands to set the color of drawn
  /// elements such as lines, shapes, or fill areas. The color is specified
  /// using Flutter's [Color] class.
  final Color color;

  /// Represents an instruction to draw a text at the current position.
  ///
  /// This instruction is part of the drawing operations in the Flutter Turtle
  /// library. It renders the specified text at the current cursor position.
  const DrawTextInstruction({
    required this.text,
    required this.position,
    required this.labelHeight,
    required this.degrees,
    required this.color,
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
    tp.paint(context.canvas, const Offset(0.0, 0.0));
    context.canvas.restore();
  }
}

/// An instruction to set the color of the pen.
///
/// This class implements [Instruction] and is used to change the color of the
/// lines drawn by the turtle. The color change will affect all subsequent
/// drawing operations until another SetColorInstruction is executed.
class SetColorInstruction implements Instruction {
  /// The color used in the graphics commands.
  ///
  /// This property defines the color to be applied to elements drawn by the
  /// turtle. For instance, when the turtle draws a line or fills a shape, this
  /// color will be used.
  final Color color;

  /// An instruction to set the color of the turtle's pen.
  ///
  /// The [color] parameter specifies the new color to be used for drawing.
  SetColorInstruction(this.color);

  @override
  exec(PaintContext context) => context.paint.color = color;
}

/// Instruction for setting the stroke width of the turtle's path.
///
/// This instruction changes the width of the lines drawn by the turtle. The
/// width is specified in logical pixels.
class SetStrokeWidthInstruction implements Instruction {
  /// The width of the stroke when drawing shapes or paths.
  ///
  /// This property determines the thickness of the line when drawing. A value
  /// of 0.0 means no stroke (invisible line).
  final double strokeWidth;

  /// An instruction that sets the stroke width of the Turtle's pen.
  ///
  /// This instruction changes the width of the lines drawn by the Turtle.
  ///
  /// [strokeWidth] The width of the stroke in logical pixels.
  SetStrokeWidthInstruction(this.strokeWidth);

  @override
  exec(PaintContext context) => context.paint.strokeWidth = strokeWidth;
}
