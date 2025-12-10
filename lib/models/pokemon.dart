class Pokemon {
  final String name;
  final String url;

  Pokemon({required this.name, required this.url});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(name: json['name'], url: json['url']);
  }
}

class PokemonDetail {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final Map<String, int> stats;

  PokemonDetail({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.stats,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites'];
    final image =
        sprites['other']?['official-artwork']?['front_default'] ??
        sprites['front_default'] ??
        '';

    final types = (json['types'] as List)
        .map((t) => t['type']['name'].toString())
        .toList();

    final Map<String, int> stats = {};
    for (var s in json['stats']) {
      stats[s['stat']['name']] = s['base_stat'];
    }

    return PokemonDetail(
      id: json['id'],
      name: json['name'],
      imageUrl: image,
      types: types,
      stats: stats,
    );
  }
}
