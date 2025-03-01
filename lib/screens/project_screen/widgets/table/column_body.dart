import 'package:ddd/general_widgets/icon_button_style.dart';
import 'package:ddd/model_provider/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColumnBody extends StatelessWidget {
  /// Значение [bool] для отображения иконки при сворачивании.
  final bool isFlex;

  /// [bool] значение чтобы перейти на изменение коллонки.
  final bool isReadNameColumn;

  /// [TextEditingController] для контроллера, чтобы изменять текст.
  final TextEditingController controller;

  /// Имя колонки (варианты: 'anal', 'dev', 'test').
  final String nameColumn;

  /// Markdown [Widget] для отображения текста. (варианты: [MarkdownBody] , [Text]).
  final Widget markdown;

  /// Иконка при сворачивании коллонки.
  final IconData icon;

  /// Тело коллонки, содержащей текст коллонки и [TextField] для изменния текста.
  const ColumnBody({
    required this.isFlex,
    required this.isReadNameColumn,
    required this.controller,
    required this.nameColumn,
    required this.markdown,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();
    return isFlex
        ? const Text('')
        : isReadNameColumn
            ? Expanded(
                flex: 15,
                child: ListView(
                  children: [
                    Center(
                      child: markdown,
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  TextField(
                    controller: controller,
                    maxLines: 33,
                  ),
                  IconButtonStyle(
                    func: () => model.saveEditedColumn(nameColumn),
                    icon: icon,
                    message: 'Сохранить изменения текста',
                  )
                ],
              );
  }
}
