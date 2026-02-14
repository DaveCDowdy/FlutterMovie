import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_movie/domain/usecases/get_movies_usecase.dart';
import 'package:flutter_movie/presentation/providers/movie_repository_provider.dart';

final getMoviesUseCaseProvider = Provider<GetMoviesUseCase>((ref) {
  final repo = ref.watch(movieRepositoryProvider);
  return GetMoviesUseCase(repo);
});

final moviesStreamProvider = StreamProvider((ref) {
  return ref.watch(getMoviesUseCaseProvider).call();
});
