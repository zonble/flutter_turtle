import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class Rule {
  final String a;
  final String b;

  const Rule(this.a, this.b);
}

class LSystem {
  List<Rule> ruleSet;
  List<TurtleCommand> turtleCommands = [];
  String axiom;

  LSystem(
    this.axiom,
    this.ruleSet,
  ) {
    turtleCommands.add(
      PenDown(),
    );
    turtleCommands.add(
      SetColor(
        (_) => Colors.lightGreen,
      ),
    );
    turtleCommands.add(
      SetStrokeWidth(
        (_) => 2,
      ),
    );
  }

  void resetTurtle() {
    turtleCommands.clear();
    turtleCommands.add(
      PenDown(),
    );
    turtleCommands.add(
      SetColor(
        (_) => Colors.green,
      ),
    );
    turtleCommands.add(
      SetStrokeWidth(
        (_) => 2,
      ),
    );
  }

  void generate(int iterations) {
    var sentence = axiom;
    while (iterations != 0) {
      StringBuffer nextGeneration = StringBuffer();

      for (int i = 0; i < sentence.length; i++) {
        String current = sentence[i];
        String replace = current;
        for (int j = 0; j < ruleSet.length; j++) {
          String a = ruleSet.elementAt(j).a;
          if (a == current) {
            replace = ruleSet.elementAt(j).b;
            break;
          }
        }
        nextGeneration.write(replace);
      }
      sentence = nextGeneration.toString();
      iterations--;
    }
    parseFractalPlant(sentence);
  }

  void parseFractalPlant(String sentence) {
    for (int i = 0; i < sentence.length; i++) {
      String character = sentence[i];
      if (character == 'F') turtleCommands.add(Forward((_) => 1));
      if (character == '-') turtleCommands.add(Left((_) => 35.0));
      if (character == '+') turtleCommands.add(Right((_) => 25.0));
      if (character == '[') turtleCommands.add(SaveState());
      if (character == ']') turtleCommands.add(PopState());
    }
  }
}

class LSystemPage extends StatefulWidget {
  const LSystemPage({super.key});

  @override
  LSystemPageState createState() => LSystemPageState();
}

class LSystemPageState extends State<LSystemPage> {
  LSystem fractalPlant = LSystem(
    'X',
    const [
      Rule(
        'X',
        'F+[[X]-X]-F[-FX]+X',
      ),
      Rule(
        'F',
        'FF',
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    fractalPlant.generate(8);
    return Scaffold(
      appBar: AppBar(title: const Text('Logo'), actions: <Widget>[
        TextButton(
          onPressed: () => setState(() {}),
          child: const Text('Run', style: TextStyle(color: Colors.white)),
        )
      ]),
      body: Column(
        children: [
          const SizedBox(
            height: 500,
          ),
          Expanded(
            child: AnimatedTurtleView(
              animationDuration: const Duration(seconds: 5),
              commands: fractalPlant.turtleCommands,
              child: const SizedBox(
                width: double.infinity,
                height: 600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
