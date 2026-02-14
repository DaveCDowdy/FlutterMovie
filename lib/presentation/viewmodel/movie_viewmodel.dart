import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_movie/domain/entities/movie.dart';
import 'package:flutter_movie/domain/usecases/get_movies_usecase.dart';
import 'package:flutter_movie/domain/usecases/refresh_movies_usecase.dart';
import 'package:flutter_movie/domain/usecases/update_favorite_status_usecase.dart';
import '../model/movie_ui_state.dart';

class MovieViewModel extends StateNotifier<MovieUiState> {
  final GetMoviesUseCase getMoviesUseCase;
  final RefreshMoviesUseCase refreshMoviesUseCase;
  final UpdateFavoriteStatusUseCase toggleFavoriteUseCase;

  // Private full list, never exposed to UI
  List<Movie> _allMovies = [];

  MovieViewModel(
    this.getMoviesUseCase,
    this.refreshMoviesUseCase,
    this.toggleFavoriteUseCase,
  ) : super(const MovieUiState()) {
    _init();
  }

  void _init() {
    getMoviesUseCase().listen((movies) {
      _allMovies = movies;
      _applyAndSetFilters();
    });
    refreshMovies();
  }

  Future<void> refreshMovies() async {
    state = state.copyWith(isLoading: true);
    await refreshMoviesUseCase();
    state = state.copyWith(isLoading: false);
  }

  Future<void> toggleFavorite(Movie movie) async {
    await toggleFavoriteUseCase(movie);
  }

  void onSearchQueryChange(String query) {
    state = state.copyWith(searchQuery: query);
    _applyAndSetFilters();
  }

  void onGenreSelected(String genre) {
    state = state.copyWith(selectedGenre: genre);
    _applyAndSetFilters();
  }

  void onRatingSelected(String rating) {
    state = state.copyWith(selectedRating: rating);
    _applyAndSetFilters();
  }

  void _applyAndSetFilters() {
    final filteredMovies = _applyFilters(
      _allMovies,
      state.searchQuery,
      state.selectedGenre,
      state.selectedRating,
    );
    state = state.copyWith(
      movies: filteredMovies,
      allMovies: List<Movie>.from(_allMovies), // Always keep allMovies in sync
    );
  }

  List<Movie> _applyFilters(
    List<Movie> movies,
    String query,
    String genre,
    String rating,
  ) {
    final genreFilter = genre.trim().toLowerCase();
    final queryFilter = query.trim().toLowerCase();
    final ratingFilter = rating.trim().toLowerCase();
    return movies.where((movie) {
      final movieGenre = movie.genre.trim().toLowerCase();
      final matchesGenre = genreFilter == 'all' || movieGenre == genreFilter;
      final matchesSearchTerm = movie.title.toLowerCase().contains(queryFilter);
      final ratingValue = double.tryParse(movie.rating) ?? 0.0;
      final matchesRating = switch (ratingFilter) {
        'all' => true,
        'good' => ratingValue >= 8.0,
        'ok' => ratingValue >= 5.0 && ratingValue < 8.0,
        'bad' => ratingValue < 5.0,
        _ => false,
      };
      return matchesGenre && matchesSearchTerm && matchesRating;
    }).toList();
  }
}
