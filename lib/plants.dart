enum PlantType {
  none,
  cactus,
  mushroom,
  sunflower,
}

final Map<PlantType, String> plantNames = {
  PlantType.none: "None",
  PlantType.cactus: "Cactus",
  PlantType.mushroom: "Mushroom",
  PlantType.sunflower: "Orchid",
};

extension PlantName on PlantType {
    String? get name {
        return plantNames[this];
    }
}

final Map<PlantType, String> plantDescriptions = {
  PlantType.none: "No plant",
  PlantType.cactus: "A cactus is a member of the plant family Cactaceae, a family comprising about 127 genera with some 1750 known species of the order Caryophyllales.",
  PlantType.mushroom: "A mushroom is the fleshy, spore-bearing fruiting body of a fungus, typically produced above ground, on soil, or on its food source.",
  PlantType.sunflower: "The Orchidaceae are a diverse and widespread family of flowering plants, with blooms that are often colourful and fragrant, commonly known as the orchid family.",
};

extension PlantDescription on PlantType {
    String? get description {
        return plantDescriptions[this];
    }
}

final Map<PlantType, String> plantImagePath = {
  PlantType.none: "assets/images/plants/none.png",
  PlantType.cactus: "assets/images/plants/cactus.png",
  PlantType.mushroom: "assets/images/plants/mushroom.png",
  PlantType.sunflower: "assets/images/plants/sunflower.png",
};

extension PlantImagePath on PlantType {
    String? get imagePath {
        return plantImagePath[this];
    }
}

final Map<PlantType, int> plantPrices = {
  PlantType.none: 0,
  PlantType.cactus: 10,
  PlantType.mushroom: 20,
  PlantType.sunflower: 30,
};

extension PlantPrice on PlantType {
    int? get price {
        return plantPrices[this];
    }
}
