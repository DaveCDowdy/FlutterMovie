import 'package:flutter_movie/domain/entities/movie.dart';

abstract class MovieRepository {
  Stream<List<Movie>> getMovies();
  Future<void> refreshMovies();
  Future<void> updateFavoriteStatus(Movie movie);
}

