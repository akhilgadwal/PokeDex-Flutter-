import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomGridView extends ConsumerWidget {
  const CustomGridView(this.pokemonList, {super.key});
  final pokemonList;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10, // Spacing between columns
          mainAxisSpacing: 10, // Spacing between rows
        ),
        itemCount: pokemonList.length,
        itemBuilder: (context, index) {
          final pokemon = pokemonList[index];
          return Card(
            color: Colors.green,

            // You can use any widget instead of Card to display your content
            child: Stack(
              children: <Widget>[
                Positioned(child: Image.asset('name')),
                Text(pokemon['name']),
                Text(
                  pokemon['type'].toString(),
                ),
                Image.network(
                  pokemon['img'],
                ),
                // CachedNetworkImage(
                //   imageUrl: pokemon['img'],
                // )
              ],
            ),
          );
        },
      ),
    );
  }
}
