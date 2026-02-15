import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_movie/presentation/viewmodel/movie_viewmodel.dart';
import 'package:flutter_movie/domain/usecases/get_movies_usecase.dart';
import 'package:flutter_movie/domain/usecases/refresh_movies_usecase.dart';
import 'package:flutter_movie/domain/usecases/update_favorite_status_usecase.dart';
import 'package:flutter_movie/domain/entities/movie.dart';
import 'dart:async';

import 'movie_viewmodel_test.mocks.dart';

@GenerateMocks([
  GetMoviesUseCase,
  RefreshMoviesUseCase,
  UpdateFavoriteStatusUseCase,
])
void main() {
  late MockGetMoviesUseCase mockGetMoviesUseCase;
  late MockRefreshMoviesUseCase mockRefreshMoviesUseCase;
  late MockUpdateFavoriteStatusUseCase mockUpdateFavoriteStatusUseCase;
  late MovieViewModel viewModel;
  late StreamController<List<Movie>> moviesStreamController;

  final testMovies = [
    Movie(id: 1, title: 'Movie 1', genre: 'Action', rating: '8.5', isFavorite: false, imageResId: 1),
    Movie(id: 2, title: 'Movie 2', genre: 'Drama', rating: '7.0', isFavorite: true, imageResId: 2),
    Movie(id: 3, title: 'Movie 3', genre: 'Horror', rating: '4.5', isFavorite: false, imageResId: 3),
  ];

  setUp(() {
    mockGetMoviesUseCase = MockGetMoviesUseCase();
    mockRefreshMoviesUseCase = MockRefreshMoviesUseCase();
    mockUpdateFavoriteStatusUseCase = MockUpdateFavoriteStatusUseCase();
    moviesStreamController = StreamController<List<Movie>>.broadcast();
    when(mockGetMoviesUseCase()).thenAnswer((_) => moviesStreamController.stream);
    when(mockRefreshMoviesUseCase()).thenAnswer((_) async {}); // Always stub refresh
    viewModel = MovieViewModel(
      mockGetMoviesUseCase,
      mockRefreshMoviesUseCase,
      mockUpdateFavoriteStatusUseCase,
    );
  });

  tearDown(() {
    moviesStreamController.close();
  });

  test('initial state is correct', () {
    // The constructor calls refreshMovies, so isLoading may be true
    expect(viewModel.state.movies, const []);
    expect(viewModel.state.allMovies, const []);
    expect(viewModel.state.searchQuery, '');
    expect(viewModel.state.selectedGenre, 'All');
    expect(viewModel.state.selectedRating, 'All');
    // isLoading can be true or false depending on async timing
  });

  test('loads movies from use case and updates state', () async {
    moviesStreamController.add(testMovies);
    await Future.delayed(Duration.zero);
    expect(viewModel.state.movies.length, 3);
    expect(viewModel.state.allMovies.length, 3);
    expect(viewModel.state.movies[0].title, 'Movie 1');
  });

  test('refreshMovies sets loading and calls use case', () async {
    when(mockRefreshMoviesUseCase()).thenAnswer((_) async {});
    final future = viewModel.refreshMovies();
    expect(viewModel.state.isLoading, true);
    await future;
    expect(viewModel.state.isLoading, false);
    verify(mockRefreshMoviesUseCase()).called(2); // One from constructor, one from explicit call
  });

  test('toggleFavorite calls use case', () async {
    when(mockUpdateFavoriteStatusUseCase(any)).thenAnswer((_) async {});
    final movie = testMovies[0];
    await viewModel.toggleFavorite(movie);
    verify(mockUpdateFavoriteStatusUseCase(movie)).called(1);
  });

  test('onSearchQueryChange filters movies by title', () async {
    moviesStreamController.add(testMovies);
    await Future.delayed(Duration.zero);
    viewModel.onSearchQueryChange('Movie 2');
    expect(viewModel.state.movies.length, 1);
    expect(viewModel.state.movies[0].title, 'Movie 2');
  });

  test('onGenreSelected filters movies by genre', () async {
    moviesStreamController.add(testMovies);
    await Future.delayed(Duration.zero);
    viewModel.onGenreSelected('Drama');
    expect(viewModel.state.movies.length, 1);
    expect(viewModel.state.movies[0].genre, 'Drama');
  });

  test('onRatingSelected filters movies by rating', () async {
    moviesStreamController.add(testMovies);
    await Future.delayed(Duration.zero);
    viewModel.onRatingSelected('Good');
    expect(viewModel.state.movies.length, 1);
    expect(viewModel.state.movies[0].rating, '8.5');
    viewModel.onRatingSelected('Bad');
    expect(viewModel.state.movies.length, 1);
    expect(viewModel.state.movies[0].rating, '4.5');
  });

  test('allMovies always contains the full list regardless of filters', () async {
    moviesStreamController.add(testMovies);
    await Future.delayed(Duration.zero);
    viewModel.onSearchQueryChange('Movie 2');
    expect(viewModel.state.movies.length, 1);
    expect(viewModel.state.allMovies.length, 3);
  });

  test('favorites are filtered only by isFavorite', () async {
    moviesStreamController.add(testMovies);
    await Future.delayed(Duration.zero);
    final favorites = viewModel.state.allMovies.where((m) => m.isFavorite).toList();
    expect(favorites.length, 1);
    expect(favorites[0].title, 'Movie 2');
  });
}
