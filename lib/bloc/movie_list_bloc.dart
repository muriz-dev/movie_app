import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/model/movie.dart';
import '../data/movie_repository.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MovieRepository movieRepository;

  MovieListBloc({required this.movieRepository}) : super(MovieListInitial()) {
    on<ToogleFavoriteEvent>(onToogleFavorite);
    on<FetchMoviesEvent>(onFetchMovies);
  }

  void onFetchMovies(
    FetchMoviesEvent event,
    Emitter<MovieListState> emit,
  ) async {
    emit(MovieListLoading());

    try {
      final query = event.query ?? 'avatar'; // Default query if none provided
      final movies = await movieRepository.searchMovies(query);
      emit(MovieListLoaded(movies));
    } catch (e) {
      emit(MovieListError('Failed to fetch movies: $e'));
    }
  }

  void onToogleFavorite(
    ToogleFavoriteEvent event,
    Emitter<MovieListState> emit,
  ) {
    if (state is MovieListLoaded) {
      final currentState = state as MovieListLoaded;

      final updatedMovie = currentState.movies.map((movie) {
        if (movie.id == event.movie.id) {
          return movie.copyWith(isFavorite: !movie.isFavorite);
        }

        return movie;
      }).toList();

      emit(MovieListLoaded(updatedMovie));
    }
  }
}
