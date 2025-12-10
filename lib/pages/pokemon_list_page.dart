import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../services/pokemon_service.dart';
import 'pokemon_detail_page.dart';
import 'settings_page.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  final PokemonService service = PokemonService();
  List<Pokemon> pokemons = [];
  List<Pokemon> filtered = [];
  bool loading = true;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadPokemon();
  }

  Future<void> loadPokemon() async {
    try {
      final data = await service.fetchPokemonList();
      setState(() {
        pokemons = data;
        filtered = data;
        loading = false;
      });
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void searchPokemon(String query) {
    setState(() {
      filtered = pokemons
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon API App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: searchPokemon,
                    decoration: const InputDecoration(
                      labelText: 'Search Pokémon',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final p = filtered[index];
                      return ListTile(
                        leading: const Icon(Icons.catching_pokemon),
                        title: Text(p.name.toUpperCase()),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PokemonDetailPage(name: p.name),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
