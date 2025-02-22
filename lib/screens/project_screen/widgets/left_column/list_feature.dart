import 'package:ddd/model_provider/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListFeature extends StatelessWidget {
  ///  Боди виджета [LeftColumn]. Список с доступными фичами проекта.
  const ListFeature({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();
    return ListView.builder(
      itemCount: model.features.length,
      itemBuilder: (BuildContext context, int index) {
        return TextButton(
          onPressed: () {
            model.changeFeature(index);
          },
          child: Text(model.features[index].featureName),
        );
      },
    );
  }
}
