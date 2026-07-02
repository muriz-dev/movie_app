import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ui/pages/home.dart';
import 'bloc/movie_list_bloc.dart';
import 'data/movie_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final MovieRepository _movieRepository = MovieRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieListBloc(movieRepository: _movieRepository)..add(FetchMoviesEvent()),
      child: MaterialApp(
        title: 'Movie App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        ),
        home: const Home(title: 'Movie App'),
      ),
    );
  }
}
