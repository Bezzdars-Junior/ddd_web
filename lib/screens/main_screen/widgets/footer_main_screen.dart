import 'package:ddd/model_provider/model_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FooterMainScreen extends StatelessWidget {
  /// Footer главное страницы приложения, где хранится кнопка для добавления проекта.
  const FooterMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelMain>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () => model.addProject(context),
            icon: const Icon(Icons.add)),
      ],
    );
  }
}
