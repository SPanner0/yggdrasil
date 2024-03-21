import 'package:flutter/material.dart';
import 'package:yggdrasil/game_page.dart';
import 'package:yggdrasil/plants_page.dart';

/// The home page of the app
///
/// This is the first page that the user sees when they open the app.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Yggdrasil'),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const GamePage()),
                );
              },
              child: const Text('Play'),
            ),
          )),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const PlantsPage()),
                  );
                },
                child: const Text('Plants'),
              ),
            ),
          )
        ]));
  }
}
