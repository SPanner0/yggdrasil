import 'package:riverpod/riverpod.dart';

import 'plants.dart';

final gameDataProvider = Provider<GameData>((ref) {
  return GameData(coins: 100, day: 0);
});

/// Contains game data, such as coins and day
class GameData {
  int _coins;
  int _day;

  GameData({required int coins, required int day})
      : _day = day,
        _coins = coins;

  int get coins => _coins;
  int get day => _day;

  void addCoins(int amount) {
    _coins += amount;
  }

  void subtractCoins(int amount) {
    _coins -= amount;
  }

  void incrementDay() {
    _day++;
  }
}
final plantDataProvider = Provider.family<PlantData, int>((ref, id) {
  return PlantData(
      id: id,
      plantType: PlantType.none,
      plantStage: 0,
      water: 0,
      sunshine: 0,
      dayCounter: 0);
});

/// Contains plant data such as type and stage of grow
class PlantData {
  final int _id;
  PlantType _plantType;
  int _plantStage;
  int _water;
  int _sunshine;
  int _dayCounter;

  PlantData({
    required int id,
    required PlantType plantType,
    required int plantStage,
    required int water,
    required int sunshine,
    required int dayCounter,
  })  : _id = id,
        _plantStage = plantStage,
        _plantType = plantType,
        _water = water,
        _sunshine = sunshine,
        _dayCounter = dayCounter;

  int get id => _id;
  PlantType get plantType => _plantType;
  int get plantStage => _plantStage;
  int get water => _water;
  int get sunshine => _sunshine;
  int get dayCounter => _dayCounter;

  void setPlantType(PlantType type) {
    _plantType = type;
  }

  void setPlantStage(int stage) {
    _plantStage = stage;
  }

  void addWater(int amount) {
    _water += amount;
  }

  void setSunshine(int amount) {
    _sunshine = amount;
  }

  void nextDay() {
    _dayCounter++;
    if ((plantType != PlantType.none && plantStage != -1) || (plantStage > 1)) {
      if (plantType.waterNeeded! != water) {
        killPlant();
      }
      if (plantType.sunshineNeeded! > sunshine + 10 ||
          plantType.sunshineNeeded! < sunshine - 10) {
        killPlant();
      }
      if (plantType.growthTime! == dayCounter) {
        setPlantStage(plantStage + 1);
      }
    }
  }

  void killPlant() {
    _plantType = PlantType.none;
    _plantStage = -1;
    _water = 0;
    _sunshine = 0;
    _dayCounter = -1;
  }

  int sellPlant() {
    final int price = _plantType.price!;
    _plantType = PlantType.none;
    _plantStage = 0;
    _water = 0;
    _sunshine = 0;
    _dayCounter = 0;
    return price;
  }
}
