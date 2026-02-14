import 'dart:async';
import 'package:flutter_movie/data/dao/movie_dao.dart';
import 'package:flutter_movie/data/local_data_source/local_movie_data_source.dart';
import 'package:flutter_movie/data/model/movie_entity.dart';
import 'package:flutter_movie/domain/entities/movie.dart';
import 'package:flutter_movie/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieDao movieDao;
  final LocalMovieDataSource localMovieDataSource;

  MovieRepositoryImpl({required this.movieDao, required this.localMovieDataSource});

  @override
  Stream<List<Movie>> getMovies() {
    return movieDao.getAllMovies().map(
      (entities) => entities.map((entity) => Movie(
        id: entity.id,
        title: entity.title,
        genre: entity.genre,
        rating: entity.rating,
        imageResId: entity.imageResId,
        isFavorite: entity.isFavorite,
      )).toList(),
    );
  }

  @override
  Future<void> refreshMovies() async {
    final newMoviesFromLocal = await localMovieDataSource.getMovies();
    final existingMovies = await movieDao.getAllMovies().first;
    final existingFavoritesMap = {
      for (var movie in existingMovies) movie.id: movie.isFavorite
    };
    final mergedMovies = newMoviesFromLocal.map((dto) {
      final isFavorite = existingFavoritesMap[dto.id] ?? false;
      return MovieEntity(
        id: dto.id,
        title: dto.title,
        genre: dto.genre,
        rating: dto.rating,
        imageResId: dto.imageResId,
        isFavorite: isFavorite,
      );
    }).toList();
    await movieDao.insertMovies(mergedMovies);
  }

  @override
  Future<void> updateFavoriteStatus(Movie movie) async {
    final movieEntity = MovieEntity(
      id: movie.id,
      title: movie.title,
      genre: movie.genre,
      rating: movie.rating,
      imageResId: movie.imageResId,
      isFavorite: movie.isFavorite,
    );
    await movieDao.updateMovie(movieEntity);
  }
}
