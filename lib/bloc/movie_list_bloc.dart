import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/model/movie.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  MovieListBloc() : super(MovieListInitial()) {
    on<ToogleFavoriteEvent>(onToogleFavorite);
    on<FetchMoviesEvent>(onFetchMovies);
  }

  void onFetchMovies(
    FetchMoviesEvent event,
    Emitter<MovieListState> emit,
  ) async {
    emit(MovieListLoading());

    await Future.delayed(const Duration(seconds: 3));

    final String response = await rootBundle.loadString('assets/movies.json');
    final List<dynamic> rawData = jsonDecode(response);
    final List<MovieModel> movies = rawData
        .map((e) => MovieModel.fromJson(e))
        .toList();

    emit(MovieListLoaded(movies));
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
