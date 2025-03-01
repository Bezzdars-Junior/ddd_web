import 'package:ddd/general_widgets/icon_button_style.dart';
import 'package:ddd/model_provider/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderColumn extends StatelessWidget {
  /// Значение [bool] для отображения иконки при сворачивании.
  final bool isFlex;

  /// Иконка при сворачивании коллонки.
  final IconData icon;

  /// Имя колонки (варианты: 'anal', 'dev', 'test').
  final String nameColumn;

  /// Имя в хедере коллонки.
  final String dataTextNameColumn;

  /// Хедер коллонки, содержащий название и иконки с возможностью сворачиваться/разворачиваться.
  const HeaderColumn({
    required this.isFlex,
    required this.icon,
    required this.nameColumn,
    required this.dataTextNameColumn,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();
    return SizedBox(
      height: 50,
      child: isFlex
          ? IconButtonStyle(
              func: () => model.changeFlex(nameColumn),
              icon: icon,
              message: 'Раскрыть/свернуть коллонку',
            )
          : Tooltip(
              message: 'Раскрыть/свернуть коллонку',
              child: TextButton(
                child: Text(
                  dataTextNameColumn,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 20,
                  ),
                ),
                onPressed: () => model.changeFlex(nameColumn),
              ),
            ),
    );
  }
}
