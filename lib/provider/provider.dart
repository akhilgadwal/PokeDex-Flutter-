import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritePokemonProvider = StateNotifierProvider<FavoritePokemonNotifier, List<Map<String, dynamic>>>((ref) {
  return FavoritePokemonNotifier();
});

class FavoritePokemonNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  FavoritePokemonNotifier() : super([]);

  void addToFavorites(Map<String, dynamic> pokemon) {
    print('added to fav');
    state = [...state, pokemon];
  }

  void removeFromFavorites(Map<String, dynamic> pokemon) {
    print('remove to fav');
    state = List.from(state)..remove(pokemon);
  }
}