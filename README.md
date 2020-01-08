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

flutter_turtle provides a class, `TurtleView`, which is your canvas and accepts
a list of commands to draw your graphics. Just create an instance of
`TurtleView`, pass the commands in the `commands` parameter, and insert it to
your widget tree.

## Flutter Turtle DSL

flutter_turtle a set of Dart classes to represents commands to control your
turtle. Using them is quite alike to calling functions when you are doing turtle
graphics in Logo language, however, you are still coding in Dart and actually
composing a list of Dart objects, and then `TurtleView` runs them one by
another.

There are some commands help you to do flow controls. You can use the `IfElse`
class like using 'if..else..' in Dart, and you can use `Repeat` for loops.

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
