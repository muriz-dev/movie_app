import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/movie.dart';

class MovieRepository {
  static const String _baseUrl = 'https://imdb.iamidiotareyoutoo.com/search';
  static const String _cacheKeyPrefix = 'cached_movies_';

  Future<List<MovieModel>> searchMovies(String query) async {
    final cacheKey = '$_cacheKeyPrefix$query';
    final prefs = await SharedPreferences.getInstance();

    try {
      final url = Uri.parse('$_baseUrl?q=$query');
      final response = await http.get(url).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded['ok'] == true && decoded['description'] != null) {
          final List<dynamic> descriptionList = decoded['description'];
          final List<MovieModel> movies = descriptionList.map((e) => MovieModel.fromJson(e)).toList();
          
          // Cache the successful response string
          await prefs.setString(cacheKey, jsonEncode(descriptionList));
          
          return movies;
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
        return decodedList.map((e) => MovieModel.fromJson(e)).toList();
      }
      
      // If no cache, throw the error
      throw Exception('Failed to load movies and no cache available. Error: $e');
    }
  }
}
