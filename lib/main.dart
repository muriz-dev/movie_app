import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ui/pages/home.dart';
import 'bloc/movie_list_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieListBloc()..add(FetchMoviesEvent()),
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
