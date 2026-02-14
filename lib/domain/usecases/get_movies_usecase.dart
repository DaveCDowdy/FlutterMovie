import 'package:flutter_movie/domain/entities/movie.dart';
import 'package:flutter_movie/domain/repositories/movie_repository.dart';

class GetMoviesUseCase {
  final MovieRepository movieRepository;
  GetMoviesUseCase(this.movieRepository);

  Stream<List<Movie>> call() {
    return movieRepository.getMovies();
  }
}

