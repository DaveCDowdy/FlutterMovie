import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_movie/data/local_data_source/local_movie_data_source.dart';
import 'package:flutter_movie/data/model/movie.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late LocalMovieDataSource dataSource;

  setUp(() {
    dataSource = LocalMovieDataSource();
  });

  test('getMovies parses JSON and maps images', () async {
    final movies = await dataSource.getMovies();
    expect(movies, isA<List<Movie>>());
    expect(movies.isNotEmpty, true);
    expect(movies.first.imageResId, isA<int>());
  });
}
