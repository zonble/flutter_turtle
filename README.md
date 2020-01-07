# flutter_turtle

flutter_turtle is a simple implementation of turtle graphics for Flutter. It
simply uses a custom painter to draw graphics by a series of Logo-like commands.

For further information about turtle graphics, please visit Wikipedia:

- https://en.wikipedia.org/wiki/Turtle_graphics
- https://en.wikipedia.org/wiki/Logo_(programming_language)

## Why I Make This?

It is always fun to make your own DSL!

## Example

![screenshot.png](https://raw.githubusercontent.com/zonble/flutter_turtle/master/screenshot.png)

A quick example:

```dart
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: TurtleView(
        child: Container(),
        commands: [
          PenDown(),
          SetColor((_) => Color(0xffff9933)),
          SetStrokeWidth((_) => 2),
          Repeat((_) => 20, [
            Repeat((_) => 180, [
              Forward((_) => 25.0),
              Right((_) => 20),
            ]),
            Right((_) => 18),
          ]),
          PenUp(),
        ],
      ),
    );
  }
```

## Commands

Currently supported commands are including:

### Turtle Motion

- PenDown
- PenUp
- Left
- Right
- Forward
- Back
- SetColor
- SetStrokeWidth
- GoTo
- ResetPosition
- ResetHeading

### Flow Control

- IfElse
- Repeat

### Macros

- SetMacro
- RunMacro

### Misc

- Exec
