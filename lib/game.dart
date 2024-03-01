import 'package:flutter/material.dart';
import 'plants.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
    RestorableInt coins = RestorableInt(0);
    RestorableInt day = RestorableInt(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Yggdrasil")),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(children: [
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.6,
              child: Image.asset("assets/images/window.jpg"),
            ),
            Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/table.jpg"), fit: BoxFit.fill),
                    ),
                child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  Stack(children: [
                    PlantBox(),
                    Pot(),
                  ]),
                  Stack(children: [
                    PlantBox(),
                    Pot(),
                  ]),
                  Stack(children: [
                    PlantBox(),
                    Pot(),
                  ])
                ]))
          ]);
        }));
  }
}

class PlantBox extends StatefulWidget {
  const PlantBox({super.key});

  @override
  State<PlantBox> createState() => _PlantBoxState();
}

class _PlantBoxState extends State<PlantBox> {
  final PlantType plantType = PlantType.none;

  @override
  Widget build(BuildContext context) {
    return Image.asset(plantType.imagePath!);
  }
}

class Pot extends StatelessWidget {
  const Pot({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/pot.png");
  }
}
