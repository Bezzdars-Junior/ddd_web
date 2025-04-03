import 'package:ddd/model_provider/model_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListProjects extends StatelessWidget {
  /// [ListView] со списком проектов и кнопками для удаления, изменния имени проекта и добавлением/удалением признака [favorite].
  const ListProjects({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelMain>();
    return ListView.builder(
        itemCount: model.projects.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/project',
                      arguments: model.projects[index].projectName);
                },
                child: Text(model.projects[index].viewName),
              ),
              IconButton(
                  onPressed: () => model.renameProject(
                        context: context,
                        project: model.projects[index],
                        index: index,
                      ),
                  icon: const Icon(Icons.create)),
              IconButton(
                  onPressed: () => model.deleteProject(
                        project: model.projects[index],
                        index: index,
                      ),
                  icon: const Icon(Icons.delete)),
              IconButton(
                  onPressed: () =>
                      model.switchFavorite(model.projects[index].id, index),
                  icon: Icon((model.projects[index].favorite == 'true')
                      ? Icons.star
                      : Icons.star_outline))
            ],
          );
        });
  }
}
