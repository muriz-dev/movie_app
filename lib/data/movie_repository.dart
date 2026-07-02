import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/movie.dart';

class MovieRepository {
  static const String _baseUrl = 'https://imdb.iamidiotareyoutoo.com/search';
  static const String _cacheKeyPrefix = 'cached_movies_';
  static const String _favoritesKey = 'favorite_movies';

  Future<List<MovieModel>> searchMovies(String query) async {
    final cacheKey = '$_cacheKeyPrefix$query';
    final prefs = await SharedPreferences.getInstance();
    
    List<MovieModel> movies = [];

    try {
      final url = Uri.parse('$_baseUrl?q=$query');
      final response = await http.get(url).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded['ok'] == true && decoded['description'] != null) {
          final List<dynamic> descriptionList = decoded['description'];
          movies = descriptionList.map((e) => MovieModel.fromJson(e)).toList();
          
          // Cache the successful response string
          await prefs.setString(cacheKey, jsonEncode(descriptionList));
        } else {
          throw Exception('Failed to load movies: API response not ok');
        }
      } else {
        throw Exception('Failed to load movies: Status code ${response.statusCode}');
      }
    } catch (e) {
      // On network error or any exception, try to load from cache
      final cachedData = prefs.getString(cacheKey);
      if (cachedData != null) {
        final List<dynamic> decodedList = jsonDecode(cachedData);
        movies = decodedList.map((e) => MovieModel.fromJson(e)).toList();
      } else {
        // If no cache, throw the error
        throw Exception('Failed to load movies and no cache available. Error: $e');
      }
    }
    
    // Reconcile with favorites
    final favorites = await getFavoriteMovies();
    final favoriteIds = favorites.map((m) => m.id).toSet();
    
    return movies.map((m) {
      if (favoriteIds.contains(m.id)) {
        return m.copyWith(isFavorite: true);
      }
      return m;
    }).toList();
  }

  Future<List<MovieModel>> getFavoriteMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString(_favoritesKey);
    
    if (favoritesJson != null) {
      final List<dynamic> decodedList = jsonDecode(favoritesJson);
      // Ensure they are marked as favorite
      return decodedList.map((e) => MovieModel.fromJson(e).copyWith(isFavorite: true)).toList();
    }
    
    return [];
  }

  Future<void> toggleFavorite(MovieModel movie) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavoriteMovies();
    
    final existingIndex = favorites.indexWhere((m) => m.id == movie.id);
    
    if (existingIndex >= 0) {
      // It exists, so we remove it
      favorites.removeAt(existingIndex);
    } else {
      // Doesn't exist, we add it
      favorites.add(movie.copyWith(isFavorite: true));
    }
    
    // Save back to SharedPreferences using toJson
    final String updatedJson = jsonEncode(favorites.map((m) => m.toJson()).toList());
    await prefs.setString(_favoritesKey, updatedJson);
  }
}
