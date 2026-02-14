import 'package:flutter_movie/domain/repositories/movie_repository.dart';

class RefreshMoviesUseCase {
  final MovieRepository movieRepository;
  RefreshMoviesUseCase(this.movieRepository);

  Future<void> call() async {
    await movieRepository.refreshMovies();
  }
}

