import 'package:ddd/model_provider/model_project.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListFeature extends StatelessWidget {
  ///  Тело виджета [LeftColumn]. Содержит список с доступными фичами проекта.
  const ListFeature({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelProject>();
    return ListView.builder(
      itemCount: model.features.length,
      itemBuilder: (BuildContext context, int index) {
        return Tooltip(
          message: model.features[index].featureName,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    model.changeFeature(index);
                  },
                  child: Text(
                    model.features[index].featureName,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
              ),
              if (model.features[index].favorite == 'true')
                const Icon(Icons.star),
            ],
          ),
        );
      },
    );
  }
}
