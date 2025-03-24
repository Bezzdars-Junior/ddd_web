import 'package:ddd/model_provider/model_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyMainScreen extends StatelessWidget {
  const BodyMainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelMain>();
    return FutureBuilder(
        future: model.initProjects(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
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
                        child: Text(model.projects[index].projectName),
                      ),
                      IconButton(
                          onPressed: () => model.deleteProject(index),
                          icon: const Icon(Icons.delete)),
                      IconButton(
                          onPressed: () => model.addFavorite(index),
                          icon: Icon((model.projects[index].favorite == 'true')
                              ? Icons.star
                              : Icons.star_outline))
                    ],
                  );
                });
          }
          return const CircularProgressIndicator();
        });
  }
}
