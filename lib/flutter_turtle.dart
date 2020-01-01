/// flutter_turtle is a simple implementation of turtle graphics (see Wikipedia:
/// https://en.wikipedia.org/wiki/Turtle_graphics) for Flutter. It simply uses a
/// custom painter to draw graphics by a series of LOGO-like given commands.
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
export 'src/turtle_view.dart';
export 'src/turtle_state.dart';