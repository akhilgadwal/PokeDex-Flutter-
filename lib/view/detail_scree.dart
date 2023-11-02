import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailScreen extends ConsumerWidget {
  final Map<String, dynamic> pokemonDetails;

  const DetailScreen({required this.pokemonDetails, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemonDetails['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              pokemonDetails['img'],
              height: 200,
              width: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Text('Weaknesses: ${pokemonDetails['weaknesses']}'),
            const SizedBox(height: 10),
            Text('Eggs: ${pokemonDetails['eggs']}'),
            const SizedBox(height: 10),
            Text('Spawn Type: ${pokemonDetails['spawn_type']}'),
            // Add other attributes as needed
          ],
        ),
      ),
    );
  }
}
