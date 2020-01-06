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
/// - PenDown
/// - PenUp
/// - Left
/// - Right
/// - Forward
/// - SetColor
/// - ResetPosition
/// - ResetHeading
/// - Repeat
library flutter_turtle;

export 'src/turtle_commands.dart';
export 'src/turtle_state.dart';
export 'src/turtle_view.dart';
