import 'package:ddd/general_widgets/icon_button_style.dart';
import 'package:ddd/model_provider/model_project.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderLeftColumn extends StatelessWidget {
  /// Хедер виджета [LeftColumn]. Содержит в себе название фичи,
  /// кнопку избранного и [TextField] для изменения названия.
  const HeaderLeftColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelProject>();
    String nameFeature = (model.indexCurrentFeature == null)
        ? 'Выбери фичу'
        : model.features[model.indexCurrentFeature!].featureName;
    model.controllerFeatureName.text = nameFeature;
    return SizedBox(
      height: 50,
      child: Center(
        child: model.readNameFeature
            ? Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Tooltip(
                        message: nameFeature,
                        child: Text(
                          nameFeature,
                          style: const TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButtonStyle(
                    func: model.addFavorite,
                    icon: Icons.star_outline,
                    message: 'Добавить в избранное',
                  )
                ],
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
