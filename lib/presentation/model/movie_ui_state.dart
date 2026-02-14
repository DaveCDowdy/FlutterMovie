import 'package:flutter_movie/domain/entities/movie.dart';

class MovieUiState {
  final List<Movie> movies;
  final List<Movie> allMovies;
  final String searchQuery;
  final String selectedGenre;
  final String selectedRating;
  final bool isLoading;

  const MovieUiState({
    this.movies = const [],
    this.allMovies = const [],
    this.searchQuery = '',
    this.selectedGenre = 'All',
    this.selectedRating = 'All',
    this.isLoading = false,
  });

  MovieUiState copyWith({
    List<Movie>? movies,
    List<Movie>? allMovies,
    String? searchQuery,
    String? selectedGenre,
    String? selectedRating,
    bool? isLoading,
  }) {
    return MovieUiState(
      movies: movies ?? this.movies,
      allMovies: allMovies ?? this.allMovies,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedGenre: selectedGenre ?? this.selectedGenre,
      selectedRating: selectedRating ?? this.selectedRating,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
