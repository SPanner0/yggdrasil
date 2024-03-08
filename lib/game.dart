import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'plants.dart';
import 'shop.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with RestorationMixin {
  RestorableInt restorableCoins = RestorableInt(100);
  RestorableInt restorableDay = RestorableInt(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Yggdrasil")),
        body: ChangeNotifierProvider(
            create: (context) => GameData(
                coins: restorableCoins.value, day: restorableDay.value),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Consumer<GameData>(
                  builder: (context, gameData, child) => Column(children: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                gameData.addCoins(10);
                              });
                            },
                            child: Text("Coins: ${gameData.coins}")),
                        SizedBox(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight * 0.6,
                          child: Image.asset("assets/images/window.jpg"),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              PottedPlant(gameData: gameData),
                              PottedPlant(gameData: gameData),
                              PottedPlant(gameData: gameData),
                            ])
                      ]));
            })));
  }

  @override
  String? get restorationId => 'GamePage';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(restorableCoins, 'coins');
    registerForRestoration(restorableDay, 'day');
  }
}

/// Contains game data, such as coins and day
class GameData extends ChangeNotifier {
  int _coins;
  int _day;

  GameData({required int coins, required int day})
      : _day = day,
        _coins = coins;

  int get coins => _coins;
  int get day => _day;

  void addCoins(int amount) {
    _coins += amount;
    notifyListeners();
  }

  void subtractCoins(int amount) {
    _coins -= amount;
    notifyListeners();
  }

  void incrementDay() {
    _day++;
    notifyListeners();
  }
}

/// Combines a plant box and a pot to create a potted plant
class PottedPlant extends StatefulWidget {
  final GameData gameData;
  const PottedPlant({super.key, required this.gameData});

  @override
  State<StatefulWidget> createState() => _PottedPlantState();
}

class _PottedPlantState extends State<PottedPlant> with RestorationMixin {
  final RestorableEnum<PlantType> restorablePlantType =
      RestorableEnum(PlantType.none, values: PlantType.values);
  final RestorableInt restorablePlantStage = RestorableInt(0);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => PlantData(
            plantType: restorablePlantType.value,
            plantStage: restorablePlantStage.value),
        child: Builder(builder: (BuildContext context) {
          return Consumer<PlantData>(builder: (context, plantData, child) {
            return GestureDetector(
                onTap: () async {
                  // TODO: Reroute to not shop if plant already exists
                  final PlantType purchasedPlant = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ShopPage(coins: widget.gameData.coins)));
                  setState(() {
                    widget.gameData.subtractCoins(purchasedPlant.price!);
                    plantData.setPlantType(purchasedPlant);
                    plantData.setPlantStage(2);
                  });
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
                      const Positioned(
                        bottom: 10,
                        child: Pot(),
                      ),
                    ])));
          });
        }));
  }

  @override
  String? get restorationId => 'PottedPlant';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(restorablePlantStage, 'stage');
    registerForRestoration(restorablePlantType, 'plantType');
  }
}

class PlantData extends ChangeNotifier {
  PlantType _plantType;
  int _plantStage;

  PlantData({required PlantType plantType, required int plantStage})
      : _plantStage = plantStage,
        _plantType = plantType;

  PlantType get plantType => _plantType;
  int get plantStage => _plantStage;

  void setPlantType(PlantType type) {
    _plantType = type;
    notifyListeners();
  }

  void setPlantStage(int stage) {
    _plantStage = stage;
    notifyListeners();
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
      case 0:
        return const SizedBox.shrink();
      case 1:
        return Image.asset("assets/images/plants/sprout.png");
      default:
        return Image.asset(widget.plantType.imagePath!);
    }
  }
}

class Pot extends StatelessWidget {
  const Pot({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/pot.png");
  }
}
