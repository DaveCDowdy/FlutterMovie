import 'package:flutter/material.dart';
import 'package:flutter_movie/presentation/screens/movie_list_screen.dart';
import 'package:flutter_movie/presentation/screens/favorites_screen.dart';

enum ScreenRoute { home, favorites }

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  ScreenRoute _currentRoute = ScreenRoute.home;

  void _navigateTo(ScreenRoute route) {
    setState(() {
      _currentRoute = route;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        if (_currentRoute == ScreenRoute.home)
          MaterialPage(
            key: const ValueKey('home'),
            child: MovieListScreen(
              onNavigateToHome: () => _navigateTo(ScreenRoute.home),
              onNavigateToFavorites: () => _navigateTo(ScreenRoute.favorites),
            ),
          ),
        if (_currentRoute == ScreenRoute.favorites)
          MaterialPage(
            key: const ValueKey('favorites'),
            child: FavoritesScreen(
              onNavigateToHome: () => _navigateTo(ScreenRoute.home),
              onNavigateToFavorites: () => _navigateTo(ScreenRoute.favorites),
            ),
          ),
      ],
    );
  }
}
