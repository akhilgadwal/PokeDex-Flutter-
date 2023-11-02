import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/provider/provider.dart';
import 'package:pokedex/view/fav.dart';
import 'package:pokedex/widget/pokemon_grid.dart';

import '../services/api_call.dart';

//creating provider
final pokedexProvider = FutureProvider<dynamic>((ref) async {
  final apiServices = ref.watch(makeDioCallProvider);
  return await apiServices.getPokemonData();
});

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestion = ref.watch(pokedexProvider);
    final favs = ref.watch(favoritePokemonProvider);
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
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const FavPage()));
                },
                icon: const Icon(Icons.favorite),
              ),
              Container(
                height: 14.0,
                width: 14.0,
                margin: const EdgeInsets.only(
                  top: 7.0,
                  left: 7.0,
                ),
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.redAccent.withOpacity(0.5),
                ),
                child: FittedBox(
                  child: Text(
                    favs.length.toString(),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          suggestion.when(data: (data) {
            final List<Map<String, dynamic>> pokemonList =
                List<Map<String, dynamic>>.from(data['pokemon']);
            // return Container();
            return CustomGridView(pokemonList);
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
