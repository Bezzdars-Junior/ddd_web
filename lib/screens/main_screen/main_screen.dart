import 'package:ddd/screens/main_screen/model/model_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_screen_body.dart';

/// Главная странница со списком проектов.
class MainScreen extends StatelessWidget {
  /// Конструктор [MainScreen].
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ModelMain(),
      child: const Scaffold(
        body: MainScreenBodyWidget(),
      ),
    );
  }
}
