import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/movie_list_bloc.dart';
import '../../model/movie.dart';

class MovieDetail extends StatelessWidget {
  final MovieModel initialMovie;

  const MovieDetail({super.key, required this.initialMovie});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieListBloc, MovieListState>(
      builder: (context, state) {
        MovieModel movie = initialMovie;
        if (state is MovieListLoaded) {
          try {
            movie = state.movies.firstWhere((m) => m.id == initialMovie.id);
          } catch (_) {}
        }

        return Scaffold(
          appBar: AppBar(title: Text(movie.title)),
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
                        movie.imageUrl,
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
                    'Release Date: ${movie.releaseDate}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Rating: ${movie.rating}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(movie.overview, style: const TextStyle(fontSize: 14)),

                  const SizedBox(height: 20),

                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: movie.isFavorite
                            ? Colors.red
                            : Colors.amber,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () {
                        context.read<MovieListBloc>().add(
                          ToogleFavoriteEvent(movie),
                        );

                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              movie.isFavorite
                                  ? 'Removed from Favorites'
                                  : 'Added to Favorites',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Text(
                        movie.isFavorite
                            ? 'Remove from Favorites'
                            : 'Add to Favorites',
                        style: TextStyle(
                          color: movie.isFavorite ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
