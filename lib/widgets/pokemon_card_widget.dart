import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class PokemonCardWidget extends StatelessWidget {
  final PokemonDetail detail;

  const PokemonCardWidget({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFF176), // yellow border feel
            Color(0xFFBBDEFB), // light blue background
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.yellow.shade700, width: 8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header (Name + HP + Type)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                detail.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    "HP ${detail.stats['hp'] ?? ''}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.water_drop, color: Colors.blue.shade700),
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
            ),
          ),

          const SizedBox(height: 16),

          // Ability
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
