import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_movie/data/repository/movie_repository_impl.dart';
import 'package:flutter_movie/data/dao/movie_dao.dart';
import 'package:flutter_movie/data/model/movie_entity.dart';
import 'package:flutter_movie/data/local_data_source/local_movie_data_source.dart';
import 'package:flutter_movie/domain/entities/movie.dart' as domain_movie;
import 'dart:async';
import 'package:flutter_movie/data/model/movie.dart' as data_movie;

import 'movie_repository_impl_test.mocks.dart';

@GenerateMocks([MovieDao, LocalMovieDataSource])
void main() {
  late MockMovieDao mockDao;
  late MockLocalMovieDataSource mockLocalDataSource;
  late MovieRepositoryImpl repository;

  setUp(() {
    mockDao = MockMovieDao();
    mockLocalDataSource = MockLocalMovieDataSource();
    repository = MovieRepositoryImpl(
      movieDao: mockDao,
      localMovieDataSource: mockLocalDataSource,
    );
  });

  test('getMovies returns mapped domain movies from dao', () async {
    final entities = [
      MovieEntity(id: 1, title: 'A', genre: 'Drama', rating: '8.0', imageResId: 1, isFavorite: false),
      MovieEntity(id: 2, title: 'B', genre: 'Action', rating: '7.0', imageResId: 2, isFavorite: true),
    ];
    final controller = StreamController<List<MovieEntity>>();
    when(mockDao.getAllMovies()).thenAnswer((_) => controller.stream);
    final resultStream = repository.getMovies();
    controller.add(entities);
    await expectLater(resultStream, emits(isA<List<domain_movie.Movie>>().having((l) => l.length, 'length', 2)));
    controller.close();
  });

  test('refreshMovies merges local and db favorites and updates dao', () async {
    final localMovies = [
      data_movie.Movie(id: 1, title: 'A', image: '1.jpg', genre: 'Drama', rating: '8.0', imageResId: 1),
      data_movie.Movie(id: 2, title: 'B', image: '2.jpg', genre: 'Action', rating: '7.0', imageResId: 2),
    ];
    final dbEntities = [
      MovieEntity(id: 1, title: 'A', genre: 'Drama', rating: '8.0', imageResId: 1, isFavorite: true),
      MovieEntity(id: 2, title: 'B', genre: 'Action', rating: '7.0', imageResId: 2, isFavorite: false),
    ];
    when(mockLocalDataSource.getMovies()).thenAnswer((_) => Future.value(localMovies));
    when(mockDao.getAllMovies()).thenAnswer((_) async* { yield dbEntities; });
    when(mockDao.insertMovies(any)).thenAnswer((_) async {});
    await repository.refreshMovies();
    final verification = verify(mockDao.insertMovies(captureAny));
    final merged = verification.captured.single as List<MovieEntity>;
    expect(merged[0].isFavorite, true); // Preserved favorite
    expect(merged[1].isFavorite, false);
  });

  test('updateFavoriteStatus updates dao with correct entity', () async {
    final movie = domain_movie.Movie(id: 1, title: 'A', genre: 'Drama', rating: '8.0', imageResId: 1, isFavorite: true);
    when(mockDao.updateMovie(any)).thenAnswer((_) async {});
    await repository.updateFavoriteStatus(movie);
    final captured = verify(mockDao.updateMovie(captureAny)).captured.single as MovieEntity;
    expect(captured.id, movie.id);
    expect(captured.isFavorite, movie.isFavorite);
  });
}
