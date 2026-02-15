import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_movie/domain/usecases/update_favorite_status_usecase.dart';
import 'package:flutter_movie/domain/repositories/movie_repository.dart';
import 'package:flutter_movie/domain/entities/movie.dart';

import 'update_favorite_status_usecase_test.mocks.dart';

@GenerateMocks([MovieRepository])
void main() {
  late MockMovieRepository mockRepository;
  late UpdateFavoriteStatusUseCase useCase;

  setUp(() {
    mockRepository = MockMovieRepository();
    useCase = UpdateFavoriteStatusUseCase(mockRepository);
  });

  test('should toggle isFavorite and call updateFavoriteStatus on repository', () async {
    final movie = Movie(id: 1, title: 'A', genre: 'Drama', rating: '8.0', imageResId: 1, isFavorite: false);
    when(mockRepository.updateFavoriteStatus(any)).thenAnswer((_) async {});
    await useCase(movie);
    final captured = verify(mockRepository.updateFavoriteStatus(captureAny)).captured.single as Movie;
    expect(captured.id, movie.id);
    expect(captured.isFavorite, !movie.isFavorite);
  });
}
