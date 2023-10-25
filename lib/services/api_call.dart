import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



//lets create a provider
final makeDioCallProvider = Provider<ApiService>((ref) => ApiService());

class ApiService {
  final Dio _dio = Dio();
  final String baseUrl =
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';

  Future<dynamic> getPokemonData() async {
    try {
      Response response = await _dio.get(baseUrl);
      if (response.statusCode == 200) {
     return jsonDecode(response.data);
        // Handle the retrieved data as needed
       
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
