import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/api_call.dart';

//creating provider
final pokedexProvider = FutureProvider<dynamic>((ref) async {
  final apiServices = ref.watch(makeDioCallProvider);
  return apiServices.getPokemonData();
});

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestion = ref.watch(pokedexProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'P O K E D E X ',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          suggestion.when(data: (data) {
            final List pokemonList = data['pokemon'] as List;
            return Expanded(
              child: ListView.builder(
                itemCount: pokemonList.length,
                itemBuilder: (context, index) {
                  final pokemon = pokemonList[index];
                  return ListTile(
                    trailing: Text(pokemon['id'].toString()),
                    title: Text(pokemon['name']),
                  );
                },
              ),
            );
          }, error: (error, _) {
            return Center(
              child: Text(error.toString()),
            );
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          })
        ],
      ),
    );
  }
}
