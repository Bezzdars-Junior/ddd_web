import 'package:ddd/model_provider/model_main.dart';
import 'package:ddd/screens/main_screen/widgets/list_projects.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyMainScreen extends StatelessWidget {
  /// Body со списком проектов на главной странице приложения.
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
            return const ListProjects();
          }
          return const CircularProgressIndicator();
        });
  }
}
