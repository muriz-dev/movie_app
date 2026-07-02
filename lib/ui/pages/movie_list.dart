import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/movie_list_bloc.dart';
import '../widgets/movie_card.dart';
import 'movie_detail.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    if (query.trim().isNotEmpty) {
      context.read<MovieListBloc>().add(FetchMoviesEvent(query: query.trim()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search for movies (e.g. Inception, Batman)...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                },
              ),
            ),
            onSubmitted: _onSearch,
            textInputAction: TextInputAction.search,
          ),
        ),
        Expanded(
          child: BlocBuilder<MovieListBloc, MovieListState>(
            builder: (context, state) {
              if (state is MovieListInitial || state is MovieListLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MovieListLoaded) {
                final movies = state.movies;
                
                if (movies.isEmpty) {
                  return const Center(child: Text('No movies available.'));
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetail(
                                initialMovie: movie,
                              ),
                            ),
                          );
                        },
                        child: MovieCard(
                          title: movie.title,
                          overview: movie.overview,
                          releaseDate: movie.releaseDate,
                          rating: movie.rating,
                          imageUrl: movie.imageUrl,
                          isFavorite: movie.isFavorite,
                          onFavoriteToggle: () {
                            context.read<MovieListBloc>().add(ToogleFavoriteEvent(movie));
                          },
                        ),
                      );
                    },
                  ),
                );
              } else if (state is MovieListError) {
                return Center(child: Text(state.errorMessage));
              }
              
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
