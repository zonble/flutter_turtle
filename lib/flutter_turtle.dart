/// flutter_turtle is a simple implementation of turtle graphics for Flutter.
/// It simply uses a custom painter to draw graphics by a series of Logo-like
/// commands.
///
/// For further information about turtle graphics, please visit Wikipedia:
///
/// - https://en.wikipedia.org/wiki/Turtle_graphics
/// - https://en.wikipedia.org/wiki/Logo_(programming_language)
///
/// Currently supported commands are including:
///
/// ### Turtle Motion
///
/// - PenDown
/// - PenUp
/// - Left
/// - Right
/// - Forward
/// - Back
/// - SetColor
/// - SetStrokeWidth
/// - GoTo
/// - ResetPosition
/// - ResetHeading
/// - Label
/// - SetLabelHeight
///
/// ### Flow Control
///
/// - If
/// - IfElse
/// - Repeat
///
/// ### Macros
///
/// - SetMacro
/// - RunMacro
///

library flutter_turtle;

export 'src/animated_turtle_view.dart';
export 'src/commands/commands.dart';
export 'src/controllable_turtle_view.dart';
export 'src/turtle_commands.dart';
export 'src/turtle_state.dart';
export 'src/turtle_view.dart';
