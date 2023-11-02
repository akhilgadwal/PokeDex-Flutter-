import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/provider/provider.dart';
import 'package:pokedex/view/detail_scree.dart';

class CustomGridView extends ConsumerWidget {
  const CustomGridView(this.pokemonList, {Key? key}) : super(key: key);
  final List<Map<String, dynamic>> pokemonList;

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
          final type = pokemonList[index]['type'];
          bool isFavorite = ref
              .watch(favoritePokemonProvider)
              .any((element) => element.containsKey(pokemon));
          print(isFavorite);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(pokemonDetails: pokemon),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: type[0] == "Grass"
                    ? Colors.greenAccent
                    : type[0] == "Fire"
                        ? Colors.redAccent
                        : type[0] == "Water"
                            ? Colors.blue
                            : type[0] == "Poison"
                                ? Colors.deepPurpleAccent
                                : type[0] == "Electric"
                                    ? Colors.amber
                                    : type[0] == "Rock"
                                        ? Colors.grey
                                        : type[0] == "Ground"
                                            ? Colors.brown
                                            : type[0] == "Psychic"
                                                ? Colors.indigo
                                                : type[0] == "Fighting"
                                                    ? Colors.orange
                                                    : type[0] == "Bug"
                                                        ? Colors
                                                            .lightGreenAccent
                                                        : type[0] == "Ghost"
                                                            ? Colors.deepPurple
                                                            : type[0] ==
                                                                    "Normal"
                                                                ? Colors.black26
                                                                : Colors.pink,
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
              ),

              // You can use any widget instead of Card to display your content
              child: Stack(
                children: <Widget>[
                  // Positioned(child: Image.asset('name')),
                  Positioned(
                    bottom: -10,
                    child: IconButton(
                      onPressed: () {
                        if (isFavorite) {
                          ref
                              .read(favoritePokemonProvider.notifier)
                              .removeFromFavorites(pokemon);
                        } else {
                          ref
                              .read(favoritePokemonProvider.notifier)
                              .addToFavorites(pokemon);
                        }
                      },
                      icon: isFavorite
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border,
                            ),
                    ),
                  ),
                  Text(
                    pokemon['name'],
                  ),
                  Image.network(
                    pokemon['img'],
                  ),
                  // CachedNetworkImage(
                  //   imageUrl: pokemon['img'],
                  // )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
