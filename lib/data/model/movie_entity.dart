import 'package:floor/floor.dart';

@Entity(tableName: 'movies')
class MovieEntity {
  @primaryKey
  final int id;
  @ColumnInfo(name: 'title')
  final String title;
  @ColumnInfo(name: 'genre')
  final String genre;
  @ColumnInfo(name: 'rating')
  final String rating;
  @ColumnInfo(name: 'image_res_id')
  final int imageResId;
  @ColumnInfo(name: 'is_favorite')
  final bool isFavorite;

  MovieEntity({
    required this.id,
    required this.title,
    required this.genre,
    required this.rating,
    required this.imageResId,
    this.isFavorite = false,
  });
}
