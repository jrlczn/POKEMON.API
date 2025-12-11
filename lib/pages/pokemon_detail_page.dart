import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../services/pokemon_service.dart';
import '../widgets/pokemon_card_widget.dart';

class PokemonDetailPage extends StatefulWidget {
  final String name;

  const PokemonDetailPage({super.key, required this.name});

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  final PokemonService service = PokemonService();
  PokemonDetail? detail;
  bool loading = true;
  String aiText = "";

  @override
  void initState() {
    super.initState();
    loadDetail();
  }

  Future<void> loadDetail() async {
    try {
      final data = await service.fetchPokemonDetail(widget.name);
      setState(() {
        detail = data;
        loading = false;
      });
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  String generateFakeAI() {
    if (detail == null) return "";
    return "${detail!.name.toUpperCase()} is a powerful Pokémon with types ${detail!.types.join(", ")}. It is known for its unique abilities and strong battle style.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name.toUpperCase())),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : detail == null
          ? const Center(child: Text("No data"))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  PokemonCardWidget(detail: detail!),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        aiText = generateFakeAI();
                      });
                    },
                    child: const Text("Generate AI Description"),
                  ),

                  const SizedBox(height: 10),
                  Text(aiText),
                ],
              ),
            ),
    );
  }
}
