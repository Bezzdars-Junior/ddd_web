import 'package:ddd/general_widgets/icon_button_style.dart';
import 'package:ddd/model_provider/model_project.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonsSort extends StatelessWidget {
  /// Кнопки для сортировки списка фичей по имени и времени.
  const ButtonsSort({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelProject>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButtonStyle(
          func: model.sortListName,
          icon: Icons.abc,
          message: 'Сортировка по имени',
        ),
        IconButtonStyle(
          func: model.sortListTime,
          icon: Icons.lock_clock,
          message: 'Сортировка по времени',
        ),
      ],
    );
  }
}
