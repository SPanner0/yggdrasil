import 'package:flutter/material.dart';
import 'package:yggdrasil/game.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Yggdrasil'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const GamePage()),
            );
          },
          child: const Text('Play'),
        ),
      ),
    );
  }
}
