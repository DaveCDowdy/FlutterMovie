import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_movie/domain/usecases/refresh_movies_usecase.dart';
import 'package:flutter_movie/domain/repositories/movie_repository.dart';

import 'refresh_movies_usecase_test.mocks.dart';

@GenerateMocks([MovieRepository])
void main() {
  late MockMovieRepository mockRepository;
  late RefreshMoviesUseCase useCase;

  setUp(() {
    mockRepository = MockMovieRepository();
    useCase = RefreshMoviesUseCase(mockRepository);
  });

  test('should call refreshMovies on repository', () async {
    await useCase();
    verify(mockRepository.refreshMovies()).called(1);
  });
}
