import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_movie/data/model/movie.dart';

class LocalMovieDataSource {
  static const String _moviesFilePath = 'assets/movies/movies.json';

  Future<List<Movie>> getMovies() async {
    final jsonString = await rootBundle.loadString(_moviesFilePath);
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) {
      final movie = Movie.fromJson(json);
      // Extract the number from a filename like 'movie_1.jpg'
      final match = RegExp(r'movie_(\d+)').firstMatch(movie.image);
      final imageResId = match != null ? int.parse(match.group(1)!) : 0;
      return Movie(
        id: movie.id,
        title: movie.title,
        image: movie.image,
        genre: movie.genre,
        rating: movie.rating,
        imageResId: imageResId,
      );
    }).toList();
  }
}
