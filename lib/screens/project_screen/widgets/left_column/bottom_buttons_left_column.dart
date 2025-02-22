import 'package:ddd/general_widgets/icon_button_style.dart';
import 'package:ddd/model_provider/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomButtonsLeftColumn extends StatelessWidget {
  /// Футер [ColumnLeft]. Кнопки для взаимодействия с фичами.
  const BottomButtonsLeftColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //TODO: Реализовать эту фичу
        IconButtonStyle(
          func: () {},
          icon: Icons.add,
          message: 'Добавить новую фичу',
        ),
        IconButtonStyle(
          func: model.deleteCurrentFeature,
          icon: Icons.delete,
          message: 'Удалить текущую фичу',
        ),
        IconButtonStyle(
          func: model.editingNameFeature,
          icon: Icons.create,
          message: 'Изменить название текущей фичи',
        ),
      ],
    );
  }
}
