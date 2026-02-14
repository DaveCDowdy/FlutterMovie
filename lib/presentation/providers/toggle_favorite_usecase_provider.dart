import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_movie/domain/usecases/update_favorite_status_usecase.dart';
import 'package:flutter_movie/presentation/providers/movie_repository_provider.dart';

final toggleFavoriteUseCaseProvider = Provider<UpdateFavoriteStatusUseCase>((ref) {
  final repo = ref.watch(movieRepositoryProvider);
  return UpdateFavoriteStatusUseCase(repo);
});

