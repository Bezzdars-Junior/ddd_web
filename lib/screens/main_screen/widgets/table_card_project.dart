import 'package:flutter/material.dart';

import '../entity/project.dart';
import 'card_project.dart';

class TableCardProject extends StatelessWidget {
  final List<Project> projects;
  const TableCardProject({
    required this.projects,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 5,
      childAspectRatio: 3,
      children: List.generate(projects.length, (index) {
        return CardProject(
          index: index,
          projects: projects,
        );
      }),
    );
  }
}
