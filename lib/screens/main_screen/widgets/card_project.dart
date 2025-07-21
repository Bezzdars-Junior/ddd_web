import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../entity/project.dart';
import '../model/model_main.dart';

class CardProject extends StatelessWidget {
  final int index;
  final List<Project> projects;
  const CardProject({
    required this.index,
    required this.projects,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelMain>();
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(color: Colors.black.withValues(alpha: 0.2)),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Image.network(
                'https://media1.tenor.com/m/BSYeNq2POsQAAAAC/gachimuchi.gif',
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
                      projects[index].projectName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Дата создания: ${DateFormat('dd.MM.yyyy').format(DateTime.parse(projects[index].dateTime))}',
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Дата изменения: ${DateFormat('dd.MM.yyyy').format(DateTime.parse(projects[index].dateChange))}',
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Описание: ${projects[index].description}',
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
            onTap: () => Navigator.of(context).pushNamed(
              '/project',
              arguments: projects[index].projectName,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => model.switchFavourite(projects[index], index),
                icon: (projects[index].favourite)
                    ? const Icon(Icons.star)
                    : const Icon(Icons.star_outline),
              ),
              IconButton(
                onPressed: () => model.changeProject(
                  context: context,
                  project: projects[index],
                  index: index,
                ),
                icon: const Icon(Icons.create),
              ),
              IconButton(
                onPressed: () {
                  model.deleteProject(
                    project: projects[index],
                    index: index,
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
