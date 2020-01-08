# flutter_turtle

flutter_turtle is a simple implementation of turtle graphics for Flutter. It
simply uses a custom painter to draw graphics by a series of Logo-like commands.

For further information about turtle graphics, please visit Wikipedia:

- https://en.wikipedia.org/wiki/Turtle_graphics
- https://en.wikipedia.org/wiki/Logo_(programming_language)

## Why I make this?

It is always fun to make your own [DSL](https://en.wikipedia.org/wiki/Domain-specific_language)!

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

In other words, flutter_turtle built a DSL over Dart and Flutter.

If you have code in Logo like this:

``` logo
repeat 5 [ fd 100 rt 144 ]
```

It would be like the following code in Flutter Turtle DSL:

``` dart
[
  Repeat((_) => 5, [
    Forward((_) => 200),
    Right((_) => 144),
  ]),
];
```

### Flow control

There are some commands help you to do flow controls. You can use the `IfElse`
class like using 'if..else..' in Dart, and you can use `Repeat` for loops.

An example of `IfElse`:

``` dart
// If it is true, go forward for 10 pixels, otherwise go back for 10 pixels.
IfElse((_)=>true, [Forward((_)=>10.0)], [Back(()=>10.0)]),
```

An example of `Repeat`:

``` dart
// Repeat 10 times.
Repeat((_)=>10, [Forward((_)=>10.0)]),
```

### Macros

Flutter Turtle DSL does not have somehow REAL functions, but somehow you can use
macros instead. You can use the `SetMacro` to add macros to your turtle:

``` dart
SetMacro('macro', [Forward((_)=>10.0)]), // A new macro named "macro".
```

Then you can use `RunMacro` to run the macro:

``` dart
RunMacro('macro', (_)=>{'arg1': 'value1', 'arg2': 'value2'}),
```

You can pass arguments while calling a macro. These arguments would be a map
sent to each Flutter Turtle command. For example:

``` dart
SetMacro('macro', [Forward((_)=>_['arg1'])]), // A new macro named "macro".
RunMacro('macro', (_)=>{'arg1': 10.0}),
```

## Commands

Currently supported commands are including:

### Turtle motion

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

### Flow control

- IfElse
- Repeat

### Macros

- SetMacro
- RunMacro

### Misc

- Exec
