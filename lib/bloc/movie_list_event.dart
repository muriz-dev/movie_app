part of 'movie_list_bloc.dart';

@immutable
sealed class MovieListEvent {}

final class FetchMoviesEvent extends MovieListEvent {}

final class ToogleFavoriteEvent extends MovieListEvent {
  final MovieModel movie;

  ToogleFavoriteEvent(this.movie);
}
