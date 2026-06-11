import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String overview;
  final String releaseDate;
  final String rating;
  final String imageUrl;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const MovieCard({
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
    return Card(
      color: Colors.white,
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 140,
                    color: Colors.grey[300],
                    child: const Icon(Icons.movie, color: Colors.grey),
                  );
                },
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    overview,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    releaseDate,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            GestureDetector(
              onTap: () {
                if (onFavoriteToggle != null) {
                  onFavoriteToggle!();
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isFavorite
                          ? 'Removed from favorites'
                          : 'Added to favorites',
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 32,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
