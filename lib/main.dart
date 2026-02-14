import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/theme/app_theme.dart';
import 'presentation/navigation/main_navigation.dart';
import 'data/db/app_database.dart';
import 'presentation/providers/movie_repository_provider.dart';

late final AppDatabase appDatabase;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  appDatabase = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(appDatabase),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Movie',
      theme: movieDroidTheme,
      home: const MainNavigation(),
    );
  }
}
