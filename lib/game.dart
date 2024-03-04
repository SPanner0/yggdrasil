import 'package:flutter/material.dart';
import 'plants.dart';
import 'shop.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with RestorationMixin {
  RestorableInt coins = RestorableInt(100);
  RestorableInt day = RestorableInt(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Yggdrasil")),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(children: [
            CoinsBar(coins: coins),
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.6,
              child: Image.asset("assets/images/window.jpg"),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              PottedPlant(coins: coins),
              PottedPlant(coins: coins),
              PottedPlant(coins: coins),
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

class CoinsBar extends StatefulWidget {
  final RestorableInt coins;
  const CoinsBar({super.key, required this.coins});


  @override
  State<StatefulWidget> createState() => _CoinsBarState();
}

class _CoinsBarState  extends State<CoinsBar>{
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => {
            setState(() {
              widget.coins.value += 10;
            })
        }, child: Text("Coins: ${widget.coins.value}"));
  }
}

/// Combines a plant box and a pot to create a potted plant
class PottedPlant extends StatefulWidget {
  final RestorableInt coins;
  const PottedPlant({super.key, required this.coins});

  @override
  State<StatefulWidget> createState() => _PottedPlantState();
}

class _PottedPlantState extends State<PottedPlant> {
  PlantBox plantBox = const PlantBox();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          // TODO: Reroute to not shop if plant already exists
          final PlantType purchasedPlant = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ShopPage(coins: widget.coins)));

          setState(() {widget.coins.value -= purchasedPlant.price!;});
        },
        child: SizedBox(
            // This part's a little fucked with the positioning
            // TODO: Make size dynamic depending on plant type
            width: 150,
            height: 200,
            child: Stack(children: [
              Positioned(left: 20, top: 50, child: plantBox),
              const Positioned(
                bottom: 10,
                child: Pot(),
              ),
            ])));
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
      RestorableEnum(PlantType.none, values: PlantType.values);
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
