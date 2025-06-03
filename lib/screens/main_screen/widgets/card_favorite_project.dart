import 'package:ddd/model_provider/model_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardFavoriteProject extends StatelessWidget {
  const CardFavoriteProject({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelMain>();
    return GridView.count(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 5,
      childAspectRatio: 3,
      children: List.generate(model.favoriteProjects.length, (index) {
        return Stack(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(color: Colors.black.withOpacity(0.2)),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Image.network(
                    'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          model.favoriteProjects[index].viewName,
                          overflow: TextOverflow.ellipsis,

                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Дата создания: ${model.favoriteProjects[index].dateTime}',
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Дата изменения: ${model.favoriteProjects[index].dateChange}',
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Описание: ${model.favoriteProjects[index].description}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 30),
                ],
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap:
                    () => Navigator.of(context).pushNamed(
                      '/project',
                      arguments: model.favoriteProjects[index].projectName,
                    ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed:
                        () => model.switchFavorite(
                          model.favoriteProjects[index].id,
                          index,
                          model.favoriteProjects[index].favorite,
                        ),
                    icon: const Icon(Icons.star),
                  ),
                  IconButton(
                    onPressed:
                        () => model.changeProject(
                          context: context,
                          project: model.favoriteProjects[index],
                          index: index,
                          favorite: model.favoriteProjects[index].favorite,
                        ),
                    icon: const Icon(Icons.create),
                  ),
                  IconButton(
                    onPressed: () {
                      model.deleteProject(
                        project: model.favoriteProjects[index],
                        index: index,
                        favorite: model.favoriteProjects[index].favorite,
                      );
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
