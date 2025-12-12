// lib/widgets/pokemon_card_widget.dart
import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../widgets/type_badge.dart';
import '../data/favorites.dart' as favs;

class PokemonCardWidget extends StatelessWidget {
  final PokemonDetail detail;
  final VoidCallback? onToggleFavorite;
  final bool showFavorite;

  const PokemonCardWidget({
    super.key,
    required this.detail,
    this.onToggleFavorite,
    this.showFavorite = true,
  });

  @override
  Widget build(BuildContext context) {
    final isFav = favs.favoritePokemon.contains(detail.name);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.yellow.shade100, Colors.blue.shade50],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.yellow.shade700, width: 6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header (Name + HP + Type + Favorite)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detail.name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: detail.types
                          .map((t) => TypeBadge(type: t, fontSize: 11))
                          .toList(),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    "HP ${detail.stats['hp'] ?? '-'}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  if (showFavorite)
                    IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.yellow[700] : Colors.grey,
                        size: 28,
                      ),
                      onPressed: onToggleFavorite,
                    ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Image
          Center(
            child: Image.network(
              detail.imageUrl,
              height: 180,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),

          const SizedBox(height: 16),

          // Ability (static example kept)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      "Ability",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text("• Water Shuriken"),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  "${detail.name} uses its ninja skills to strike opponents from afar.",
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Stats section
          const Text(
            "Stats",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          ...detail.stats.entries.map(
            (e) => Text(
              "${e.key.toUpperCase()}: ${e.value}",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
