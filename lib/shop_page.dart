import 'package:flutter/material.dart';
import 'plants.dart';

/// The shop page
///
/// This is where the user can buy new plants
class ShopPage extends StatelessWidget {
  final int coins;
  const ShopPage({super.key, required this.coins});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shop")),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        List<Widget> shopItems = [];
        for (var plant in PlantType.values) {
          if (plant == PlantType.none) {
            continue;
          }
          shopItems.add(ShopItem(plantType: plant, coins: coins));
        }
        return Column(children: [
          ElevatedButton(onPressed: () => {}, child: Text("🪙 $coins")),
          Expanded(
              child: GridView.count(
            crossAxisCount: 2,
            children: shopItems,
          ))
        ]);
      }),
    );
  }
}

/// A single item in the shop
class ShopItem extends StatelessWidget {
  final int coins;
  final PlantType plantType;

  const ShopItem({super.key, required this.plantType, required this.coins});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (coins >= plantType.price!) {
          Navigator.pop(context, plantType);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("You don't have enough coins to buy this plant!")));
        }
      },
      child: Column(
        children: [
          Image.asset(plantType.imagePath!),
          Text(plantType.name),
          Text("Price: ${plantType.price!}"),
        ],
      ),
    );
  }
}
