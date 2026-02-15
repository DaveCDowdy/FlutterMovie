import 'package:flutter/material.dart';
import 'package:flutter_movie/domain/entities/movie.dart';

class FavoriteMovieItem extends StatelessWidget {
  final Movie movie;
  final ValueChanged<Movie> onRemoveFavorite;

  const FavoriteMovieItem({
    super.key,
    required this.movie,
    required this.onRemoveFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(top: 24, bottom: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/movie_${movie.imageResId}.jpg',
              width: 160,
              height: 220,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 160,
                height: 220,
                color: Colors.grey[800],
                child: const Icon(Icons.broken_image, size: 48, color: Colors.white54),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              movie.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Genre: ${movie.genre}',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Rating: ${movie.rating}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red, size: 28),
                onPressed: () => onRemoveFavorite(movie),
                tooltip: 'Remove from favorites',
              ),
              Text(
                'Remove',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
