import 'package:flutter/material.dart';
import 'presentation/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Movie',
      theme: movieDroidTheme,
      home: Scaffold(
        body: Center(
          child: Text('Flutter Movie Home', style: Theme.of(context).textTheme.bodyLarge),
        ),
      ),
    );
  }
}
