/// Represents all the plants that can be grown in the game.
enum PlantType {
  none,
  cactus,
  mushroom,
  sunflower,
  rose,
  bonsai,
}

extension PlantName on PlantType {
  /// Returns the name of the plant with the first letter capitalized.
  String get name {
    String nameString = toString().split('.').last;
    return "${nameString[0].toUpperCase()}${nameString.substring(1).toLowerCase()}";
  }
}

final Map<PlantType, String> _plantDescriptions = {
  PlantType.none: "No plant",
  PlantType.cactus:
      "A prickly plant found in the desert. It is known for its ability to store water and survive in extremely dry conditions. Be sure to not give it a hug!",
  PlantType.mushroom:
      "A fleshy, spore-bearing fruiting body of a fungus, typically produced above ground, on soil, or on its food source.",
  PlantType.sunflower:
      "A friendly-looking flower that is known for its ability to follow the sun. Having it in your house will surely boost your mood!",
  PlantType.rose:
      "A red rose is an unmistakable expression of love. Red roses convey deep emotions - be it love, longing or desire. Red Roses can also be used to convey respect, admiration or devotion.",
  PlantType.bonsai:
      "A small tree or shrub grown in a shallow pot. The goal of growing a Bonsai is to create a miniaturized but realistic representation of nature in the form of a tree.",
};

extension PlantDescription on PlantType {
  /// Returns the description of the plant.
  String? get description {
    return _plantDescriptions[this];
  }
}

final Map<PlantType, String> _plantImagePath = {
  PlantType.none: "assets/images/plants/none.png",
  PlantType.cactus: "assets/images/plants/cactus.png",
  PlantType.mushroom: "assets/images/plants/mushroom.png",
  PlantType.sunflower: "assets/images/plants/sunflower.png",
  PlantType.rose: "assets/images/plants/rose.png",
  PlantType.bonsai: "assets/images/plants/bonsai.png",
};

extension PlantImagePath on PlantType {
  /// Returns the file path of the plant image.
  String? get imagePath {
    return _plantImagePath[this];
  }
}

final Map<PlantType, int> _plantPrices = {
  PlantType.none: 0,
  PlantType.cactus: 10,
  PlantType.mushroom: 20,
  PlantType.sunflower: 30,
  PlantType.rose: 50,
  PlantType.bonsai: 100,
};

extension PlantPrice on PlantType {
  /// Returns the price of the plant.
  int? get price {
    return _plantPrices[this];
  }
}

extension PlantSellPrice on PlantType {
  /// Returns the price of the plant when sold.
  int get sellPrice {
    return (price! * 1.5).round();
  }
}

final Map<PlantType, int> _plantGrowthTime = {
  PlantType.none:
      0x8000000000000000, // None takes a very long time to grow to avoid unexpected behavior
  PlantType.cactus: 1,
  PlantType.mushroom: 2,
  PlantType.sunflower: 3,
  PlantType.rose: 5,
  PlantType.bonsai: 7,
};

extension PlantGrowthTime on PlantType {
  /// Returns the time it takes for the plant to grow.
  int? get growthTime {
    return _plantGrowthTime[this];
  }
}

final Map<PlantType, int> _plantWaterNeeded = {
  PlantType.none: 0,
  PlantType.cactus: 0,
  PlantType.mushroom: 2,
  PlantType.sunflower: 2,
  PlantType.rose: 3,
  PlantType.bonsai: 5,
};

extension PlantWaterNeeded on PlantType {
  /// Returns the amount of water the plant needs.
  int? get waterNeeded {
    return _plantWaterNeeded[this];
  }
}

final Map<PlantType, int> _plantSunshineNeeded = {
  PlantType.none: 0,
  PlantType.cactus: 5,
  PlantType.mushroom: 2,
  PlantType.sunflower: 7,
  PlantType.rose: 6,
  PlantType.bonsai: 4,
};

extension PlantSunshineNeeded on PlantType {
  /// Returns the amount of sunshine the plant needs.
  int? get sunshineNeeded {
    return _plantSunshineNeeded[this];
  }
}
