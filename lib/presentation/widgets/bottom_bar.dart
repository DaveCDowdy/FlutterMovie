import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final VoidCallback onNavigateToHome;
  final VoidCallback onNavigateToFavorites;

  const BottomBar({
    Key? key,
    required this.onNavigateToHome,
    required this.onNavigateToFavorites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: onNavigateToHome,
            icon: const Icon(Icons.home, color: Colors.white),
            tooltip: 'Home',
          ),
          IconButton(
            onPressed: onNavigateToFavorites,
            icon: const Icon(Icons.favorite, color: Colors.white),
            tooltip: 'Favorites',
          ),
        ],
      ),
    );
  }
}

