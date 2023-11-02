import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/provider/provider.dart';
// Make sure to import your provider file

class FavPage extends ConsumerWidget {
  const FavPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favs = ref.watch(favoritePokemonProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Pokemon'),
      ),
      body: ListView(
        children: favs
            .map((e) => ListTile(
                  leading: Image.network(
                    e['img'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(e['name']),
                ))
            .toList(),
      ),
    );
  }
}
