import 'package:ddd/modelProvider/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

class TableProjectScreen extends StatelessWidget {
  const TableProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();
    return Row(
      children: [
        Expanded(
          flex: model.flexAnal,
          child: Column(
            children: [
              (model.flexDev == 20 && model.flexTest == 20) ||
                      (model.flexDev == 20 &&
                          model.flexTest == 1 &&
                          model.flexAnal == 1) ||
                      (model.flexDev == 1 &&
                          model.flexTest == 20 &&
                          model.flexAnal == 1)
                  ? IconButton(
                      onPressed: () => model.changeFlex('anal'),
                      icon: Icon(Icons.analytics))
                  : TextButton(
                      child: Text(
                        'Аналитика',
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis, fontSize: 20),
                      ),
                      onPressed: () => model.changeFlex('anal')),
              Container(
                height: 1,
                color: Colors.black,
              ),
              (model.flexDev == 20 && model.flexTest == 20) ||
                      (model.flexDev == 20 &&
                          model.flexTest == 1 &&
                          model.flexAnal == 1) ||
                      (model.flexDev == 1 &&
                          model.flexTest == 20 &&
                          model.flexAnal == 1)
                  ? Text('')
                  : model.readAnal
                      ? Expanded(
                          flex: 15,
                          child: ListView(
                            children: [
                              Center(
                                child: MarkdownBody(
                                  data:
                                      (model.indexCurrentFeature == null)
                                          ? 'Выбери фичу'
                                          : model
                                                  .features[model
                                                      .indexCurrentFeature!]
                                                  .anal[
                                              model
                                                  .indexCurrentPartAnalFeature],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            TextField(
                              controller: model.controllerAnal,
                              maxLines: 33,
                            ),
                            IconButton(
                                onPressed: () => model.saveEditedColumn('anal'),
                                icon: Icon(Icons.save))
                          ],
                        ),
              (model.flexDev == 20 && model.flexTest == 20) ||
                      (model.flexDev == 20 &&
                          model.flexTest == 1 &&
                          model.flexAnal == 1) ||
                      (model.flexDev == 1 &&
                          model.flexTest == 20 &&
                          model.flexAnal == 1) ||
                      model.indexCurrentFeature == null
                  ? Text('')
                  : Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: (model.indexCurrentFeature == null)
                                  ? 1
                                  : model.features[model.indexCurrentFeature!]
                                      .anal.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                        (index ==
                                                model
                                                    .indexCurrentPartAnalFeature)
                                            ? Colors.grey
                                            : Colors.white),
                                  ),
                                  onPressed: () =>
                                      model.changePartFeature(index, 'anal'),
                                  child: Text(
                                    '${index + 1}',
                                  ),
                                );
                              },
                            ),
                          ),
                          IconButton(
                              onPressed: () => model.addPartFeature('anal'),
                              icon: Icon(Icons.plus_one)),
                          IconButton(
                              onPressed: () => model.deletePartFeature('anal'),
                              icon: Icon(Icons.delete)),
                          IconButton(
                              onPressed: () => model.editingColumn('anal'),
                              icon: Icon(Icons.create)),
                        ],
                      ),
                    )
            ],
          ),
        ),
        Container(
          color: Colors.black,
          width: 1,
          height: double.infinity,
        ),

        /// Колонка разработки
        Expanded(
          flex: model.flexDev,
          child: Column(
            children: [
              (model.flexAnal == 20 && model.flexTest == 20) ||
                      (model.flexAnal == 20 &&
                          model.flexTest == 1 &&
                          model.flexDev == 1) ||
                      (model.flexAnal == 1 &&
                          model.flexTest == 20 &&
                          model.flexDev == 1)
                  ? IconButton(
                      onPressed: () => model.changeFlex('dev'),
                      icon: Icon(Icons.developer_board))
                  : TextButton(
                      child: Text(
                        'Разработка',
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis, fontSize: 20),
                      ),
                      onPressed: () => model.changeFlex('dev')),
              Container(
                height: 1,
                color: Colors.black,
              ),
              (model.flexAnal == 20 && model.flexTest == 20) ||
                      (model.flexAnal == 20 &&
                          model.flexTest == 1 &&
                          model.flexDev == 1) ||
                      (model.flexAnal == 1 &&
                          model.flexTest == 20 &&
                          model.flexDev == 1)
                  ? Text('')
                  : model.readDev
                      ? Expanded(
                          flex: 15,
                          child: ListView(
                            children: [
                              Center(
                                child: Text(model.indexCurrentFeature == null
                                    ? 'Выбери фичу'
                                    : model.features[model.indexCurrentFeature!]
                                        .dev[model.indexCurrentPartDevFeature]),
                              )
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            TextField(
                              controller: model.controllerDev,
                              maxLines: 35,
                            ),
                            IconButton(
                                onPressed: () {
                                  model.saveEditedColumn('dev');
                                },
                                icon: Icon(Icons.save))
                          ],
                        ),
              (model.flexAnal == 20 && model.flexTest == 20) ||
                      (model.flexAnal == 20 &&
                          model.flexTest == 1 &&
                          model.flexDev == 1) ||
                      (model.flexAnal == 1 &&
                          model.flexTest == 20 &&
                          model.flexDev == 1) ||
                      model.indexCurrentFeature == null
                  ? Text('')
                  : Expanded(
                      child: Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (model.indexCurrentFeature == null)
                                ? 1
                                : model.features[model.indexCurrentFeature!].dev
                                    .length,
                            itemBuilder: (BuildContext context, int index) {
                              return TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                        (index ==
                                                model
                                                    .indexCurrentPartDevFeature)
                                            ? Colors.grey
                                            : Colors.white),
                                  ),
                                  onPressed: () =>
                                      model.changePartFeature(index, 'dev'),
                                  child: Text('${index + 1}'));
                            },
                          ),
                        ),
                        IconButton(
                            onPressed: () => model.addPartFeature('dev'),
                            icon: Icon(Icons.plus_one)),
                        IconButton(
                            onPressed: () => model.deletePartFeature('dev'),
                            icon: Icon(Icons.delete)),
                        IconButton(
                            onPressed: () => model.editingColumn('dev'),
                            icon: Icon(Icons.create)),
                      ],
                    ))
            ],
          ),
        ),
        Container(
          color: Colors.black,
          width: 1,
          height: double.infinity,
        ),
        Expanded(
          flex: model.flexTest,
          child: Column(
            children: [
              (model.flexAnal == 20 && model.flexDev == 20) ||
                      (model.flexAnal == 20 &&
                          model.flexDev == 1 &&
                          model.flexTest == 1) ||
                      (model.flexAnal == 1 &&
                          model.flexDev == 20 &&
                          model.flexTest == 1)
                  ? IconButton(
                      onPressed: () => model.changeFlex('test'),
                      icon: Icon(Icons.article))
                  : TextButton(
                      child: Text(
                        'Тестирование',
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis, fontSize: 20),
                      ),
                      onPressed: () => model.changeFlex('test')),
              Container(
                height: 1,
                color: Colors.black,
              ),
              (model.flexAnal == 20 && model.flexDev == 20) ||
                      (model.flexAnal == 20 &&
                          model.flexDev == 1 &&
                          model.flexTest == 1) ||
                      (model.flexAnal == 1 &&
                          model.flexDev == 20 &&
                          model.flexTest == 1)
                  ? const Text('')
                  : model.readTest
                      ? Expanded(
                          flex: 15,
                          child: ListView(
                            children: [
                              Center(
                                child: Text(model.indexCurrentFeature == null
                                    ? 'Выбери фичу'
                                    : model.features[model.indexCurrentFeature!]
                                            .test[
                                        model.indexCurrentPartTestFeature]),
                              )
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            TextField(
                              controller: model.controllerTest,
                              maxLines: 35,
                            ),
                            IconButton(
                                onPressed: () => model.saveEditedColumn('test'),
                                icon: Icon(Icons.save)),
                          ],
                        ),
              (model.flexAnal == 20 && model.flexDev == 20) ||
                      (model.flexAnal == 20 &&
                          model.flexDev == 1 &&
                          model.flexTest == 1) ||
                      (model.flexAnal == 1 &&
                          model.flexDev == 20 &&
                          model.flexTest == 1) ||
                      model.indexCurrentFeature == null
                  ? Text('')
                  : Expanded(
                      child: Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (model.indexCurrentFeature == null)
                                ? 1
                                : model.features[model.indexCurrentFeature!]
                                    .test.length,
                            itemBuilder: (BuildContext context, int index) {
                              return TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                        (index ==
                                                model
                                                    .indexCurrentPartTestFeature)
                                            ? Colors.grey
                                            : Colors.white),
                                  ),
                                  onPressed: () =>
                                      model.changePartFeature(index, 'test'),
                                  child: Text('${index + 1}'));
                            },
                          ),
                        ),
                        IconButton(
                            onPressed: () => model.addPartFeature('test'),
                            icon: Icon(Icons.plus_one)),
                        IconButton(
                            onPressed: () => model.deletePartFeature('test'),
                            icon: Icon(Icons.delete)),
                        IconButton(
                            onPressed: () => model.editingColumn('test'),
                            icon: Icon(Icons.create)),
                      ],
                    ))
            ],
          ),
        ),
      ],
    );
  }
}
