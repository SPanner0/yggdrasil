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

final plantDataProvider =
    StateNotifierProvider.family<PlantDataNotifier, PlantData, int>((ref, id) {
  return PlantDataNotifier(PlantData(
      id: id,
      plantType: PlantType.none,
      plantStage: 0,
      water: 0,
      sunshine: 0,
      dayCounter: 0));
});

class PlantDataNotifier extends StateNotifier<PlantData> {
  PlantDataNotifier(super.state);

  int get id => state.id;
  PlantType get plantType => state.plantType;
  int get plantStage => state.plantStage;
  int get water => state.water;
  int get sunshine => state.sunshine;
  int get dayCounter => state.dayCounter;

  void setPlantType(PlantType type) {
    PlantData newState = state.clone();
    newState.setPlantType(type);
    state = newState;
  }

  void setPlantStage(int stage) {
    PlantData newState = state.clone();
    newState.setPlantStage(stage);
    state = newState;
  }

  void addWater(int amount) {
    PlantData newState = state.clone();
    newState.addWater(amount);
    state = newState;
  }

  void resetWater() {
    PlantData newState = state.clone();
    newState.resetWater();
    state = newState;
  }

  void setSunshine(int amount) {
    PlantData newState = state.clone();
    newState.setSunshine(amount);
    state = newState;
  }

  void nextDay() {
    PlantData newState = state.clone();
    newState.nextDay();
    state = newState;
  }

  void newPlant(PlantType type) {
    PlantData newState = state.clone();
    newState.newPlant(type);
    state = newState;
  }

  void killPlant() {
    PlantData newState = state.clone();
    newState.killPlant();
    state = newState;
  }

  int sellPlant() {
    PlantData newState = state.clone();
    int sellPrice = newState.sellPlant();
    state = newState;
    return sellPrice;
  }
}

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

  void resetWater() {
    _water = 0;
  }

  void setSunshine(int amount) {
    _sunshine = amount;
  }

  void nextDay() {
    _dayCounter++;
    if ((plantType != PlantType.none && plantStage != -1) || (plantStage < 2)) {
      if (plantType.waterNeeded! != water) {
        killPlant();
      } else if (plantType.sunshineNeeded! > sunshine + 2 ||
          plantType.sunshineNeeded! < sunshine - 2) {
        killPlant();
      } else if (dayCounter >= plantType.growthTime!) {
        setPlantStage(plantStage + 1);
      }
      resetWater();
    }
  }

  void newPlant(PlantType type) {
    if (type == PlantType.none) {
      _plantStage = 0;
    } else {
      _plantStage = 1;
    }
    _plantType = type;
    _water = 0;
    _sunshine = 0;
    _dayCounter = 0;
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

  PlantData clone() {
    return PlantData(
        id: _id,
        plantType: _plantType,
        plantStage: _plantStage,
        water: _water,
        sunshine: _sunshine,
        dayCounter: _dayCounter);
  }
}
