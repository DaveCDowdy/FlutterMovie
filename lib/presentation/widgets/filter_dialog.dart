import 'package:flutter/material.dart';
import 'package:flutter_movie/presentation/model/movie_ui_state.dart';

class FilterDialog extends StatefulWidget {
  final MovieUiState uiState;
  final ValueChanged<String> onGenreSelected;
  final ValueChanged<String> onRatingSelected;

  const FilterDialog({
    super.key,
    required this.uiState,
    required this.onGenreSelected,
    required this.onRatingSelected,
  });

  static const List<String> genres = [
    'All', 'Drama', 'Fantasy', 'Horror', 'Action'
  ];
  static const List<String> ratings = [
    'All', 'Good', 'Ok', 'Bad'
  ];

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late String selectedGenre;
  late String selectedRating;

  @override
  void initState() {
    super.initState();
    selectedGenre = widget.uiState.selectedGenre;
    selectedRating = widget.uiState.selectedRating;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(
        'Filter Movies',
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Genre',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: FilterDialog.genres.map((genre) {
                final selected = selectedGenre == genre;
                return ChoiceChip(
                  label: Text(genre),
                  selected: selected,
                  onSelected: (_) {
                    setState(() {
                      selectedGenre = genre;
                    });
                  },
                  selectedColor: Theme.of(context).colorScheme.tertiary,
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  labelStyle: TextStyle(
                    color: selected
                        ? Theme.of(context).colorScheme.onTertiary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: selected
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.outline,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Text(
              'Rating',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: FilterDialog.ratings.map((rating) {
                final selected = selectedRating == rating;
                return ChoiceChip(
                  label: Text(rating),
                  selected: selected,
                  onSelected: (_) {
                    setState(() {
                      selectedRating = rating;
                    });
                  },
                  selectedColor: Theme.of(context).colorScheme.tertiary,
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  labelStyle: TextStyle(
                    color: selected
                        ? Theme.of(context).colorScheme.onTertiary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: selected
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.outline,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Close', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        ),
        TextButton(
          onPressed: () {
            widget.onGenreSelected(selectedGenre);
            widget.onRatingSelected(selectedRating);
            Navigator.of(context).pop();
          },
          child: Text('Done', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        ),
      ],
    );
  }
}
