import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_movie/data/db/app_database.dart';
import 'package:flutter_movie/data/local_data_source/local_movie_data_source.dart';
import 'package:flutter_movie/data/repository/movie_repository_impl.dart';
import 'package:flutter_movie/domain/repositories/movie_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('AppDatabase must be initialized in main or a provider override.');
});

final movieDaoProvider = Provider((ref) => ref.watch(appDatabaseProvider).movieDao);

final localMovieDataSourceProvider = Provider((ref) => LocalMovieDataSource());

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final movieDao = ref.watch(movieDaoProvider);
  final localMovieDataSource = ref.watch(localMovieDataSourceProvider);
  return MovieRepositoryImpl(
    movieDao: movieDao,
    localMovieDataSource: localMovieDataSource,
  );
});

