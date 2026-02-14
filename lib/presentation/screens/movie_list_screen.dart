import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_movie/presentation/model/movie_ui_state.dart';
import 'package:flutter_movie/presentation/providers/movie_viewmodel_provider.dart';
import 'package:flutter_movie/domain/entities/movie.dart';
import 'package:flutter_movie/presentation/widgets/bottom_bar.dart';
import 'package:flutter_movie/presentation/widgets/movie_list_item.dart';
import 'package:flutter_movie/presentation/widgets/filter_dialog.dart';
import 'package:flutter_movie/presentation/widgets/app_logo.dart';

class MovieListScreen extends ConsumerWidget {
  final VoidCallback? onNavigateToHome;
  final VoidCallback? onNavigateToFavorites;

  const MovieListScreen({
    super.key,
    this.onNavigateToHome,
    this.onNavigateToFavorites,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(movieViewModelProvider);
    final viewModel = ref.read(movieViewModelProvider.notifier);

    return _MovieListScreenContent(
      uiState: uiState,
      onSearchQueryChange: viewModel.onSearchQueryChange,
      onToggleFavorite: viewModel.toggleFavorite,
      onShowFilterDialog: () {
        showDialog(
          context: context,
          builder: (dialogContext) => FilterDialog(
            uiState: uiState,
            onGenreSelected: viewModel.onGenreSelected,
            onRatingSelected: viewModel.onRatingSelected,
          ),
        );
      },
      onNavigateToHome: onNavigateToHome ?? () {},
      onNavigateToFavorites: onNavigateToFavorites ?? () {},
    );
  }
}

class _MovieListScreenContent extends StatefulWidget {
  final MovieUiState uiState;
  final ValueChanged<String> onSearchQueryChange;
  final ValueChanged<Movie> onToggleFavorite;
  final VoidCallback onShowFilterDialog;
  final VoidCallback onNavigateToHome;
  final VoidCallback onNavigateToFavorites;

  const _MovieListScreenContent({
    required this.uiState,
    required this.onSearchQueryChange,
    required this.onToggleFavorite,
    required this.onShowFilterDialog,
    required this.onNavigateToHome,
    required this.onNavigateToFavorites,
  });

  @override
  State<_MovieListScreenContent> createState() => _MovieListScreenContentState();
}

class _MovieListScreenContentState extends State<_MovieListScreenContent> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.uiState.searchQuery);
  }

  @override
  void didUpdateWidget(covariant _MovieListScreenContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.uiState.searchQuery != _controller.text) {
      _controller.text = widget.uiState.searchQuery;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onShowFilterDialog,
        backgroundColor: Colors.grey[900],
        child: const Icon(Icons.filter_list),
      ),
      bottomNavigationBar: BottomBar(
        onNavigateToHome: widget.onNavigateToHome,
        onNavigateToFavorites: widget.onNavigateToFavorites,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AppLogo(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Card(
                  color: Colors.grey[900],
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: TextField(
                      controller: _controller,
                      onChanged: widget.onSearchQueryChange,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        labelStyle: TextStyle(color: Colors.white70),
                        prefixIcon: Icon(Icons.search, color: Colors.white70),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: false,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: widget.uiState.isLoading
                ? ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: 5,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, __) => Container(
                      height: 200,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: widget.uiState.movies.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final movie = widget.uiState.movies[index];
                      return MovieListItem(
                        movie: movie,
                        onToggleFavorite: widget.onToggleFavorite,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
