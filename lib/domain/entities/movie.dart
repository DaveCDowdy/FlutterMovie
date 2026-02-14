import 'package:flutter_movie/data/model/movie_entity.dart';

/// Domain entity representing a Movie in the app's business logic.
class Movie {
  final int id;
  final String title;
  final String genre;
  final String rating;
  final int imageResId;
  final bool isFavorite;

  Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.rating,
    this.imageResId = 0,
    this.isFavorite = false,
  });

  /// Create a Movie from a MovieEntity (persistence model).
  factory Movie.fromEntity(MovieEntity entity) {
    return Movie(
      id: entity.id,
      title: entity.title,
      genre: entity.genre,
      rating: entity.rating,
      imageResId: entity.imageResId,
      isFavorite: entity.isFavorite,
    );
  }

  /// Convert this Movie to a MovieEntity for persistence.
  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      title: title,
      genre: genre,
      rating: rating,
      imageResId: imageResId,
      isFavorite: isFavorite,
    );
  }

  Movie copyWith({
    int? id,
    String? title,
    String? genre,
    String? rating,
    int? imageResId,
    bool? isFavorite,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      genre: genre ?? this.genre,
      rating: rating ?? this.rating,
      imageResId: imageResId ?? this.imageResId,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
