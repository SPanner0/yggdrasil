import 'package:flutter/material.dart';
import 'plants.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with RestorationMixin {
  RestorableInt coins = RestorableInt(0);
  RestorableInt day = RestorableInt(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Yggdrasil")),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    coins.value += 1;
                  });
                },
                child: Text("Coins: ${coins.value}")),
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.6,
              child: Image.asset("assets/images/window.jpg"),
            ),
            const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PottedPlant(),
                  PottedPlant(),
                  PottedPlant(),
                ])
          ]);
        }));
  }

  @override
  String? get restorationId => 'GamePage';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(coins, 'coins');
    registerForRestoration(day, 'day');
  }
}

/// Combines a plant box and a pot to create a potted plant
class PottedPlant extends StatelessWidget {
  const PottedPlant({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        // This part's a little fucked with the positioning
        // TODO: Make size dynamic depending on plant type
        width: 150,
        height: 200,
        child: Stack(children: [
          Positioned(left: 20, top: 50, child: PlantBox()),
          Positioned(
            bottom: 10,
            child: Pot(),
          ),
        ]));
  }
}

/// Contains a plant and all the logic needed to determine plant type, stage of grow, etc.
class PlantBox extends StatefulWidget {
  const PlantBox({super.key});

  @override
  State<PlantBox> createState() => _PlantBoxState();
}

class _PlantBoxState extends State<PlantBox> with RestorationMixin {
  RestorableEnum<PlantType> restorablePlantType =
      RestorableEnum(PlantType.sunflower, values: PlantType.values);
  RestorableInt restorablePlantStage = RestorableInt(2);

  @override
  Widget build(BuildContext context) {
    switch (restorablePlantStage.value) {
      case 0:
        return const SizedBox.shrink();
      case 1:
        return Image.asset("assets/images/plants/sprout.png");
      default:
        return Image.asset(restorablePlantType.value.imagePath!);
    }
  }

  @override
  String? get restorationId => 'PlantBox';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(restorablePlantStage, 'stage');
    registerForRestoration(restorablePlantType, 'plantType');
  }
}

class Pot extends StatelessWidget {
  const Pot({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/pot.png");
  }
}
