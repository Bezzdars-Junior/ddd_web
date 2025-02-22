import 'package:ddd/modelProvider/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderLeftColumn extends StatelessWidget {
  /// Хедер виджета [LeftColumn].
  const HeaderLeftColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();

    //TODO: убрать отсюда логику
    String nameFeature = (model.indexCurrentFeature == null)
        ? 'Выбери фичу'
        : model.features[model.indexCurrentFeature!].featureName;
    model.controllerFeatureName.text = nameFeature;
    return model.readNameFeature
        ? Text(
            nameFeature,
            style: const TextStyle(
              fontSize: 14,
              overflow: TextOverflow.ellipsis,
            ),
          )
        : Row(
            children: [
              Expanded(
                child: TextField(controller: model.controllerFeatureName),
              ),
              IconButton(
                onPressed: model.saveEditedNameFeature,
                icon: const Icon(Icons.check),
              ),
            ],
          );
  }
}
