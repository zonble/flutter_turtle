# GitHub Copilot Instructions for flutter_turtle

## Project Overview

`flutter_turtle` is a Flutter package that implements [turtle graphics](https://en.wikipedia.org/wiki/Turtle_graphics) using a [Logo](https://en.wikipedia.org/wiki/Logo_(programming_language))-inspired DSL (Domain-Specific Language). It uses a `CustomPainter` to draw graphics on a canvas by interpreting a series of command objects.

The package is published on [pub.dev](https://pub.dev/packages/flutter_turtle) and the source is hosted at https://github.com/zonble/flutter_turtle.

## Repository Structure

```
flutter_turtle/
├── lib/
│   ├── flutter_turtle.dart          # Main library entry point (re-exports everything)
│   ├── flutter_turtle_alias.dart    # Convenience aliases
│   └── src/
│       ├── animated_turtle_view.dart    # AnimatedTurtleView widget
│       ├── controllable_turtle_view.dart # ControllableTurtleView widget
│       ├── painter.dart                 # TurtlePainter (CustomPainter) and PaintContext
│       ├── turtle_commands.dart         # TurtleCommand and Instruction interfaces + TurtleCompiler
│       ├── turtle_state.dart            # TurtleState and Macro classes
│       ├── turtle_view.dart             # TurtleView widget
│       └── commands/
│           ├── _exceptions.dart         # Internal exceptions (StopException)
│           ├── _instructions.dart       # Internal instruction implementations
│           ├── commands.dart            # Barrel file re-exporting all commands
│           ├── back.dart                # Back command
│           ├── forward.dart             # Forward command
│           ├── go_to.dart               # GoTo command
│           ├── if.dart                  # If command
│           ├── if_else.dart             # IfElse command
│           ├── label.dart               # Label command
│           ├── left.dart                # Left (turn) command
│           ├── log.dart                 # Log command
│           ├── pen_down.dart            # PenDown command
│           ├── pen_up.dart              # PenUp command
│           ├── pop_state.dart           # PopState command
│           ├── repeat.dart              # Repeat command
│           ├── reset_heading.dart       # ResetHeading command
│           ├── reset_position.dart      # ResetPosition command
│           ├── right.dart               # Right (turn) command
│           ├── run_macro.dart           # RunMacro command
│           ├── save_state.dart          # SaveState command
│           ├── set_color.dart           # SetColor command
│           ├── set_label_height.dart    # SetLabelHeight command
│           ├── set_macro.dart           # SetMacro command
│           ├── set_orientation.dart     # SetOrientation command
│           ├── set_stroke_width.dart    # SetStrokeWidth command
│           └── stop.dart                # Stop command
├── example/                         # Example Flutter app
├── test/
│   └── flutter_turtle_test.dart     # Test file
├── analysis_options.yaml            # Dart linter configuration (uses flutter_lints)
└── pubspec.yaml                     # Package metadata and dependencies
```

## Architecture

The package uses a two-phase pipeline:

### Phase 1 – Compilation (`TurtleCompiler.compile`)

A list of `TurtleCommand` objects is compiled into a flat list of `Instruction` objects. During compilation, `TurtleState` is used to track the turtle's position, heading, pen state, color, stroke width, macros, and the turtle stack. This phase resolves all control-flow (loops, conditionals, macros) eagerly.

### Phase 2 – Rendering (`TurtlePainter.paint`)

The flat list of `Instruction` objects is executed sequentially against a `PaintContext` (which holds a Flutter `Canvas`, a `Paint`, and the center `Offset`). Instructions perform actual drawing on the canvas.

### Key types

| Type | Role |
|------|------|
| `TurtleCommand` | Abstract interface. Implements `createInstruction(TurtleState, Map) → List<Instruction>`. Represents a high-level turtle directive (e.g. `Forward`, `Right`). |
| `Instruction<T>` | Abstract interface. Implements `exec(PaintContext) → T`. Represents a low-level drawing operation. |
| `TurtleState` | Mutable state used **only during compilation**. Holds position, heading (degrees), pen status, color, stroke width, macros, and a stack for `SaveState`/`PopState`. |
| `PaintContext` | Immutable context passed to every `Instruction.exec` call. Contains `Canvas`, `Paint`, and the canvas center `Offset`. |
| `TurtleCompiler` | Static utility that runs the compilation phase. |
| `TurtlePainter` | `CustomPainter` subclass that executes instructions in `paint()`. |
| `TurtleView` | Stateful `Widget` that compiles and renders a list of commands without animation. |
| `AnimatedTurtleView` | Stateful `Widget` that renders commands with a built-in animation driven by an internal `AnimationController`. |
| `ControllableTurtleView` | Stateful `Widget` that renders commands up to a progress value driven by an external `AnimationController`. |
| `Macro` | Stores a named list of `TurtleCommand` objects for use with `SetMacro`/`RunMacro`. |

### Coordinate system

- The turtle starts at the **center** of the canvas (`Offset(0, 0)` in turtle space).
- The default heading is **-90 degrees** (pointing up / north).
- Positive x is right, positive y is down (Flutter canvas convention).
- All positions stored in `TurtleState.position` are **relative to the canvas center**. The `PaintContext.center` offset is added when actually drawing.

## DSL Command Conventions

### Implementing a new `TurtleCommand`

1. Create a new file in `lib/src/commands/` named after the command in `snake_case.dart`.
2. Define a class annotated with `@immutable` (from `package:meta/meta.dart`).
3. Implement the `TurtleCommand` interface.
4. Store any dynamic parameters as `Function(Map) → T` fields (the `Map` is the current argument map / macro argv).
5. In `createInstruction`, mutate `TurtleState` as needed and return the appropriate `Instruction` instances (or an empty list if no drawing occurs).
6. Export the new file from `lib/src/commands/commands.dart`.

**Example skeleton:**

```dart
import 'package:meta/meta.dart';

import '../turtle_commands.dart';
import '../turtle_state.dart';

@immutable
class MyCommand implements TurtleCommand {
  final double Function(Map) myParam;

  const MyCommand(this.myParam);

  @override
  List<Instruction> createInstruction(TurtleState turtle, Map argv) {
    final value = myParam(Map.of(argv));
    // Mutate turtle state and/or return instructions.
    return [];
  }
}
```

### Implementing a new `Instruction`

Add internal instruction classes to `lib/src/commands/_instructions.dart`. Mark them `@immutable` when all fields are final. They should only interact with the `PaintContext` (canvas + paint), never with `TurtleState`.

### Dynamic parameter pattern

All numeric/boolean/color parameters on commands use a `Function(Map) → T` signature so that they can read from the current macro argument map (argv). Always copy the map before passing it to the function:

```dart
final value = myParam(Map.of(argv));
```

### Control-flow commands

Commands that contain nested `List<TurtleCommand>` (e.g. `Repeat`, `IfElse`, `SetMacro`) compile their children by calling `createInstruction` recursively on each child command and collecting the resulting instructions.

The `repcount` key (string constant defined in `repeat.dart`) is injected into the argv map for each iteration of a `Repeat` loop (1-based).

## Available Commands

### Turtle Motion
- `PenDown` / `PenUp` – start/stop drawing lines
- `Forward(distance)` / `Back(distance)` – move forward/backward
- `Left(degrees)` / `Right(degrees)` – turn left/right
- `GoTo(x, y)` – move to an absolute position (relative to canvas center)
- `ResetPosition` – return to center
- `ResetHeading` – reset heading to default (-90°)
- `SetColor(color)` – set pen color
- `SetStrokeWidth(width)` – set pen stroke width
- `Label(text)` – draw a text label at current position
- `SetLabelHeight(height)` – set the font size for labels
- `SetOrientation(degrees)` – set heading to an absolute angle

### Flow Control
- `If(condition, commands)` – conditionally run commands
- `IfElse(condition, trueCommands, falseCommands)` – conditional branch
- `Repeat(times, commands)` – loop a fixed number of times
- `Stop` – stop execution immediately (throws `StopException` during compilation)

### State Management
- `SaveState` – push current position and heading onto the turtle stack
- `PopState` – pop and restore a previous position and heading

### Macros
- `SetMacro(name, commands)` – define a named macro
- `RunMacro(name, argv, {preserveState})` – invoke a macro with optional arguments; when `preserveState` is `true` (default), position, heading, color, and stroke width are restored after the macro runs

### Debug
- `Log(message)` – log a message to the console during compilation

## Code Style

- The project follows the [Dart style guide](https://dart.dev/guides/language/effective-dart/style) and uses `package:flutter_lints` via `analysis_options.yaml`.
- Use `@immutable` (from `package:meta`) on all `TurtleCommand` and `Instruction` classes whose fields are all `final`.
- Prefer `const` constructors for immutable command classes.
- Dynamic parameters are always `Function(Map) → T` to support macro argument passing.
- Internal helpers (instructions, exceptions) use a leading underscore in the filename (e.g. `_instructions.dart`, `_exceptions.dart`) to indicate they are not part of the public API.
- Public API classes have doc comments. Internal/private classes use doc comments where helpful.

## Bootstrap and Build

### Package setup

```bash
# In the package root
flutter pub get

# In the example app
cd example && flutter pub get
```

### Build the example app

```bash
# Debug APK (Android) — matches the android_ci.yaml workflow
cd example && flutter build apk --debug

# Web with WASM (requires Flutter 3.38.x or later and web support enabled)
cd example && flutter config --enable-web && flutter build web --wasm
```

## Testing

- Tests are located in `test/flutter_turtle_test.dart`.
- The project uses `flutter_test` (from the Flutter SDK) for testing.
- Run tests with `flutter test`.
- Run the linter with `flutter analyze`.

## Dependencies

| Package | Purpose |
|---------|---------|
| `flutter` (SDK) | UI framework |
| `meta` | `@immutable` annotation |
| `flutter_lints` (dev) | Lint rules |
| `flutter_test` (dev, SDK) | Testing framework |
