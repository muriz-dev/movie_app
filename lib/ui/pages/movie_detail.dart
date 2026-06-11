import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  final String title;
  final String overview;
  final String releaseDate;
  final String rating;
  final String imageUrl;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const MovieDetail({
    super.key,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.rating,
    required this.imageUrl,
    required this.isFavorite,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    width: 200,
                    height: 300,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 200,
                        height: 300,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.movie,
                          color: Colors.grey,
                          size: 50,
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Release Date: $releaseDate',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Rating: $rating',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 16),

              Text(overview, style: const TextStyle(fontSize: 14)),

              const SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () {
                    if (onFavoriteToggle != null) {
                      onFavoriteToggle!();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isFavorite
                                ? 'Removed from Favorites'
                                : 'Added to Favorites',
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Add to Favorites'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
