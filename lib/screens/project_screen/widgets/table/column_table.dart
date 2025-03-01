import 'package:ddd/model_provider/model.dart';
import 'package:ddd/screens/project_screen/widgets/table/column_body.dart';
import 'package:ddd/screens/project_screen/widgets/table/column_footer.dart';
import 'package:ddd/screens/project_screen/widgets/table/header_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

class ColumnTable extends StatelessWidget {
  /// Имя колонки (варианты: 'anal', 'dev', 'test').
  final String nameColumn;

  /// Значение [bool] для отображения иконки при сворачивании.
  final bool isFlex;

  /// Иконка при сворачивании коллонки.
  final IconData icon;

  /// Имя в хедере коллонки.
  final String dataTextNameColumn;

  /// [bool] значение чтобы перейти на изменение коллонки.
  final bool isReadNameColumn;

  /// [TextEditingController] для контроллера, чтобы изменять текст.
  final TextEditingController controller;

  /// Markdown [Widget] для отображения текста. (варианты: [MarkdownBody] , [Text]).
  final Widget markdown;

  /// Колличество разделов в коллонке.
  final int countIndex;

  /// Индекс текущего раздела коллонки.
  final int indexCurrentPartFeature;

  /// Коллонка таблицы.
  const ColumnTable({
    required this.nameColumn,
    required this.isFlex,
    required this.icon,
    required this.dataTextNameColumn,
    required this.isReadNameColumn,
    required this.controller,
    required this.markdown,
    required this.countIndex,
    required this.indexCurrentPartFeature,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();
    return Column(
      children: [
        HeaderColumn(
            isFlex: isFlex,
            icon: icon,
            nameColumn: nameColumn,
            dataTextNameColumn: dataTextNameColumn),
        Container(
          height: 1,
          color: Colors.black,
        ),
        ColumnBody(
          isFlex: isFlex,
          isReadNameColumn: isReadNameColumn,
          controller: controller,
          nameColumn: nameColumn,
          markdown: markdown,
          icon: Icons.save,
        ),
        ColumnFooter(
            isFlex: isFlex || model.indexCurrentFeature == null,
            nameColumn: nameColumn,
            countIndex: countIndex,
            indexCurrentPartFeature: indexCurrentPartFeature),
      ],
    );
  }
}
