part of 'movie_list_bloc.dart';

@immutable
sealed class MovieListState {}

final class MovieListInitial extends MovieListState {}

final class MovieListLoading extends MovieListState {}

final class MovieListLoaded extends MovieListState {
  final List<MovieModel> movies;

  MovieListLoaded(this.movies);
}

final class MovieListError extends MovieListState {
  final String errorMessage;

  MovieListError(this.errorMessage);
}
