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
///
/// ### Flow Control
///
/// - IfElse
/// - Repeat
///
/// ### Macros
///
/// - SetMacro
/// - RunMacro
///
/// ### Misc
///
/// - Exec
///

library flutter_turtle;

export 'src/animated_turtle_view.dart';
export 'src/commands/back.dart';
export 'src/commands/forward.dart';
export 'src/commands/go_to.dart';
export 'src/commands/if_else.dart';
export 'src/commands/left.dart';
export 'src/commands/pen_down.dart';
export 'src/commands/pen_up.dart';
export 'src/commands/repeat.dart';
export 'src/commands/reset_heading.dart';
export 'src/commands/reset_position.dart';
export 'src/commands/right.dart';
export 'src/commands/run_macro.dart';
export 'src/commands/set_color.dart';
export 'src/commands/set_macro.dart';
export 'src/commands/set_stroke_width.dart';
export 'src/commands/stop.dart';
export 'src/turtle_commands.dart';
export 'src/turtle_state.dart';
export 'src/turtle_view.dart';
