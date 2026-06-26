class MovieModel {
  final int id;
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
    return MovieModel(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['releaseDate'],
      rating: json['rating'],
      imageUrl: json['imageUrl'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'release_date': releaseDate,
      'rating': rating,
      'image_url': imageUrl,
      'is_favorite': isFavorite,
    };
  }

  MovieModel copyWith({
    int? id,
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
