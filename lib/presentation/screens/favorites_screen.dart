import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_movie/presentation/providers/movie_viewmodel_provider.dart';
import 'package:flutter_movie/presentation/widgets/bottom_bar.dart';
import 'package:flutter_movie/presentation/widgets/favorite_movie_item.dart';
import 'package:flutter_movie/presentation/widgets/app_logo.dart';

class FavoritesScreen extends ConsumerWidget {
  final VoidCallback? onNavigateToHome;
  final VoidCallback? onNavigateToFavorites;

  const FavoritesScreen({
    super.key,
    this.onNavigateToHome,
    this.onNavigateToFavorites,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(movieViewModelProvider);
    // Show all favorites regardless of filter
    final allMovies = uiState.allMovies.isNotEmpty ? uiState.allMovies : uiState.movies;
    final favoriteMovies = allMovies.where((m) => m.isFavorite).toList();

    return Scaffold(
      bottomNavigationBar: BottomBar(
        onNavigateToHome: onNavigateToHome ?? () {},
        onNavigateToFavorites: onNavigateToFavorites ?? () {},
      ),
      body: Padding(
        padding: MediaQuery.of(context).padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            const AppLogo(),
            const SizedBox(height: 16),
            Text(
              'Favorite Movies',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            if (favoriteMovies.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'No favorites yet!',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Scrollbar(
                          thumbVisibility: true,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            itemCount: favoriteMovies.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 24),
                            itemBuilder: (context, index) {
                              final movie = favoriteMovies[index];
                              return FavoriteMovieItem(
                                movie: movie,
                                onRemoveFavorite: (movie) => ref.read(movieViewModelProvider.notifier).toggleFavorite(movie),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.swipe, color: Colors.white54, size: 18),
                        SizedBox(width: 6),
                        Text('Swipe to see more', style: TextStyle(color: Colors.white54, fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
