import 'package:ddd/general_widgets/icon_button_style.dart';
import 'package:ddd/model_provider/model_project.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColumnFooter extends StatelessWidget {
  /// Значение [bool] для отображения иконки при сворачивании.
  final bool isFlex;

  /// Имя колонки (варианты: 'anal', 'dev', 'test').
  final String nameColumn;

  /// Колличество разделов в коллонке.
  final int countIndex;

  /// Индекс текущего раздела коллонки.
  final int indexCurrentPartFeature;

  /// Футтер коллонки, содержащий пагинацию, кнопку добавления/удаления/изменения фичи.
  const ColumnFooter({
    required this.isFlex,
    required this.nameColumn,
    required this.countIndex,
    required this.indexCurrentPartFeature,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelProject>();
    return isFlex
        ? const Text('')
        : Expanded(
            child: Row(
              children: [
                const SizedBox(width: 5),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: countIndex,
                    itemBuilder: (BuildContext context, int index) {
                      return TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              (index == indexCurrentPartFeature)
                                  ? Colors.grey
                                  : Colors.white),
                        ),
                        onPressed: () =>
                            model.changePartFeature(index, nameColumn),
                        child: Text(
                          '${index + 1}',
                        ),
                      );
                    },
                  ),
                ),
                IconButtonStyle(
                  func: () => model.addPartFeature(nameColumn),
                  icon: Icons.add,
                  message: 'Добавить новую часть коллонки',
                ),
                IconButtonStyle(
                  func: () => model.deletePartFeature(nameColumn),
                  icon: Icons.delete,
                  message: 'Удалить текущую часть коллонки',
                ),
                IconButtonStyle(
                  func: () => model.editingColumn(nameColumn),
                  icon: Icons.create,
                  message: 'Изменить текст коллонки',
                ),
                const SizedBox(width: 5),
              ],
            ),
          );
  }
}
