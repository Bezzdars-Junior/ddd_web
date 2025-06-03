import 'package:ddd/model_provider/model_main.dart';
import 'package:ddd/screens/main_screen/widgets/header_main_screen.dart';
import 'package:ddd/screens/main_screen/widgets/list_favorite_projects.dart';
import 'package:ddd/screens/main_screen/widgets/list_projects.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Главная странница со списком проектов.
class MainScreen extends StatelessWidget {
  /// Конструктор [MainScreen].
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ModelMain(),
      child: const Scaffold(body: Center(child: FullScreen())),
    );
  }
}

class FullScreen extends StatelessWidget {
  const FullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelMain>();
    return FutureBuilder(
      future: model.initProjects(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return const Column(
            children: [
              Expanded(child: HeaderMainScreen()),
              Expanded(flex: 3, child: ListFavoriteProjects()),
              Expanded(flex: 7, child: ListProjects()),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
