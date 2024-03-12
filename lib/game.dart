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
          return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        ref.watch(gameDataProvider).addCoins(10);
                      });
                    },
                    child: Text("🪙 ${ref.watch(gameDataProvider).coins}")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        ref.watch(gameDataProvider).incrementDay();
                        ref.watch(plantDataProvider(1).notifier).nextDay();
                        ref.watch(plantDataProvider(2).notifier).nextDay();
                        ref.watch(plantDataProvider(3).notifier).nextDay();
                      });
                    },
                    child: Text("Day ${ref.watch(gameDataProvider).day}")),
                SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset("assets/images/window.jpg"),
                ),
                const Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                      Expanded(child: PottedPlant(1)),
                      Expanded(child: PottedPlant(2)),
                      Expanded(child: PottedPlant(3)),
                    ]))
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () async {
      if (ref.watch(plantDataProvider(widget.id).notifier).plantType !=
          PlantType.none) {
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
                        ShopPage(coins: ref.read(gameDataProvider).coins))) ??
            PlantType.none;
        setState(() {
          ref.watch(gameDataProvider).subtractCoins(purchasedPlant.price!);
          ref
              .watch(plantDataProvider(widget.id).notifier)
              .newPlant(purchasedPlant);
        });
      }
    }, child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
            // This part's a little fucked with the positioning
            // TODO: Make size dynamic depending on plant type
            width: constraints.maxHeight,
            height: constraints.maxWidth,
            child: Column(children: [
              PlantBox(id: widget.id),
              Pot(plantData: ref.watch(plantDataProvider(widget.id))),
            ]));
      },
    ));
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
  double _currentSunshineSlider = 0;

  @override
  Widget build(BuildContext context) {
    _currentSunshineSlider =
        ref.watch(plantDataProvider(widget.id).notifier).sunshine.toDouble();

    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close))
      ]),
      Card(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
            leading: const Icon(Icons.water_drop),
            title: const Text("Water your plant"),
            subtitle: Text(
                "Current water: ${ref.watch(plantDataProvider(widget.id).notifier).water}")),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    ref.read(plantDataProvider(widget.id).notifier).addWater(1);
                  });
                },
                child: const Text("Water")),
          ],
        ),
      ])),
      Card(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
            leading: const Icon(Icons.wb_sunny),
            title: const Text("Give your plant some sunshine"),
            subtitle: Text(
                "Current sunshine: ${ref.watch(plantDataProvider(widget.id).notifier).sunshine}")),
        Slider(
          value: _currentSunshineSlider,
          min: 0,
          max: 10,
          divisions: 10,
          label: _currentSunshineSlider.round().toString(),
          onChanged: (double value) {
            _currentSunshineSlider = value;
            setState(() {
              ref
                  .watch(plantDataProvider(widget.id).notifier)
                  .setSunshine(value.toInt());
            });
          },
        ),
      ])),
    ]);
  }
}

/// Contains a plant and all the logic needed to determine plant type, stage of grow, etc.
class PlantBox extends ConsumerStatefulWidget {
  final int id;
  const PlantBox({super.key, required this.id});

  @override
  ConsumerState<PlantBox> createState() => _PlantBoxState();
}

class _PlantBoxState extends ConsumerState<PlantBox> {
  @override
  Widget build(BuildContext context) {
    switch (ref.watch(plantDataProvider(widget.id).notifier).plantStage) {
      case -1:
        return Image.asset("assets/images/plants/dead.png");
      case 0:
        return const SizedBox.shrink();
      case 1:
        return Image.asset("assets/images/plants/sprout.png");
      default:
        return Image.asset(ref
            .watch(plantDataProvider(widget.id).notifier)
            .plantType
            .imagePath!);
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
