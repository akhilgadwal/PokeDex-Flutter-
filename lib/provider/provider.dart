import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

final favoritePokemonProvider =
    StateNotifierProvider<FavoritePokemonNotifier, List<Map<String, dynamic>>>(
        (ref) {
  return FavoritePokemonNotifier();
});

class FavoritePokemonNotifier
    extends StateNotifier<List<Map<String, dynamic>>> {
  FavoritePokemonNotifier() : super([]) {
    final localData = box.read('favoritePokemons');

    state = List<Map<String, dynamic>>.from(localData);
  }

  void addToFavorites(Map<String, dynamic> pokemon) {
    state = [...state, pokemon];
    saveFavorites();
  }

  void removeFromFavorites(Map<String, dynamic> pokemon) {
    state = List.from(state)..remove(pokemon);
    saveFavorites();
    // removeFromStorage(pokemon);
  }

  // Save the favorite Pokemon list to GetStorage
  void saveFavorites() {
    box.write('favoritePokemons', state);
    box.save();
  }

  // Remove the specific Pokemon from GetStorage
  void removeFromStorage(Map<String, dynamic> pokemon) {
    List<Map<String, dynamic>> savedFavorites = box.read('favoritePokemons');
    if (savedFavorites != null) {
      savedFavorites.remove(pokemon);
      box.write('favoritePokemons', savedFavorites);
    }
  }
}

//instance of storage
//getStorage
final box = GetStorage();

//write the data
