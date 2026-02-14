import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_movie/domain/usecases/refresh_movies_usecase.dart';
import 'package:flutter_movie/presentation/providers/movie_repository_provider.dart';

final refreshMoviesUseCaseProvider = Provider<RefreshMoviesUseCase>((ref) {
  final repo = ref.watch(movieRepositoryProvider);
  return RefreshMoviesUseCase(repo);
});

