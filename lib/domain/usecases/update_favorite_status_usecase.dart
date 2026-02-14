import 'package:flutter_movie/domain/entities/movie.dart';
import 'package:flutter_movie/domain/repositories/movie_repository.dart';

class UpdateFavoriteStatusUseCase {
  final MovieRepository movieRepository;
  UpdateFavoriteStatusUseCase(this.movieRepository);

  Future<void> call(Movie movie) async {
    // Toggle the isFavorite property before updating
    await movieRepository.updateFavoriteStatus(
      movie.copyWith(isFavorite: !movie.isFavorite),
    );
  }
}
