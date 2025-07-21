import 'package:ddd/screens/project_screen/model/model_project.dart';
import 'package:ddd/screens/project_screen/widgets/table/column_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

class TableProjectScreen extends StatelessWidget {
  /// Три коллонки (Аналитика, Разработка и Тестирование)
  /// с текстом, названием и кнопками взаимодействия.
  const TableProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelProject>();
    final bool isFlexAnal = (model.flexDev == 20 && model.flexTest == 20) ||
        (model.flexDev == 20 && model.flexTest == 1 && model.flexAnal == 1) ||
        (model.flexDev == 1 && model.flexTest == 20 && model.flexAnal == 1);
    final bool isFlexDev = (model.flexAnal == 20 && model.flexTest == 20) ||
        (model.flexAnal == 20 && model.flexTest == 1 && model.flexDev == 1) ||
        (model.flexAnal == 1 && model.flexTest == 20 && model.flexDev == 1);
    final bool isFlexTest = (model.flexAnal == 20 && model.flexDev == 20) ||
        (model.flexAnal == 20 && model.flexDev == 1 && model.flexTest == 1) ||
        (model.flexAnal == 1 && model.flexDev == 20 && model.flexTest == 1);
    return Row(
      children: [
        Expanded(
          flex: model.flexAnal,
          child: ColumnTable(
            nameColumn: 'anal',
            isFlex: isFlexAnal,
            icon: Icons.analytics,
            dataTextNameColumn: 'Аналитика',
            isReadNameColumn: model.readAnal,
            controller: model.controllerAnal,
            markdown: MarkdownBody(
              data: (model.indexCurrentFeature == null)
                  ? 'Выбери фичу'
                  : model.features[model.indexCurrentFeature!]
                      .anal[model.indexCurrentPartAnalFeature],
            ),
            countIndex: (model.indexCurrentFeature == null)
                ? 1
                : model.features[model.indexCurrentFeature!].anal.length,
            indexCurrentPartFeature: model.indexCurrentPartAnalFeature,
          ),
        ),
        Container(
          color: Colors.black,
          width: 1,
          height: double.infinity,
        ),
        Expanded(
          flex: model.flexDev,
          child: ColumnTable(
            nameColumn: 'dev',
            isFlex: isFlexDev,
            icon: Icons.developer_board,
            dataTextNameColumn: 'Разработка',
            isReadNameColumn: model.readDev,
            controller: model.controllerDev,
            markdown: Text(model.indexCurrentFeature == null
                ? 'Выбери фичу'
                : model.features[model.indexCurrentFeature!]
                    .dev[model.indexCurrentPartDevFeature]),
            countIndex: (model.indexCurrentFeature == null)
                ? 1
                : model.features[model.indexCurrentFeature!].dev.length,
            indexCurrentPartFeature: model.indexCurrentPartDevFeature,
          ),
        ),
        Container(
          color: Colors.black,
          width: 1,
          height: double.infinity,
        ),
        Expanded(
          flex: model.flexTest,
          child: ColumnTable(
            nameColumn: 'test',
            isFlex: isFlexTest,
            icon: Icons.article,
            dataTextNameColumn: 'Тестирование',
            isReadNameColumn: model.readTest,
            controller: model.controllerTest,
            markdown: Text(model.indexCurrentFeature == null
                ? 'Выбери фичу'
                : model.features[model.indexCurrentFeature!]
                    .test[model.indexCurrentPartTestFeature]),
            countIndex: (model.indexCurrentFeature == null)
                ? 1
                : model.features[model.indexCurrentFeature!].test.length,
            indexCurrentPartFeature: model.indexCurrentPartTestFeature,
          ),
        ),
      ],
    );
  }
}
