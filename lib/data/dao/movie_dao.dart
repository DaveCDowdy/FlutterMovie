import 'package:floor/floor.dart';
import '../model/movie_entity.dart';

@dao
abstract class MovieDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMovies(List<MovieEntity> movies);

  @Query('SELECT * FROM movies')
  Stream<List<MovieEntity>> getAllMovies();

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateMovie(MovieEntity movie);
}
