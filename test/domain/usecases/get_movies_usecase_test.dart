import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_movie/domain/usecases/get_movies_usecase.dart';
import 'package:flutter_movie/domain/repositories/movie_repository.dart';
import 'package:flutter_movie/domain/entities/movie.dart';
import 'dart:async';

import 'get_movies_usecase_test.mocks.dart';

@GenerateMocks([MovieRepository])
void main() {
  late MockMovieRepository mockRepository;
  late GetMoviesUseCase useCase;

  setUp(() {
    mockRepository = MockMovieRepository();
    useCase = GetMoviesUseCase(mockRepository);
  });

  test('should return a stream of movies from repository', () async {
    final movies = [
      Movie(id: 1, title: 'A', genre: 'Drama', rating: '8.0', imageResId: 1, isFavorite: false),
      Movie(id: 2, title: 'B', genre: 'Action', rating: '7.0', imageResId: 2, isFavorite: true),
    ];
    final controller = StreamController<List<Movie>>();
    when(mockRepository.getMovies()).thenAnswer((_) => controller.stream);

    final resultStream = useCase();
    controller.add(movies);
    await expectLater(resultStream, emits(movies));
    controller.close();
  });
}

