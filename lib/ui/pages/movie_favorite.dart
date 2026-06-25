import 'package:flutter/material.dart';
import '../widgets/movie_card.dart';
import 'movie_detail.dart';
import 'movie_list.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  void toggleFavorite(int index) {
    setState(() {
      MovieList.movieList[index]['isFavorite'] =
          !(MovieList.movieList[index]['isFavorite'] as bool? ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: MovieList.movieList.length,
        itemBuilder: (context, index) {
          final movie = MovieList.movieList[index];

          if (movie['isFavorite']) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetail(
                      title: movie['title'].toString(),
                      overview: movie['overview'].toString(),
                      releaseDate: movie['releaseDate'].toString(),
                      rating: movie['rating'].toString(),
                      imageUrl: movie['imageUrl'].toString(),
                      isFavorite: movie['isFavorite'] as bool? ?? false,
                      onFavoriteToggle: () => toggleFavorite(index),
                    ),
                  ),
                );
              },
              child: MovieCard(
                title: movie['title'].toString(),
                overview: movie['overview'].toString(),
                releaseDate: movie['releaseDate'].toString(),
                rating: movie['rating'].toString(),
                imageUrl: movie['imageUrl'].toString(),
                isFavorite: movie['isFavorite'] as bool? ?? false,
                onFavoriteToggle: () => toggleFavorite(index),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
