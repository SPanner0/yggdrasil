import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'plants.dart';
import 'providers.dart';
import 'shop.dart';

/// The main game page
class GamePage extends ConsumerStatefulWidget {
  const GamePage({super.key});

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> with RestorationMixin {
  RestorableInt restorableCoins = RestorableInt(100);
  RestorableInt restorableDay = RestorableInt(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Yggdrasil")),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(children: [
            ElevatedButton(
                onPressed: () {
                  ref.watch(gameDataProvider).addCoins(10);
                },
                child: Text("Coins: ${ref.watch(gameDataProvider).coins}")),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    ref.watch(gameDataProvider).incrementDay();
                  });
                },
                child: Text("Day: ${ref.watch(gameDataProvider).day}")),
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.6,
              child: Image.asset("assets/images/window.jpg"),
            ),
            const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PottedPlant(1),
                  PottedPlant(2),
                  PottedPlant(3),
                ])
          ]);
        }));
  }

  @override
  String? get restorationId => 'GamePage';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(restorableCoins, 'coins');
    registerForRestoration(restorableDay, 'day');
  }
}

/// Combines a plant box and a pot to create a potted plant
class PottedPlant extends ConsumerStatefulWidget {
  final int id;
  const PottedPlant(this.id, {super.key});

  @override
  ConsumerState<PottedPlant> createState() => _PottedPlantState();
}

class _PottedPlantState extends ConsumerState<PottedPlant>
    with RestorationMixin {
  final RestorableEnum<PlantType> restorablePlantType =
      RestorableEnum(PlantType.none, values: PlantType.values);
  final RestorableInt restorablePlantStage = RestorableInt(0);
  final RestorableInt restorableWater = RestorableInt(0);
  final RestorableInt restorableSunshine = RestorableInt(0);
  final RestorableInt restorableDayCounter = RestorableInt(0);

  double _currentSunshineSlider = 5.0;

  @override
  Widget build(BuildContext context) {
    final PlantData plantData = ref.read(plantDataProvider(widget.id));

    return GestureDetector(
        onTap: () async {
          if (plantData.plantType != PlantType.none) {
            // We want the user to be able to grow their plant if it exists
            // TODO: Add popup menu for plant growth logic
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(child: GrowthPanel(id: widget.id));
                });
          } else {
            // and to buy a plant if it doesn't
            final PlantType purchasedPlant = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ShopPage(coins: ref.read(gameDataProvider).coins)));
            setState(() {
              ref.watch(gameDataProvider).subtractCoins(purchasedPlant.price!);
              plantData.setPlantType(purchasedPlant);
              plantData.setPlantStage(1);
            });
          }
        },
        child: SizedBox(
            // This part's a little fucked with the positioning
            // TODO: Make size dynamic depending on plant type
            width: 150,
            height: 200,
            child: Stack(children: [
              Positioned(
                  left: 20,
                  top: 50,
                  child: PlantBox(
                    plantType: plantData.plantType,
                    plantStage: plantData.plantStage,
                  )),
              Positioned(
                bottom: 10,
                child: Pot(plantData: plantData),
              ),
              Builder(builder: (BuildContext context) {
                ref.watch(gameDataProvider).day;

                return const SizedBox.shrink();
              }),
            ])));
  }

  @override
  String? get restorationId => 'PottedPlant';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(restorablePlantStage, 'stage');
    registerForRestoration(restorablePlantType, 'plantType');
    registerForRestoration(restorableWater, 'water');
    registerForRestoration(restorableSunshine, 'sunshine');
    registerForRestoration(restorableDayCounter, 'dayCounter');
  }
}

class GrowthPanel extends ConsumerStatefulWidget {
  final int id;
  const GrowthPanel({super.key, required this.id});

  @override
  ConsumerState<GrowthPanel> createState() => _GrowthPanelState();
}

class _GrowthPanelState extends ConsumerState<GrowthPanel> {
  double _currentSunshineSlider = 5.0;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      ElevatedButton(
          onPressed: () {
            ref.read(plantDataProvider(widget.id)).addWater(1);
            Navigator.pop(context);
          },
          child: const Text("Water")),
      Slider(
        value: _currentSunshineSlider,
        min: 0,
        max: 10,
        divisions: 10,
        label: _currentSunshineSlider.round().toString(),
        onChanged: (double value) {
          ref.watch(plantDataProvider(widget.id)).setSunshine(value.toInt());
        },
      ),
    ]);
  }
}

/// Contains a plant and all the logic needed to determine plant type, stage of grow, etc.
class PlantBox extends StatefulWidget {
  final PlantType plantType;
  final int plantStage;

  const PlantBox(
      {super.key, required this.plantType, required this.plantStage});

  @override
  State<PlantBox> createState() => _PlantBoxState();
}

class _PlantBoxState extends State<PlantBox> {
  @override
  Widget build(BuildContext context) {
    switch (widget.plantStage) {
      case -1:
        return Image.asset("assets/images/plants/dead.png");
      case 0:
        return const SizedBox.shrink();
      case 1:
        return Image.asset("assets/images/plants/sprout.png");
      default:
        return Image.asset(widget.plantType.imagePath!);
    }
  }
}

/// A simple pot image without much other logic
class Pot extends StatelessWidget {
  final PlantData plantData;
  const Pot({super.key, required this.plantData});

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/pot.png");
  }
}
