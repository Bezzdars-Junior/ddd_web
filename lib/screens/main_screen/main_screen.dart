import 'package:ddd/model_provider/model_main.dart';
import 'package:ddd/screens/main_screen/widgets/body_main_screen.dart';
import 'package:ddd/screens/main_screen/widgets/footer_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider(
      create: (context) => ModelMain(),
      child: const Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(
                'Список проектов:',
                style: TextStyle(fontSize: 32),
              ),
              Expanded(child: BodyMainScreen()),
              FooterMainScreen()
            ],
          ),
        ),
      ),
    );
  }
}
