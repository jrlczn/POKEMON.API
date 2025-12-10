import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonService {
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<Pokemon>> fetchPokemonList() async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon?limit=150'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List list = data['results'];
      return list.map((e) => Pokemon.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Pokémon list');
    }
  }

  Future<PokemonDetail> fetchPokemonDetail(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon/$name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PokemonDetail.fromJson(data);
    } else {
      throw Exception('Failed to load Pokémon detail');
    }
  }
}
