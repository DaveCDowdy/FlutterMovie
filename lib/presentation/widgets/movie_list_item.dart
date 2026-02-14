import 'package:flutter/material.dart';
import 'package:flutter_movie/domain/entities/movie.dart';

class MovieListItem extends StatelessWidget {
  final Movie movie;
  final ValueChanged<Movie> onToggleFavorite;
  final EdgeInsetsGeometry? padding;

  const MovieListItem({
    super.key,
    required this.movie,
    required this.onToggleFavorite,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/movie_${movie.imageResId}.jpg',
                width: 100,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 100,
                  height: 150,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Genre: ${movie.genre}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Rating: ${movie.rating}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => onToggleFavorite(movie),
              icon: Icon(
                movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).colorScheme.primary,
              ),
              tooltip: 'Favorite',
              alignment: Alignment.topCenter,
            ),
          ],
        ),
      ),
    );
  }
}
