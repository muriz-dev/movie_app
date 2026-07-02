class MovieModel {
  final String id;
  final String title;
  final String overview;
  final String releaseDate;
  final String rating;
  final String imageUrl;
  final bool isFavorite;

  MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.rating,
    required this.imageUrl,
    this.isFavorite = false,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    // Map API fields if present, otherwise fallback to existing keys for backward compatibility / local mock data
    return MovieModel(
      id: json['#IMDB_ID'] ?? json['id']?.toString() ?? '',
      title: json['#TITLE'] ?? json['title'] ?? 'Unknown Title',
      overview: json['#ACTORS'] ?? json['overview'] ?? 'No actors provided',
      releaseDate: json['#YEAR']?.toString() ?? json['releaseDate'] ?? 'Unknown Year',
      rating: json['#RANK'] != null ? 'Rank: ${json['#RANK']}' : json['rating'] ?? 'N/A',
      imageUrl: json['#IMG_POSTER'] ?? json['imageUrl'] ?? '',
      isFavorite: json['isFavorite'] ?? json['is_favorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'releaseDate': releaseDate,
      'rating': rating,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
    };
  }

  MovieModel copyWith({
    String? id,
    String? title,
    String? overview,
    String? releaseDate,
    String? rating,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return MovieModel(
      id: id ?? this.id,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      releaseDate: releaseDate ?? this.releaseDate,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
