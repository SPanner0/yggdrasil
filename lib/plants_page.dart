import 'package:flutter/material.dart';

import 'plants.dart';

class PlantsPage extends StatelessWidget {
  const PlantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final plantCards = PlantType.values
        .where((plantType) => plantType != PlantType.none)
        .map((plantType) => PlantCard(plantType: plantType))
        .toList();

    return Scaffold(
        appBar: AppBar(title: const Text("Plants")),
        body: ListView(children: plantCards));
  }
}

class PlantCard extends StatelessWidget {
  final PlantType plantType;

  const PlantCard({super.key, required this.plantType});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).colorScheme.onPrimary,
        child: Column(children: [
          ListTile(
            leading: Image.asset(plantType.imagePath!),
            title: Text(plantType.name),
            subtitle: Text("🪙 ${plantType.price}\n💧 ${plantType.waterNeeded} ☀️ ${plantType.sunshineNeeded} 🕗 ${plantType.growthTime}"),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "${plantType.description}",
            ),
          )
        ]));
  }
}
