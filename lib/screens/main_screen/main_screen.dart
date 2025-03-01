import 'package:flutter/material.dart';

/// Главная странница со списком проектов.
class MainScreen extends StatefulWidget {
  /// Конструктор [MainScreen].
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/project'),
                child: const Text('Project'))
          ],
        ),
      ),
    );
  }
}
