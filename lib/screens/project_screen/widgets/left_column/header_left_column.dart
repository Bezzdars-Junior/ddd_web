import 'package:ddd/model_provider/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderLeftColumn extends StatelessWidget {
  /// Хедер виджета [LeftColumn].
  const HeaderLeftColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();
    String nameFeature = (model.indexCurrentFeature == null)
        ? 'Выбери фичу'
        : model.features[model.indexCurrentFeature!].featureName;
    model.controllerFeatureName.text = nameFeature;
    return SizedBox(
      height: 50,
      child: Center(
        child: model.readNameFeature
            ? Tooltip(
                message: nameFeature,
                child: Text(
                  nameFeature,
                  style: const TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    overflow: TextOverflow.ellipsis,
                  ),
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
              ),
      ),
    );
  }
}
