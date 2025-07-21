import 'package:ddd/general_widgets/icon_button_style.dart';
import 'package:ddd/screens/project_screen/model/model_project.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomButtonsLeftColumn extends StatelessWidget {
  /// Футер [ColumnLeft]. Содержит кнопки для
  /// добавления/удаления/изменения_названия фичей.
  const BottomButtonsLeftColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelProject>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButtonStyle(
          func: () => model.addFeature(context),
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
