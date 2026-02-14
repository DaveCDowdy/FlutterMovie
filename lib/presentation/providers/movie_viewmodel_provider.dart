import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_movie/presentation/viewmodel/movie_viewmodel.dart';
import 'package:flutter_movie/presentation/providers/get_movies_usecase_provider.dart';
import 'package:flutter_movie/presentation/providers/refresh_movies_usecase_provider.dart';
import 'package:flutter_movie/presentation/providers/toggle_favorite_usecase_provider.dart';
import 'package:flutter_movie/presentation/model/movie_ui_state.dart';

final movieViewModelProvider = StateNotifierProvider<MovieViewModel, MovieUiState>((ref) {
  final getMovies = ref.watch(getMoviesUseCaseProvider);
  final refreshMovies = ref.watch(refreshMoviesUseCaseProvider);
  final toggleFavorite = ref.watch(toggleFavoriteUseCaseProvider);
  return MovieViewModel(getMovies, refreshMovies, toggleFavorite);
});

