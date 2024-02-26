import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
    const GamePage({super.key});

    @override
        Widget build(BuildContext context) {
            return  Scaffold(
                    appBar: AppBar(
                        title: const Text("Yggdrasil")),
                        body: Column(
                            children: [
                                Container(height: 48.0,),
                                Container(
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                            Container(
                                                child: const Column(
                                                    children: [
                                                        Text("Plant 1"),
                                                        Text("0")
                                                    ]
                                                )
                                            ),
                                            Container(
                                                child: const Column(
                                                    children: [
                                                        Text("Plant 2"),
                                                        Text("0")
                                                    ]
                                                )
                                            )
                                        ]
                                    )
                                )
                            ]
                        ));
        }
}

class PlantBox extends StatefulWidget {
    const PlantBox({super.key});

    @override
        State<PlantBox> createState() => _PlantBoxState();
}

enum PlantType {
    cactus,
    orchid
}

class _PlantBoxState extends State<PlantBox> {
    final PlantType plantType = PlantType.cactus;

    @override
        Widget build(BuildContext context) {
            return Container(
                    child: Column(
                        children: [
                            Text(plantType.toString()),
                        ]
                    )
            );
        }
}
