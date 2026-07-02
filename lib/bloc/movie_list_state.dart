part of 'movie_list_bloc.dart';

@immutable
sealed class MovieListState {}

final class MovieListInitial extends MovieListState {}

final class MovieListLoading extends MovieListState {}

final class MovieListLoaded extends MovieListState {
  final List<MovieModel> searchMovies;
  final List<MovieModel> favoriteMovies;

  MovieListLoaded(this.searchMovies, this.favoriteMovies);
}

final class MovieListError extends MovieListState {
  final String errorMessage;

  MovieListError(this.errorMessage);
}
